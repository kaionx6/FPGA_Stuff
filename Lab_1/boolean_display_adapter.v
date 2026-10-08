`timescale 1ns / 1ps
// Split an eight-digit scan into the Boolean board's two four-digit banks.
// Segment buses keep the core order: [7:0] = A B C D E F G DP.
// Default: positions 0..3 use D0, positions 4..7 use D1.
// SWAP_BANKS=1 exchanges the two banks if required for physical reading order.
module boolean_display_adapter #(
    parameter SWAP_BANKS = 0
)(
    input wire [7:0] digit,
    input wire [7:0] segment,
    output wire [3:0] digit0, digit1,
    output wire [7:0] segment0, segment1
);
    assign digit0 = SWAP_BANKS ? digit[7:4] : digit[3:0];
    assign digit1 = SWAP_BANKS ? digit[3:0] : digit[7:4];
    assign segment0 = segment;
    assign segment1 = segment;
endmodule
