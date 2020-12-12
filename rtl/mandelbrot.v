//============================================================================
//
//  Copyright (C) 2020 Jacques Driessen
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

integer i; // for looping through cores (e.g. replicates the statements)

module mandelbrot
(
	input         			clk,
	input         			reset,

	output        			ddram_clk,
	input      			   ddram_busy,
	output  	   	[7:0] ddram_burstcnt,
	output 		  [28:0] ddram_addr,
	input  		  [63:0] ddram_dout,
	input         			ddram_dout_ready,
	output      			ddram_rd,
	output	 	  [63:0] ddram_din,
	output  			[7:0] ddram_be,
	output        			ddram_we,
					
	input				[7:0]	red,
	input				[7:0]	green,
	input				[7:0]	blue,

	input   [lastcore:0]	cores,
	input			  			percorecolours,
	input			  			useprettycolours,
	input				[2:0] iterationspicker,
	input 			[5:0] navigate,
	output        			led_user,
	input 		  [31:0] status
);

assign ddram_burstcnt 	= 8'b1;
assign ddram_rd 			= 1'b0;  

reg [25:0] ram_addr 		= 26'h0; 																		// ram address within framebuffer!
reg [15:0] pixel_colour;
reg ram_we 					= 1'b0;
reg [7:0] ram_be			= 8'b0;

assign ddram_clk 			= clk;
assign ddram_addr 		= {3'b001, ram_addr}; 														// 8 byte words - INIT after linux, first 512MB are for Linux!!, e.g. INIT at 0x20000000 (and since 64 bits mem, 0x04000000)
assign ddram_din 			= {pixel_colour, pixel_colour, pixel_colour, pixel_colour};  	// data will always be the pixel colour.
assign ddram_be 			= ram_be;  																		//bytemask (8 byte words, every bit codes for one of the bytes)
assign ddram_we 			= ram_we;  																		//write to ram

reg  [23:0] act_cnt; 																						
assign led_user    		= act_cnt[23] ?
										act_cnt[22:15]  > act_cnt[7:0] :									// Will make LED fade in/out whilst act_cnt is increasing.
										act_cnt[22:15]  <= act_cnt[7:0]; 

pannerscaler mypannerscaler (
	.clk_in(clk),
	.reset(reset),
	.enable(calculating),

	.x_in(x_in),
	.y_in(y_in),
	.hor_scale_in(scale), 
	.hor_offset_in(hor_offset), 
	.ver_scale_in(scale), 
	.ver_offset_in(ver_offset),

	.write_request_in(pannerscaler_write_request),
	.data_available(pannerscaler_data_ready_out),
	.data_read_ack(pannerscaler_data_read_ack),
	.pixel_addr_in({vc, hc}),
	.pixel_addr_out(pannerscaler_pixel_addr_out),
	.buffer_full_out(pannerscaler_buffer_full),
	.re_out(pannerscaler_re),
	.im_out(pannerscaler_im),

// Doubles as (asynchronous) ALU with a_plus_b_x_c = (a+b)*c 
	.alu_mode(alu_mode),
	.a(a),
	.b(b),
	.c(c),
	.a_plus_b_x_c(a_plus_b_x_c)
);


reg calculating = 1'b0;

reg [15:0] x_in;
reg [15:0] y_in;
reg [31:0] scale;
reg [31:0] hor_offset;
reg [31:0] ver_offset;

reg pannerscaler_write_request;
wire pannerscaler_data_ready_out;
reg pannerscaler_data_read_ack;
wire [21:0] pannerscaler_pixel_addr_out;
wire pannerscaler_buffer_full; 
wire [31:0] pannerscaler_re;
wire [31:0] pannerscaler_im;

reg alu_mode;
reg [31:0] a,b,c;
wire [31:0] a_plus_b_x_c;

mandelbrotpipelinemulticorewrapper mandelbrotcores[lastcore:0] (
	.clk_in(clk),
	.reset(reset),
	.enable(cores),
   .calculating(calculating),
	.buffer_full_out(cores_buffer_full_out),
	.write_request_in(cores_write_request_in),
	.max_iterations_in(max_iterations),
	.iterations_out(cores_iterations_out),
	.pixel_addr_in(pannerscaler_pixel_addr_out),
	.pixel_addr_out(cores_pixel_addr_out),
	.output_buffer_overflow_out(cores_output_buffer_overflow_out),
	.data_ready_out(cores_data_ready_out),
	.data_read_ack(cores_data_read_ack),
	.re_in(pannerscaler_re),
	.im_in(pannerscaler_im)
);

reg [lastcore:0] cores_write_request_in; 
reg [lastcore:0] cores_data_read_ack; 
wire [lastcore:0] cores_buffer_full_out; 
wire [lastcore:0][10:0] cores_iterations_out;
wire [lastcore:0][21:0] cores_pixel_addr_out;
wire [lastcore:0] cores_output_buffer_overflow_out;
wire [lastcore:0] cores_data_ready_out;


reg [10:0] max_iterations;
reg [10:0] hc;
reg [10:0] vc;

reg [4:0] output_core;
reg [4:0] input_core;
reg [4:0] alu_wait;
reg [4:0] red_component, green_component, blue_component;
reg [15:0] index; 										// for colouring


wire [15:0] prettycolours[0:15] = '{					// In RGB order, 5bits,  from https://stackoverflow.com/questions/16500656/which-color-gradient-is-used-to-color-mandelbrot-in-wikipedia
	{1'b1, 5'd0, 5'd7, 5'd13},
	{1'b1, 5'd0, 5'd11, 5'd19},
	{1'b1, 5'd0, 5'd16, 5'd26},
	{1'b1, 5'd0, 5'd21, 5'd31},
	{1'b1, 5'd12, 5'd25, 5'd31},
	{1'b1, 5'd24, 5'd29, 5'd30},
	{1'b1, 5'd31, 5'd30, 5'd26},
	{1'b1, 5'd29, 5'd23, 5'd17},
	{1'b1, 5'd26, 5'd16, 5'd7},
	{1'b1, 5'd22, 5'd10, 5'd3},
	{1'b1, 5'd17, 5'd6, 5'd2},
	{1'b1, 5'd13, 5'd1, 5'd0},
	{1'b1, 5'd9, 5'd1, 5'd1},
	{1'b1, 5'd6, 5'd0, 5'd1},
	{1'b1, 5'd3, 5'd1, 5'd3},
	{1'b1, 5'd2, 5'd5, 5'd8}
};

