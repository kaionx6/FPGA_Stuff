`timescale 1ns / 1ps

// Board adapter for the Real Digital Boolean board, xc7s50csga324-1.
// digit0/segment0 connect to the LEFT bank D0.
// digit1/segment1 connect to the RIGHT bank D1.
// segment[7:0] keeps the assignment's order: a b c d e f g dot.
module displayTestBoolean(
    input wire clk100,
    input wire rstPB,
    input wire [5:0] sw,
    output wire [3:0] digit0,
    output wire [3:0] digit1,
    output wire [7:0] segment0,
    output wire [7:0] segment1
);

    wire [7:0] digit;
    wire [7:0] segment;

    // Boolean BTN0 is active-high; displayTest expects an active-low button.
    displayTest test_hardware (
        .clk100(clk100),
        .rstPBn(~rstPB),
        .sw(sw),
        .digit(digit),
        .segment(segment)
    );

    // Logical positions 0-3 are on the right-hand bank D1.
    // Logical positions 4-7 are on the left-hand bank D0.
    assign digit0 = digit[7:4];
    assign digit1 = digit[3:0];

    // Both banks receive the same pattern. Only one digit is enabled.
    assign segment0 = segment;
    assign segment1 = segment;

endmodule

