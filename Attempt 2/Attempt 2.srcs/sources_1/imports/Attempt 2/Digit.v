`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2026 19:46:32
// Design Name: 
// Module Name: Digit
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


module Digit(
    input wire clock,
    input wire reset,
    input wire [19:0] value,
    input wire [4:0] dots,
    output wire [7:0] digit,
    output wire [7:0] segment
);

    wire [2:0] count;
    wire [3:0] number;
    wire dot;
    wire [6:0] pattern;

    Cycle_5 counter (
        .clock(clock),
        .reset(reset),
        .count(count)
    );

    DigitSignal digit_decoder (
        .count(count),
        .digit(digit)
    );

    Choose_4_bit number_selector (
        .value(value),
        .count(count),
        .number(number)
    );

    Choose_Dot dot_selector (
        .dots(dots),
        .count(count),
        .dot(dot)
    );

    hex2seg symbol_decoder (
        .number(number),
        .pattern(pattern)
    );

    Merge_8_bit segment_joiner (
        .pattern(pattern),
        .dot(dot),
        .segment(segment)
    );

endmodule