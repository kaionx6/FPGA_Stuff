`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2026 18:38:36
// Design Name: 
// Module Name: DigitSignal
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


module DigitSignal(
    input wire [2:0] count,
    output reg [7:0] digit
);

    always @(*)
    begin
        case (count)
            3'd0: digit = 8'b11111110;
            3'd1: digit = 8'b11111101;
            3'd2: digit = 8'b11111011;
            3'd3: digit = 8'b11110111;
            3'd4: digit = 8'b11101111;
            default: digit = 8'b11111111;
        endcase
    end

endmodule