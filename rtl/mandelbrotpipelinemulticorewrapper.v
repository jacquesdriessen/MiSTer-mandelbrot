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

// Quartus requires a VHDL file to support multiple instances, but want to retain the "BDF" view as well, hence this workaround 
// https://www.intel.com/content/www/us/en/programmable/quartushelp/13.0/mergedProjects/msgs/msgs/evrfx_veri_aoi_no_module_decl.htm

module mandelbrotpipelinemulticorewrapper(
        clk_in,
        reset,
        enable,
		  calculating,
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

input wire      clk_in;
input wire      reset;
input wire      enable;
input	wire      calculating;
input wire      data_read_ack;
input wire      write_request_in;
input wire      [31:0] im_in;
input wire      [10:0] max_iterations_in;
input wire      [21:0] pixel_addr_in;
input wire      [31:0] re_in;
output wire     data_ready_out;
output wire     output_buffer_overflow_out;
output wire     buffer_full_out;
output wire     [10:0] iterations_out;
output wire     [21:0] pixel_addr_out;

mandelbrotpipeline mymulticore(
        .clk_in(clk_in),
        .reset(reset),
        .enable(enable),
		  .calculating(calculating),
        .data_read_ack(data_read_ack),
        .write_request_in(write_request_in),
        .im_in(im_in),
        .max_iterations_in(max_iterations_in),
        .pixel_addr_in(pixel_addr_in),
        .re_in(re_in),
        .data_ready_out(data_ready_out),
        .output_buffer_overflow_out(output_buffer_overflow_out),
        .buffer_full_out(buffer_full_out),
        .iterations_out(iterations_out),
        .pixel_addr_out(pixel_addr_out)
);

endmodule
