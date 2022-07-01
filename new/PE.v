`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2022 10:58:11
// Design Name: 
// Module Name: PE
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


module PE(
input clk,rst,en,
input [7:0]i0,
input [7:0]i1,
input [7:0]i2,
input [23:0]weight,
input [7:0]bias,
output [15:0]y
    );
wire [15:0] p0,p1,p2;
wire [7:0] w0,w1,w2;
wire [7:0] b1,b2,b3;

assign w0=weight[7:0];
assign w1=weight[15:8];
assign w2=weight[23:16];

buffer c1(clk,rst,en,i1,b1);
buffer c2(clk,rst,en,i0,b2);
buffer c3(clk,rst,en,b2,b3);

macc x0(i2,w2,bias,p0);
macc x1(b1,w1,p0,p1);
macc x2(b3,w0,p1,p2);

threshold thres(clk,rst,en,p2,y);

endmodule
