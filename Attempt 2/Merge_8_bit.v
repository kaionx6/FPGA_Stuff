`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2026 19:37:39
// Design Name: 
// Module Name: Merge_8_bit
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


module Merge_8_bit(
    input wire [6:0] pattern,
    input wire dot,
    output wire [7:0] segment
);

    assign segment = {pattern, ~dot};

endmodule