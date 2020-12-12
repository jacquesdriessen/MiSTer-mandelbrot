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

module mandelbrotdecrement
(
	input						clk,
	input						reset,
	input						enable,
	input wire [10:0]		a,
	output reg [10:0]		q,
	output reg				iszero
);

always @(posedge clk) begin
	if (reset) begin
		q <= 11'b0;
	end else if (enable) begin
		q <= a-11'b1;
		iszero <= (a==1); // note this executes in parallel to previous statement, so need to compare to 1.
	end
end

endmodule