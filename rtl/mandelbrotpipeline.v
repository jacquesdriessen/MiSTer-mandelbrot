// Copyright (C) 2017  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Intel and sold by Intel or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 17.0.2 Build 602 07/19/2017 SJ Lite Edition"
// CREATED		"Tue Dec  8 00:30:11 2020"

module mandelbrotpipeline(
	clk_in,
	reset,
	enable,
	data_read_ack,
	write_request_in,
	im_in,
	max_iterations_in,
	pixel_addr_in,
	re_in,
	data_ready_out,
	output_buffer_overflow_out,
	buffer_full_out,
	iterations_out,
	pixel_addr_out
);


input wire	clk_in;
input wire	reset;
input wire	enable;
input wire	data_read_ack;
input wire	write_request_in;
input wire	[31:0] im_in;
input wire	[10:0] max_iterations_in;
input wire	[21:0] pixel_addr_in;
input wire	[31:0] re_in;
output wire	data_ready_out;
output wire	output_buffer_overflow_out;
output wire	buffer_full_out;
output wire	[10:0] iterations_out;
output wire	[21:0] pixel_addr_out;

wire	Add;
wire	[15:0] iterations;
wire	[31:0] pixel_addr_left;
wire	[31:0] pixel_addr_right;
wire	SYNTHESIZED_WIRE_0;
wire	[0:0] SYNTHESIZED_WIRE_57;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	[0:0] SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_58;
wire	[31:0] SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_59;
wire	[31:0] SYNTHESIZED_WIRE_13;
wire	[31:0] SYNTHESIZED_WIRE_60;
wire	[31:0] SYNTHESIZED_WIRE_16;
wire	[31:0] SYNTHESIZED_WIRE_18;
wire	[31:0] SYNTHESIZED_WIRE_61;
wire	SYNTHESIZED_WIRE_21;
wire	[10:0] SYNTHESIZED_WIRE_23;
wire	[10:0] SYNTHESIZED_WIRE_24;
wire	SYNTHESIZED_WIRE_25;
wire	SYNTHESIZED_WIRE_26;
wire	SYNTHESIZED_WIRE_27;
wire	[21:0] SYNTHESIZED_WIRE_62;
wire	SYNTHESIZED_WIRE_63;
wire	SYNTHESIZED_WIRE_35;
wire	[21:0] SYNTHESIZED_WIRE_36;
wire	[31:0] SYNTHESIZED_WIRE_37;
wire	[31:0] SYNTHESIZED_WIRE_40;
wire	[31:0] SYNTHESIZED_WIRE_64;
wire	[31:0] SYNTHESIZED_WIRE_43;
wire	[31:0] SYNTHESIZED_WIRE_45;
wire	[31:0] SYNTHESIZED_WIRE_65;
wire	SYNTHESIZED_WIRE_48;
wire	[0:0] SYNTHESIZED_WIRE_49;
wire	[31:0] SYNTHESIZED_WIRE_50;
wire	[31:0] SYNTHESIZED_WIRE_51;
wire	[31:0] SYNTHESIZED_WIRE_53;
wire	[31:0] SYNTHESIZED_WIRE_55;
wire	[31:0] SYNTHESIZED_WIRE_56;




assign	SYNTHESIZED_WIRE_58 = SYNTHESIZED_WIRE_0 & SYNTHESIZED_WIRE_57;


ALTSHIFT_TAPS	b2v_escape_pipeline(
	.clken(enable),
	.clock(clk_in),
	.aclr(reset),
	.shiftin(SYNTHESIZED_WIRE_2),
	.shiftout(SYNTHESIZED_WIRE_4)
	);
	defparam	b2v_escape_pipeline.NUMBER_OF_TAPS = 1;
	defparam	b2v_escape_pipeline.TAP_DISTANCE = 7;
	defparam	b2v_escape_pipeline.WIDTH = 1;

assign	SYNTHESIZED_WIRE_0 = SYNTHESIZED_WIRE_3 | SYNTHESIZED_WIRE_4;

assign	buffer_full_out = SYNTHESIZED_WIRE_5 | SYNTHESIZED_WIRE_6 | SYNTHESIZED_WIRE_7;

