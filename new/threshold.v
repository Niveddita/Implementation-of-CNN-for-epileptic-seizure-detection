`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2022 10:47:26
// Design Name: 
// Module Name: threshold
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module threshold(
    input clk,rst,en,
    input [15:0] v,
    output reg[15:0] out
    );
	 always@(posedge clk)begin
		 if(rst==1'b1 & en==1'b1)begin
			if (v[15] == 1'b1)
				out = 16'b0;
			else begin
				if (v > 16'b0) out = v;
				else out = 16'b0;
			end
		 end
	 end
endmodule
