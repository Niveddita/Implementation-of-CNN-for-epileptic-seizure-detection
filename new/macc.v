`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2022 10:52:15
// Design Name: 
// Module Name: macc
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


module macc(
input [7:0] inp,
input [7:0] weight,
input [7:0] prev,
output [15:0] product
    );
    wire [15:0]v;
    multiplier a1(inp,weight,v);
    adder b1(v,prev,product);
endmodule
