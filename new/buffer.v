`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.02.2022 11:37:21
// Design Name: 
// Module Name: buffer
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


module buffer(
input clk, rst, en,
input [7:0] in,
output reg [7:0] out
    );
    always @(posedge clk)
    begin
    if(en==1'b1 & rst==1'b1)
    begin
    out=in;
    end
    else
    begin
    out=8'bz;
    end
    end
endmodule
