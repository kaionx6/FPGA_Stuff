`timescale 1ns / 1ps
// Hardware top for Real Digital Boolean / XC7S50-CSGA324.
// BTN0 is active high; rstPB means 1 while pressed.
module displayTestBoolean #(
    parameter FIXED_TEST = 1,
    parameter SLOT_CYCLES = 5000,
    parameter SWAP_BANKS = 0
)(
    input wire clk100,
    input wire rstPB,
    input wire [5:0] sw,
    output wire [3:0] digit0, digit1,
    output wire [7:0] segment0, segment1
);
    wire [7:0] digit, segment;
    displayBoardCore #(.FIXED_TEST(FIXED_TEST), .SLOT_CYCLES(SLOT_CYCLES)) board_core (
        .clk100(clk100), .reset_button(rstPB), .sw(sw),
        .digit(digit), .segment(segment)
    );
    boolean_display_adapter #(.SWAP_BANKS(SWAP_BANKS)) bank_adapter (
        .digit(digit), .segment(segment),
        .digit0(digit0), .digit1(digit1),
        .segment0(segment0), .segment1(segment1)
    );
endmodule
