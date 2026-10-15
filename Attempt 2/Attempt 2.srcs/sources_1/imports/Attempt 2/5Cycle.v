`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2026 18:08:47
// Design Name: 
// Module Name: 5Cycle
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

module Cycle_5(
    input wire clock,
    input wire reset,
    output reg [2:0] count
);

    reg [9:0] C;

    always @(posedge clock)
    begin
        if (reset)
        begin
            C <= 10'd0;
            count <= 3'd0;
        end
        else
        begin
            C <= C + 10'd1;

            if (C == 10'd1023)
            begin
                if (count == 3'd4)
                    count <= 3'd0;
                else
                    count <= count + 3'd1;
            end
        end
    end

endmodule