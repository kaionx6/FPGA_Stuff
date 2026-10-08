`timescale 1ns / 1ps

// Connect the four circuit blocks. This is the module the course testbench uses.
// Default: five hex digits, 1 ms per digit at the required 5 MHz clock.
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
    wire [2:0] sample_position;
    wire capture, running, blank;
    wire [3:0] number;
    wire dot;

    scan_controller #(.NDIGIT(NDIGIT), .SLOT_CYCLES(SLOT_CYCLES)) timing (
        .clock(clock), .reset(reset), .position(position),
        .sample_position(sample_position), .capture(capture),
        .running(running), .blank(blank)
    );
    digit_selector #(.NDIGIT(NDIGIT)) selection (
        .value(value), .dots(dots), .position(sample_position),
        .number(number), .dot(dot)
    );
    segment_driver segments (
        .clock(clock), .reset(reset), .capture(capture), .running(running),
        .number(number), .dot(dot), .segment(segment)
    );
    digit_driver #(.NDIGIT(NDIGIT)) digits (
        .position(position), .blank(blank), .digit(digit)
    );
endmodule
