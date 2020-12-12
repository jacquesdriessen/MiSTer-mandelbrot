//============================================================================
//
//  This program is free software; you can redistribute it and/or modify it
//  under the terms of the GNU General Public License as published by the Free
//  Software Foundation; either version 2 of the License, or (at your option)
//  any later version.
//
//  This program is distributed in the hope that it will be useful, but WITHOUT
//  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
//  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
//  more details.
//
//  You should have received a copy of the GNU General Public License along
//  with this program; if not, write to the Free Software Foundation, Inc.,
//  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
//
//============================================================================

`default_nettype none

parameter lastcore = 19; // needs to be minimal 1 (e.g. two core), for whatever reason things seem to be running (through the pipeline), but I don't see output on screen
// to get to "20 cores", need to have the optimization set to area, not for speed (https://www.intel.com/content/www/us/en/programmable/quartushelp/13.0/mergedProjects/msgs/msgs/efitapi_fitapi_vpr_status_failed_too_many_cbes.htm)


module emu
(
	//Master input clock
	input         CLK_50M,

	//Async reset from top-level module.
	//Can be used as initial reset.
	input         RESET,

	//Must be passed to hps_io module
	inout  [45:0] HPS_BUS,

	//Base video clock. Usually equals to CLK_SYS.
	output        CLK_VIDEO,

	//Multiple resolutions are supported using different CE_PIXEL rates.
	//Must be based on CLK_VIDEO
	output        CE_PIXEL,

	//Video aspect ratio for HDMI. Most retro systems have ratio 4:3.
	output [11:0] VIDEO_ARX,
	output [11:0] VIDEO_ARY,

	
	output  [7:0] VGA_R,
	output  [7:0] VGA_G,
	output  [7:0] VGA_B,
	output        VGA_HS,
	output        VGA_VS,
	output        VGA_DE,    // = ~(VBlank | HBlank)
	output        VGA_F1,
	output [1:0]  VGA_SL,
	output        VGA_SCALER, // Force VGA scaler

	
	// Use framebuffer from DDRAM (USE_FB=1 in qsf)
	// FB_FORMAT:
	//    [2:0] : 011=8bpp(palette) 100=16bpp 101=24bpp 110=32bpp
	//    [3]   : 0=16bits 565 1=16bits 1555
	//    [4]   : 0=RGB  1=BGR (for 16/24/32 modes)
	//
	// FB_STRIDE either 0 (rounded to 256 bytes) or multiple of 16 bytes.
	output        FB_EN,
	output  [4:0] FB_FORMAT,
	output [11:0] FB_WIDTH,
	output [11:0] FB_HEIGHT,
	output [31:0] FB_BASE,
	output [13:0] FB_STRIDE,
	input         FB_VBL,
	input         FB_LL,
	output        FB_FORCE_BLANK,

	// Palette control for 8bit modes.
	// Ignored for other video modes.
	output        FB_PAL_CLK,
	output  [7:0] FB_PAL_ADDR,
	output [23:0] FB_PAL_DOUT,
	input  [23:0] FB_PAL_DIN,
	output        FB_PAL_WR,

	output        LED_USER,  // 1 - ON, 0 - OFF.

	// b[1]: 0 - LED status is system status OR'd with b[0]
	//       1 - LED status is controled solely by b[0]
	// hint: supply 2'b00 to let the system control the LED.
	output  [1:0] LED_POWER,
	output  [1:0] LED_DISK,

	// I/O board button press simulation (active high)
	// b[1]: user button
	// b[0]: osd button
	output  [1:0] BUTTONS,

	input         CLK_AUDIO, // 24.576 MHz
	output [15:0] AUDIO_L,
	output [15:0] AUDIO_R,
	output        AUDIO_S,   // 1 - signed audio samples, 0 - unsigned
	output  [1:0] AUDIO_MIX, // 0 - no mix, 1 - 25%, 2 - 50%, 3 - 100% (mono)

	//ADC
	inout   [3:0] ADC_BUS,

	//SD-SPI
	output        SD_SCK,
	output        SD_MOSI,
	input         SD_MISO,
	output        SD_CS,
	input         SD_CD,

	//High latency DDR3 RAM interface
	//Use for non-critical time purposes
	output        DDRAM_CLK,
	input         DDRAM_BUSY,
	output  [7:0] DDRAM_BURSTCNT,
	output [28:0] DDRAM_ADDR,
	input  [63:0] DDRAM_DOUT,
	input         DDRAM_DOUT_READY,
	output        DDRAM_RD,
	output [63:0] DDRAM_DIN,
	output  [7:0] DDRAM_BE,
	output        DDRAM_WE,

	//SDRAM interface with lower latency
	output        SDRAM_CLK,
	output        SDRAM_CKE,
	output [12:0] SDRAM_A,
	output  [1:0] SDRAM_BA,
	inout  [15:0] SDRAM_DQ,
	output        SDRAM_DQML,
	output        SDRAM_DQMH,
	output        SDRAM_nCS,
	output        SDRAM_nCAS,
	output        SDRAM_nRAS,
	output        SDRAM_nWE,

	input         UART_CTS,
	output        UART_RTS,
	input         UART_RXD,
	output        UART_TXD,
	output        UART_DTR,
	input         UART_DSR,

	// Open-drain User port.
	// 0 - D+/RX
	// 1 - D-/TX
	// 2..6 - USR2..USR6
	// Set USER_OUT to 1 to read from USER_IN.
	input   [6:0] USER_IN,
	output  [6:0] USER_OUT,

	input         OSD_STATUS
);

///////// Default values for ports not used in this core /////////

assign ADC_BUS  = 'Z;
assign USER_OUT = '1;
assign {UART_RTS, UART_TXD, UART_DTR} = 0;
assign {SD_SCK, SD_MOSI, SD_CS} = 'Z;
assign {SDRAM_DQ, SDRAM_A, SDRAM_BA, SDRAM_CLK, SDRAM_CKE, SDRAM_DQML, SDRAM_DQMH, SDRAM_nWE, SDRAM_nCAS, SDRAM_nRAS, SDRAM_nCS} = 'Z;
assign {CE_PIXEL} = 0;
assign {FB_PAL_CLK, FB_PAL_ADDR, FB_PAL_DOUT, FB_PAL_WR} = 0;
assign {VGA_SL, VGA_F1, VGA_SCALER, VGA_R, VGA_G, VGA_B, VGA_SL, VGA_HS, VGA_VS, VGA_DE} = 0;

//
// Set up all HDMI related stuff
//
// video doesn't work without a clock, use the 20Mhz clock for this!
assign CLK_VIDEO 			= clk_video;
// set up framebuffer
assign FB_EN 				= 1'b1;
assign FB_FORMAT 			= 5'b01100;
assign FB_WIDTH 			= 12'd1920;
assign FB_HEIGHT 			= 12'd1080;
assign FB_BASE 			= 32'h20000000;
assign FB_STRIDE 			= 14'd4096; // 2048 pixels * 2 bytes per pixel
assign FB_FORCE_BLANK 	= 1'b0;
//HDMI only - native AR
assign VIDEO_ARX 			= 12'd0;
assign VIDEO_ARY 			= 12'd0;
//Couldn't make 32 bit work, screen wrapped around.
//assign FB_FORMAT = 5'b00110; / for whatever reason pixels bottom of the screen (looks like beyond 2 megapixesl) wrapped around.
//assign FB_STRIDE = 14'd8192; // 2048 pixels * 4 bytes per pixel // for whatever reason pixels bottom of the screen (looks like beyond 2 megapixesl) wrapped around.



assign AUDIO_S 			= 0;
assign AUDIO_L 			= 0;
assign AUDIO_R 			= 0;
assign AUDIO_MIX 			= 0;

assign LED_DISK 			= 0;
assign LED_POWER 			= 0;
assign BUTTONS 			= 0;

//////////////////////////////////////////////////////////////////

`include "build_id.v" 
localparam CONF_STR = {
	"Mandelbrot;;",
	"-;",
	"O12,Iterations,15/511,31/1023,63/2047,127/255;",
	"O3,Iterations,left value,right value;",
	"O56,Colour scheme, Pretty, Per Core, Flat;", 
	"O78,Flat Colour,White,Red,Green,Blue;",
	"P1,Cores 0-3;",
	"P1-;",
	"P1-, -= Cores 0-3 =-;",
	"P1-;",
   "P1O9,Core0,Running,Paused;",
   "P1OA,Core1,Running,Paused;",
   "P1OB,Core2,Running,Paused;",
   "P1OC,Core3,Running,Paused;",
	"P1-;",
	"P2,Cores 4-7;",
	"P2-;",
	"P2-, -= Cores 4-7 =-;",
	"P2-;",
   "P2OD,Core4,Running,Paused;",
   "P2OE,Core5,Running,Paused;",
   "P2OF,Core6,Running,Paused;",
   "P2OG,Core7,Running,Paused;",
	"P2-;",
	"P3,Cores 8-11;",
	"P3-;",
	"P3-, -= Cores 8-11 =-;",
	"P3-;",
   "P3OH,Core8,Running,Paused;",
   "P3OI,Core9,Running,Paused;",
   "P3OJ,Core10,Running,Paused;",
   "P3OK,Core11,Running,Paused;",
	"P3-;",
	"P4,Core 12-15;",
	"P4-;",
	"P4-, -= Cores 12-15 =-;",
	"P4-;",
	"P4OL,Core12,Running,Paused;",
	"P4OM,Core13,Running,Paused;",
	"P4ON,Core14,Running,Paused;",
	"P4OO,Core15,Running,Paused;",
	"P5-;",
	"P5,Cores 16-19;",
	"P5-;",
	"P5-, -= Cores 16-19 =-;",
	"P5-;",
	"P5OP,Core16,Running,Paused;",
	"P5OQ,Core17,Running,Paused;",
	"P5OR,Core18,Running,Paused;",
	"P5OS,Core19,Running,Paused;",
	"-;",
	"T0,Reset;",
	"R0,Reset and close OSD;",
	"V,v",`BUILD_DATE 
};

wire  [1:0] buttons;
wire [31:0] status;
wire [10:0] ps2_key;
wire  [5:0] navigate;

hps_io #(.STRLEN($size(CONF_STR)>>3)) hps_io
(
	.clk_sys(clk_sys),
	.HPS_BUS(HPS_BUS),
	.EXT_BUS(),
	.gamma_bus(),

	.conf_str(CONF_STR),

	.buttons(buttons),
	.status(status),
	.status_menumask({status[5]}),
	
	.ps2_key(ps2_key)
);


///////////////////////   CLOCKS   ///////////////////////////////

wire clk_video, clk_sys;
pll pll
(
	.refclk(CLK_50M),
	.rst(0),
	.outclk_0(clk_video),
	.outclk_1(clk_sys)
);


wire reset = RESET | status[0] | buttons[1];

//////////////////////////////////////////////////////////////////

mandelbrot mandelbrot
(
	.clk(clk_sys),
	.reset(reset),
	
	.ddram_clk(DDRAM_CLK),
	.ddram_busy(DDRAM_BUSY),
	.ddram_burstcnt(DDRAM_BURSTCNT),
	.ddram_addr(DDRAM_ADDR),
	.ddram_dout(DDRAM_DOUT),
	.ddram_dout_ready(DDRAM_DOUT_READY),
	.ddram_rd(DDRAM_RD),
	.ddram_din(DDRAM_DIN),
	.ddram_be(DDRAM_BE),
	.ddram_we(DDRAM_WE),
	.red(Red),
	.blue(Blue),
	.green(Green),
	.cores(cores),
	.percorecolours(percorecolours),
	.useprettycolours(useprettycolours),
	.navigate(navigate),
	.iterationspicker(iterationspicker),
	.led_user(LED_USER),
	.status(status)
);

wire [lastcore:0] cores;
assign cores[lastcore:0] 		= ~status[lastcore+9:9];

wire [2:0] iterationspicker	= status[3:1];

wire [1:0] col 					= status[8:7];
wire [7:0] Red 					= (!col || col == 1) ? 8'd255 : 8'd0;
wire [7:0] Green 					= (!col || col == 2) ? 8'd255 : 8'd0;
wire [7:0] Blue 					= (!col || col == 3) ? 8'd255 : 8'd0;

wire useprettycolours 			= ~status[5] & ~status[6];
wire percorecolours 				= status[5] & ~status[6];

assign navigate[0] 				= (ps2_key[9:0] == {2'b10, 8'h1C}); // a=left;
assign navigate[1] 				= (ps2_key[9:0] == {2'b10, 8'h23}); // d=right;
assign navigate[2] 				= (ps2_key[9:0] == {2'b10, 8'h1D}); // w=top;
assign navigate[3] 				= (ps2_key[9:0] == {2'b10, 8'h1B}); // d=bottom;
assign navigate[4] 				= (ps2_key[9:0] == {2'b10, 8'h1A}); // z=zoomin
assign navigate[5] 				= (ps2_key[9:0] == {2'b10, 8'h22}); // x=zoomout

endmodule
