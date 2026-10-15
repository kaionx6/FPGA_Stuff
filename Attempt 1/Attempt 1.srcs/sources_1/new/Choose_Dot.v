`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2026 19:34:43
// Design Name: 
// Module Name: Choose_Dot
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


module Choose_Dot(
    input wire [4:0] dots,
    input wire [2:0] count,
    output reg dot
);

    always @(*)
    begin
        case (count)
            3'd0: dot = dots[0];
            3'd1: dot = dots[1];
            3'd2: dot = dots[2];
            3'd3: dot = dots[3];
            3'd4: dot = dots[4];
            default: dot = 1'b0;
        endcase
    end

endmodule