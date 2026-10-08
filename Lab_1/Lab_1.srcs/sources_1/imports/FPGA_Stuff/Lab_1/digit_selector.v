`timescale 1ns / 1ps

// Data block: the two multiplexers from Logisim.
// Pick one 4-bit number and its matching dot from the input bundles.
module digit_selector #(
    parameter NDIGIT = 5
)(
    input  wire [4*NDIGIT-1:0] value,
    input  wire [NDIGIT-1:0]   dots,
    input  wire [2:0]          position,
    output reg  [3:0]          number,
    output reg                dot
);
    always @* begin
        number = 4'd0;
        dot    = 1'b0;
        if (position < NDIGIT) begin
            // Each position moves another group of four bits to the right.
            number = value >> (4 * position);
            dot    = dots[position];
        end
    end
endmodule
