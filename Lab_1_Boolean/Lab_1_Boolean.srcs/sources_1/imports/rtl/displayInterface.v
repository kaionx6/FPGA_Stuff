`timescale 1ns / 1ps

// Main display core: five digits, 1 ms per digit at a 5 MHz clock.
module displayInterface #(
    parameter NDIGIT = 5,
    parameter SLOT_CYCLES = 5000
)(
    input  wire                  clock,
    input  wire                  reset,
    input  wire [4*NDIGIT-1:0]    value,
    input  wire [NDIGIT-1:0]      dots,
    output wire [7:0]            digit,
    output wire [7:0]            segment
);
    wire [2:0] position;
    wire [3:0] number;
    wire dot, capture, running, blank;

    scan_select #(.NDIGIT(NDIGIT), .SLOT_CYCLES(SLOT_CYCLES)) scanning (
        .clock(clock), .reset(reset), .value(value), .dots(dots),
        .position(position), .number(number), .dot(dot),
        .capture(capture), .running(running), .blank(blank)
    );

    segment_driver segments (
        .clock(clock), .reset(reset), .capture(capture), .running(running),
        .number(number), .dot(dot), .segment(segment)
    );

    digit_driver #(.NDIGIT(NDIGIT)) digits (
        .position(position), .blank(blank), .digit(digit)
    );
endmodule
