`timescale 1ns / 1ps

// Timing block: choose WHICH physical digit lights. Zero means ON.
module digit_driver #(
    parameter NDIGIT = 5
)(
    input  wire [2:0] position,
    input  wire       blank,
    output reg  [7:0] digit
);
    always @* begin
        digit = 8'hFF;
        if (!blank && (position < NDIGIT))
            digit[position] = 1'b0;
    end
endmodule