// State machine

localparam [4:0]
	INIT					= 0,
	IDLE					= 1,
	ALU_OPERATION		= 2,
	ALU_EXECUTE			= 3,
	PANZOOM				= 4,
	PAN					= 5,
	PAN_HORIZONTAL		= 6,
	PAN_VERTICAL		= 7,
	PAN_HOR_EXECUTE	= 8,
	PAN_VER_EXECUTE	= 9,
	ZOOM					= 10,
	ZOOM_EXECUTE		= 11,
	ZOOM_CORRECT_HOR	= 12,
	ZOOM_CORRECT_VER	= 13,
	RENDER	   		= 14,
	RENDERLOOP			= 15,
	PAN_SCALE			= 16,
	NEXT_POINT			= 17,
	FILLMAINPIPELINE	= 18,
	CORE_WRITE			= 19,
	READMAINPIPELINE	= 20,
	DETERMINE_VALUE	= 21,
	CORE_READ			= 22,
	SCREEN_WRITE		= 23,
	DEFAULT				= 31;

reg [4:0] state;
reg [4:0] state_post_alu;
reg [15:0] empty_render_cycles;
reg [31:0] previous_status;
	
always @(posedge clk)
begin
	if (reset) begin
																													// reset stuff that drives actual hardware, remainder will be (res)et in the INIT state of the state machine.
		ram_we 														<= 1'b0;									// stop ram writes
		pannerscaler_write_request 							<= 1'b0;									// stop pannerscaler writes
		pannerscaler_data_read_ack 							<= 1'b0;									// stop pannerscaler reads
		calculating 												<= 1'b0;									// stop calculating
		alu_mode 													<= 1'b0;									// reset pannerscaler to normal (non alu) mode
		act_cnt 														<= 8'h00;  							 	// reset LED fader
		for (i = 0; i <= lastcore; i++) begin															// for each core:
			cores_write_request_in[i] 							<= 1'b0;									//						stop writes
			cores_data_read_ack[i] 								<= 1'b0;									//						stop reads
		end

		state <= INIT;
	end
	else begin
		case (state)
			INIT: begin
				scale 												<= 32'h3b000000; 						// 1/512 float 
				hor_offset 											<= 32'h0; 								// 0 
				ver_offset 											<= 32'h0; 								// 0
		
				input_core 											<= 0;
				output_core 										<= 0;
				state_post_alu										<= IDLE;									// just in case, shouldn't be necessary
		
				state 												<= RENDER;
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			IDLE: begin
				previous_status 									<= status; 

				if (navigate[5:0] != 6'b0) 																// any of the pan/zoom buttons pressed.
					state 											<= PANZOOM;
				else if (status != previous_status) 													// anything in the menu changed, rerender.
					state 											<= RENDER;
				else
					state 											<= IDLE;
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			ALU_OPERATION: begin
				alu_wait 											<= 5'h1F; 								// wait 32 cycles (pipeline ~ 16 cycles, so will be complete by then)
				alu_mode 											<= 1'b1; 								// calculate a_plus_b_x_c  = (a+b) * c, this suspends normal pannerscaler by the way!
				state 												<= ALU_EXECUTE;
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			ALU_EXECUTE: begin
				alu_wait 											<= alu_wait - 5'b1;
				if (!alu_wait) begin 																		// once the wait is over
					alu_mode 										<= 1'b0; 								// disable alu, this resumes normal pannerscaler by the way!

					state												<= state_post_alu;
					state_post_alu									<= IDLE;									// just in case, shouldn't be necessary
				end
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			PANZOOM: begin
				if (navigate[3:0] != 4'b0)
					state 											<= PAN;
				else if (navigate[5:4] != 2'b0)
					state 											<= ZOOM;
				else
					state 											<= IDLE;
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			PAN: begin
				if (navigate[1:0] != 2'b0)
					state 											<= PAN_HORIZONTAL;
				else if (navigate[3:2] != 2'b0)
					state 											<= PAN_VERTICAL;
				else
					state 											<= IDLE;
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			PAN_HORIZONTAL: begin
				a 														<= navigate[0] ? 	
																			32'h42800000 : 					// +64 float - right  
																			32'hc2800000;  					// -64 float - left 
				b 														<= hor_offset;
				c 														<= 32'h3f800000; 						// multiply by 1 float = "ADD ONLY"
				state_post_alu									 	<= PAN_HOR_EXECUTE;
				state 												<= ALU_OPERATION;
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			PAN_HOR_EXECUTE: begin
				hor_offset 											<= a_plus_b_x_c;
				state 												<= RENDER;
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			PAN_VERTICAL: begin
				a 														<= navigate[2] ? 
																			32'h42800000 : 					// +64 float - bottom
																			32'hc2800000; 						// -64 float - top
				b 														<= ver_offset;
				c 														<= 32'h3f800000; 						// multiply by 1 float = "ADD ONLY"
				state_post_alu										<= PAN_VER_EXECUTE;
				state 												<= ALU_OPERATION;
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			PAN_VER_EXECUTE: begin
				ver_offset 											<= a_plus_b_x_c;
				state 												<= RENDER;
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			ZOOM: begin
				a 														<= 32'b0; 								// add 0 float = "MULTIPLY ONLY"
				b 														<= navigate[4] ? 
																			32'h3f3504f3 : 					// 1/sqrt(2) float - zoom in 
																			32'h3fb504f3;						// sqrt(2) float 	 - zoom out
				c														<= scale;

				state_post_alu 									<= ZOOM_EXECUTE;
				state			 										<= ALU_OPERATION;
			end	
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			ZOOM_EXECUTE: begin
				scale													<= a_plus_b_x_c;
																		// a is still 0 float = "MULTIPLY ONLY"
				b 														<= navigate[4] ?
																			32'h3fb504f3 :						// sqrt(2) float 	 	- zoom in  -  Note this the "reverse" of what needs to happen for the scale factor 
																			32'h3f3504f3; 						// 1/sqrt(2) float	- zoom out -  Also technically navigate[4] could have changed. I will take my chances
				c 														<= hor_offset;

				state_post_alu 									<= ZOOM_CORRECT_HOR;
				state			 										<= ALU_OPERATION;
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			ZOOM_CORRECT_HOR: begin
				hor_offset	 										<= a_plus_b_x_c;
																		// a is still 0 float = "MULTIPLY ONLY"
																		// b still holds the appropriate correction factor
				c 														<= ver_offset;

				state_post_alu 									<= ZOOM_CORRECT_VER;
				state			 										<= ALU_OPERATION;
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			ZOOM_CORRECT_VER: begin
				ver_offset	 										<= a_plus_b_x_c;
				state									 				<= RENDER;
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			RENDER: begin
				hc 													<= 11'b0;
				vc 													<= 11'b0;
				x_in 													<= 16'b1111110001000000; 			// hc -960 // keep separate counters as arithmetic more expensive
				y_in 													<= 16'b1111110111100100; 			// vc -540 // keep separate counters as arithmetic more expensive 
				empty_render_cycles								<= 16'b0;
				max_iterations 									<= 11'd2047 >> (7-iterationspicker);

				calculating 										<= 1'b1;
				state													<= RENDERLOOP;
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			RENDERLOOP: begin
				act_cnt 												<= calculating ?						// Blink LED whilst calculating & rendering 
																				act_cnt + 1'd1 :
																				act_cnt; 	
				empty_render_cycles								<= empty_render_cycles + 16'b1;	// count render cycles

																													// loop through:
																												   // PAN_SCALE (pipeline to translate (x,y) viewpoint into (re,im) pairs)
																													// FILLMAINPIPELINE (feed to main pipeline that does mandelbrot calculations)
																													// READMAINPIPELINE (extract results to put onto the screen from the main pipeline)
				
				if (empty_render_cycles == 16'hFFFF) begin 											// wait for a max of 32 (primary pipeline buffer) + 16 (primary pipeline length) + 64 (secondary pipeline buffer) + 21 (secondary pipeline length) * 2048 (max_iterations) is 43120 + safety margin (50%), e.g. basically ~ 16 bits count  
					calculating 									<= 1'b0;									// Eventually escape (all rendered - or stuck condition).
					state 											<= IDLE;
				end else
					state												<= PAN_SCALE;
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			PAN_SCALE: begin
				if ((!pannerscaler_buffer_full) && (vc < 1080)) begin 									
					empty_render_cycles							<= 0;										// reset counter
					pannerscaler_write_request 				<= 1'b1; 								// initiate write to pannerscaler, note the coordinates are preprovided to the inputs!
					state												<= NEXT_POINT;
				end else
					state												<=	FILLMAINPIPELINE;					// if primary pipeline full or frame done, we can start working on main pipeline.
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			NEXT_POINT: begin
				pannerscaler_write_request <= 1'b0;														// finalise write to pannerscaler.

				if(hc < 1919) begin																			// stop after full line.
					hc 												<= hc + 1'd1;
					x_in												<= x_in + 1'd1;
					state												<= PAN_SCALE;
				end else	if (vc < 1080) begin																// 1920 marks the end of the line (just outside of the visible area), go to beginning of the next line, stop after full frame
					hc 												<= 0;
					x_in												<= 16'b1111110001000000; 			// -960 

					vc 												<= vc + 1'd1;
					y_in 												<= y_in + 1'd1;
					state												<= PAN_SCALE;
				end else
					state 											<= FILLMAINPIPELINE;	 				// if frame done  (and this shouldn't happen, as caught in PAN_SCALE, start working on main pipeline)
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			FILLMAINPIPELINE: begin
				if (pannerscaler_data_ready_out) begin
					if (!cores_buffer_full_out[input_core] && cores[input_core]) begin 		// find an core available and not overloaded and tell it to start calculating
						cores_write_request_in[input_core] 	<= 1'b1;									// output of the previous pipeline linked to the input of this one - so no need to transfer data.
						pannerscaler_data_read_ack 			<= 1'b1;
						state					 						<= CORE_WRITE;
					end else begin // try next core
						if (input_core == lastcore) begin
							input_core 								<= 0;
							state										<= READMAINPIPELINE; 				// once we have cycled through all cores, go to next stage.
						end else begin
							input_core 								<= input_core + 5'b1;
							//state 									<=	FILLMAINPIPELINE;					// implied state , make sure we keep the pipeline as full as possible.
						end
					end
				end
				else
					state 											<= READMAINPIPELINE; 				// if no data available to process, go to next step
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			CORE_WRITE: begin
				cores_write_request_in[input_core] 			<= 1'b0;
    			pannerscaler_data_read_ack 					<= 1'b0;
				
				if (input_core == lastcore)																// Distribute the load also if the core (e.g. quick escape) can process things faster than twe can provide.
					input_core 								<= 0;
				else 
					input_core 								<= input_core + 5'b1;
				
				state													<= FILLMAINPIPELINE;
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			READMAINPIPELINE: begin
				if (cores_data_ready_out[output_core] && cores[output_core]) begin 			// find core with available data and start to process
					state					 							<= DETERMINE_VALUE;
				end else begin // try next core
					if (output_core == lastcore) begin
						output_core 								<= 0;
						state											<= RENDERLOOP;							// once we have cycled through all cores, go to next stage.
					end else begin
						output_core 								<= output_core + 5'b1;
						//state 										<=	READMAINPIPELINE;					// implied state , make sure we keep the pipeline as full as possible.
					end
				end
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			DETERMINE_VALUE: begin																			// max_iterations is 16 * 2 power (iterationspicker) - 1,  however, if zero iterations left (max), make sure we keep it zero (should be the case anyway I believe).
				index 												<= cores_iterations_out[output_core] ? 
																					cores_iterations_out[output_core] >> iterationspicker : 
																					0; 
				state				 									<= CORE_READ;
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			CORE_READ: begin
				if (!ddram_busy) begin
					ram_addr 										<= {6'b0, cores_pixel_addr_out[output_core][21:2]};
					ram_be 											<= cores_pixel_addr_out[output_core][1] ?
																				(cores_pixel_addr_out[output_core][0] ?
																					8'hC0 :						// bytes 7:6
																					8'h30) :						// bytes 5:4
																				(cores_pixel_addr_out[output_core][0] ? 
																					8'h0C : 						// bytes 3:2
																					8'h03);						// bytes 1:0

																													// pixel_colour is already hardwired to the ram "data in".
					if (index == 11'b0)
						pixel_colour 								<= {1'b1, 5'b0, 5'b0, 5'b0}; 		// zero means max iterations, e.g. part of the mandelbrot set, always black.
					else if (useprettycolours)
						pixel_colour 								<= prettycolours[index[4:1]];
					else if (percorecolours) 
						pixel_colour								<= {1'b1, {index[4:0] >> output_core[4]}, {index[4:0] >> output_core[1:0]}, {index[4:0] >> output_core[3:2]}};
					else
						pixel_colour 								<= {1'b1, blue[4:0] & index[4:0], green[4:0] & index[4:0], red[4:0] & index[4:0]};
					
					cores_data_read_ack[output_core] 		<= 1'b1;
					ram_we 											<= 1'b1;
					state 											<= SCREEN_WRITE;
				end else
					state 											<= RENDERLOOP; 						// if ddram busy might as well check if there is other stuff to do.
			end
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			SCREEN_WRITE: begin
				cores_data_read_ack[output_core] 			<= 1'b0; 								// acknowledge to core we read the data.
				ram_we 												<= 1'b0; 								// end ram cycle
				state 												<= READMAINPIPELINE;
			end
	  endcase
	end
end

endmodule
