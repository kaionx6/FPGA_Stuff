`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2026 19:29:47
// Design Name: 
// Module Name: Choose_4_bit
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


module Choose_4_bit(
    input wire [19:0] value,
    input wire [2:0] count,
    output reg [3:0] number
);

    always @(*)
    begin
        case (count)
            3'd0: number = value[3:0];
            3'd1: number = value[7:4];
            3'd2: number = value[11:8];
            3'd3: number = value[15:12];
            3'd4: number = value[19:16];
            default: number = 4'd0;
        endcase
    end

endmodule