assign	SYNTHESIZED_WIRE_21 = ~(SYNTHESIZED_WIRE_58 & SYNTHESIZED_WIRE_58);


lpm_ff_0	b2v_im_c_ff(
	.enable(enable),
	.clock(clk_in),
	
	
	
	
	
	.aclr(reset),
	.data(SYNTHESIZED_WIRE_10),
	.q(SYNTHESIZED_WIRE_55));


mandelbrot_32bitx32_buffer	b2v_im_c_in_buffer(
	.wrreq(write_request_in),
	.rdreq(SYNTHESIZED_WIRE_59),
	.clock(clk_in),
	.aclr(reset),
	.data(im_in),
	
	.almost_full(SYNTHESIZED_WIRE_5),
	.empty(SYNTHESIZED_WIRE_26),
	.q(SYNTHESIZED_WIRE_60));


busmux_1	b2v_im_c_mux(
	.sel(SYNTHESIZED_WIRE_59),
	.dataa(SYNTHESIZED_WIRE_13),
	.datab(SYNTHESIZED_WIRE_60),
	.result(SYNTHESIZED_WIRE_10));


busmux_2	b2v_im_c_pipe_mux(
	.sel(SYNTHESIZED_WIRE_59),
	.dataa(SYNTHESIZED_WIRE_16),
	.datab(SYNTHESIZED_WIRE_60),
	.result(SYNTHESIZED_WIRE_18));


ALTSHIFT_TAPS	b2v_im_c_pipeline_part1(
	.clken(enable),
	.clock(clk_in),
	.aclr(reset),
	.shiftin(SYNTHESIZED_WIRE_18),
	.shiftout(SYNTHESIZED_WIRE_61)
	);
	defparam	b2v_im_c_pipeline_part1.NUMBER_OF_TAPS = 1;
	defparam	b2v_im_c_pipeline_part1.TAP_DISTANCE = 15;
	defparam	b2v_im_c_pipeline_part1.WIDTH = 32;


ALTSHIFT_TAPS	b2v_im_c_pipeline_part2(
	.clken(enable),
	.clock(clk_in),
	.aclr(reset),
	.shiftin(SYNTHESIZED_WIRE_61),
	.shiftout(SYNTHESIZED_WIRE_16)
	);
	defparam	b2v_im_c_pipeline_part2.NUMBER_OF_TAPS = 1;
	defparam	b2v_im_c_pipeline_part2.TAP_DISTANCE = 7;
	defparam	b2v_im_c_pipeline_part2.WIDTH = 32;



assign	SYNTHESIZED_WIRE_63 = SYNTHESIZED_WIRE_57 & SYNTHESIZED_WIRE_21;



busmux_3	b2v_iterations_ff(
	.sel(SYNTHESIZED_WIRE_59),
	.dataa(iterations[10:0]),
	.datab(max_iterations_in),
	.result(SYNTHESIZED_WIRE_23));


lpm_add_sub_4	b2v_iterations_min_1_and_pipeline(
	
	
	.aclr(reset),
	.clock(clk_in),
	.clken(enable),
	.dataa(SYNTHESIZED_WIRE_23),
	.datab(SYNTHESIZED_WIRE_24),
	
	
	.result(iterations[10:0]));

assign	SYNTHESIZED_WIRE_35 = ~(SYNTHESIZED_WIRE_25 & SYNTHESIZED_WIRE_26 & SYNTHESIZED_WIRE_27);


lpm_constant_5	b2v_One(
	.result(SYNTHESIZED_WIRE_24));


mandelbrot_pipeline_output_buffer	b2v_output_buffer(
	.clk(clk_in),
	.reset(reset),
	.enable(enable),
	.data_write(SYNTHESIZED_WIRE_58),
	.data_read_ack(data_read_ack),
	.iterations_in(iterations[10:0]),
	.pixel_addr_in(SYNTHESIZED_WIRE_62),
	.output_buffer_almost_full(SYNTHESIZED_WIRE_48),
	.output_buffer_overflow_out(output_buffer_overflow_out),
	.data_ready_out(data_ready_out),
	.iterations_out(iterations_out),
	.pixel_addr_out(pixel_addr_out));


