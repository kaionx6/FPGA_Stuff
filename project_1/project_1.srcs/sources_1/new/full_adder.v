`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2026 21:38:51
// Design Name: 
// Module Name: full_adder
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


module full_adder (

input A,
input B,
input CIN,
output SUM,
output COUT

);

wire prop;

assign prop = A^B;
assign SUM = prop ^ CIN;
assign COUT= (A & B) | (prop & CIN);

endmodule


