`timescale 1ns / 1ps
// Hardware top for Nexys A7; CPU RESET button is active low.
module displayTestNexys #(
    parameter FIXED_TEST = 1,
    parameter SLOT_CYCLES = 5000
)(
    input wire clk100,
    input wire rstPBn,
    input wire [5:0] sw,
    output wire [7:0] digit,
    output wire [7:0] segment
);
    displayBoardCore #(.FIXED_TEST(FIXED_TEST), .SLOT_CYCLES(SLOT_CYCLES)) board_core (
        .clk100(clk100), .reset_button(~rstPBn), .sw(sw),
        .digit(digit), .segment(segment)
    );
endmodule