mandelbrot_32bitx32_buffer	b2v_pixel_addr_in_buffer(
	.wrreq(write_request_in),
	.rdreq(SYNTHESIZED_WIRE_59),
	.clock(clk_in),
	.aclr(reset),
	.data(pixel_addr_left),
	
	.almost_full(SYNTHESIZED_WIRE_6),
	.empty(SYNTHESIZED_WIRE_27),
	.q(pixel_addr_right));


busmux_6	b2v_pixel_addr_mux(
	.sel(SYNTHESIZED_WIRE_59),
	.dataa(SYNTHESIZED_WIRE_62),
	.datab(pixel_addr_right[21:0]),
	.result(SYNTHESIZED_WIRE_36));


busmux_7	b2v_pixel_addr_mux4(
	.sel(SYNTHESIZED_WIRE_59),
	.dataa(SYNTHESIZED_WIRE_63),
	.datab(SYNTHESIZED_WIRE_35),
	.result(SYNTHESIZED_WIRE_49));


ALTSHIFT_TAPS	b2v_pixel_addr_pipeline(
	.clken(enable),
	.clock(clk_in),
	.aclr(reset),
	.shiftin(SYNTHESIZED_WIRE_36),
	.shiftout(SYNTHESIZED_WIRE_62)
	);
	defparam	b2v_pixel_addr_pipeline.NUMBER_OF_TAPS = 1;
	defparam	b2v_pixel_addr_pipeline.TAP_DISTANCE = 22;
	defparam	b2v_pixel_addr_pipeline.WIDTH = 22;


lpm_ff_8	b2v_re_c_ff(
	.enable(enable),
	.clock(clk_in),
	
	
	
	
	
	.aclr(reset),
	.data(SYNTHESIZED_WIRE_37),
	.q(SYNTHESIZED_WIRE_56));


mandelbrot_32bitx32_buffer	b2v_re_c_in_buffer(
	.wrreq(write_request_in),
	.rdreq(SYNTHESIZED_WIRE_59),
	.clock(clk_in),
	.aclr(reset),
	.data(re_in),
	
	.almost_full(SYNTHESIZED_WIRE_7),
	.empty(SYNTHESIZED_WIRE_25),
	.q(SYNTHESIZED_WIRE_64));


busmux_9	b2v_re_c_mux(
	.sel(SYNTHESIZED_WIRE_59),
	.dataa(SYNTHESIZED_WIRE_40),
	.datab(SYNTHESIZED_WIRE_64),
	.result(SYNTHESIZED_WIRE_37));


busmux_10	b2v_re_c_pipe_mux(
	.sel(SYNTHESIZED_WIRE_59),
	.dataa(SYNTHESIZED_WIRE_43),
	.datab(SYNTHESIZED_WIRE_64),
	.result(SYNTHESIZED_WIRE_45));


ALTSHIFT_TAPS	b2v_re_c_pipeline_part1(
	.clken(enable),
	.clock(clk_in),
	.aclr(reset),
	.shiftin(SYNTHESIZED_WIRE_45),
	.shiftout(SYNTHESIZED_WIRE_65)
	);
	defparam	b2v_re_c_pipeline_part1.NUMBER_OF_TAPS = 1;
	defparam	b2v_re_c_pipeline_part1.TAP_DISTANCE = 15;
	defparam	b2v_re_c_pipeline_part1.WIDTH = 32;


ALTSHIFT_TAPS	b2v_re_c_pipeline_part2(
	.clken(enable),
	.clock(clk_in),
	.aclr(reset),
	.shiftin(SYNTHESIZED_WIRE_65),
	.shiftout(SYNTHESIZED_WIRE_43)
	);
	defparam	b2v_re_c_pipeline_part2.NUMBER_OF_TAPS = 1;
	defparam	b2v_re_c_pipeline_part2.TAP_DISTANCE = 7;
	defparam	b2v_re_c_pipeline_part2.WIDTH = 32;

assign	SYNTHESIZED_WIRE_59 = ~(SYNTHESIZED_WIRE_63 | SYNTHESIZED_WIRE_48);


ALTSHIFT_TAPS	b2v_valid_data_in_pipeline(
	.clken(enable),
	.clock(clk_in),
	.aclr(reset),
	.shiftin(SYNTHESIZED_WIRE_49),
	.shiftout(SYNTHESIZED_WIRE_57)
	);
	defparam	b2v_valid_data_in_pipeline.NUMBER_OF_TAPS = 1;
	defparam	b2v_valid_data_in_pipeline.TAP_DISTANCE = 22;
	defparam	b2v_valid_data_in_pipeline.WIDTH = 1;


floatequaltofourolarger	b2v_z_larger_than_4(
	.a(SYNTHESIZED_WIRE_50),
	.fourorlarger(SYNTHESIZED_WIRE_2));


complex_addsub	b2v_z_plus_c(
	.clk(clk_in),
	.reset(reset),
	.enable(enable),
	.operation(Add),
	.im_a(SYNTHESIZED_WIRE_51),
	.im_b(SYNTHESIZED_WIRE_61),
	.re_a(SYNTHESIZED_WIRE_53),
	.re_b(SYNTHESIZED_WIRE_65),
	.im_out(SYNTHESIZED_WIRE_13),
	.re_out(SYNTHESIZED_WIRE_40));


complex_square	b2v_z_square(
	.clk(clk_in),
	.reset(reset),
	.enable(enable),
	.im_in(SYNTHESIZED_WIRE_55),
	.re_in(SYNTHESIZED_WIRE_56),
	.im_out(SYNTHESIZED_WIRE_51),
	.re_out(SYNTHESIZED_WIRE_53),
	.re_sq_plus_im_sq(SYNTHESIZED_WIRE_50));


int16bitcomparetozero	b2v_zero_iterations_left(
	.a(iterations),
	.iszero(SYNTHESIZED_WIRE_3));

assign	Add = 1;
assign	iterations[15:11] = 5'b00000;
assign	pixel_addr_left[21:0] = pixel_addr_in;
assign	pixel_addr_left[31:22] = 10'b0000000000;

endmodule

module busmux_1(sel,dataa,datab,result);
/* synthesis black_box */

input sel;
input [31:0] dataa;
input [31:0] datab;
output [31:0] result;

endmodule

module busmux_10(sel,dataa,datab,result);
/* synthesis black_box */

input sel;
input [31:0] dataa;
input [31:0] datab;
output [31:0] result;

endmodule

module busmux_2(sel,dataa,datab,result);
/* synthesis black_box */

input sel;
input [31:0] dataa;
input [31:0] datab;
output [31:0] result;

endmodule

module busmux_3(sel,dataa,datab,result);
/* synthesis black_box */

input sel;
input [10:0] dataa;
input [10:0] datab;
output [10:0] result;

endmodule

module busmux_6(sel,dataa,datab,result);
/* synthesis black_box */

input sel;
input [21:0] dataa;
input [21:0] datab;
output [21:0] result;

endmodule

module busmux_7(sel,dataa,datab,result);
/* synthesis black_box */

input sel;
input [0:0] dataa;
input [0:0] datab;
output [0:0] result;

endmodule

module busmux_9(sel,dataa,datab,result);
/* synthesis black_box */

input sel;
input [31:0] dataa;
input [31:0] datab;
output [31:0] result;

endmodule

module lpm_add_sub_4(aclr,clock,clken,dataa,datab,result);
/* synthesis black_box */

input aclr;
input clock;
input clken;
input [10:0] dataa;
input [10:0] datab;
output [10:0] result;

endmodule

module lpm_constant_5(result);
/* synthesis black_box */

output [10:0] result;

endmodule

module lpm_ff_0(enable,clock,aclr,data,q);
/* synthesis black_box */

input enable;
input clock;
input aclr;
input [31:0] data;
output [31:0] q;

endmodule

module lpm_ff_8(enable,clock,aclr,data,q);
/* synthesis black_box */

input enable;
input clock;
input aclr;
input [31:0] data;
output [31:0] q;

endmodule
