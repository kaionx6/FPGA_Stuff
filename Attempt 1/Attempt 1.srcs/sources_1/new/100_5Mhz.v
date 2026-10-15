`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2026 00:12:14
// Design Name: 
// Module Name: 100_5Mhz
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


module 100_5Mhz(
    input  wire clk100,
    input  wire reset_in,
    output wire clk5,
    output wire reset
    );

wire clk_in;

IBUF input_buffer (
    .I(clk100),
    .O(clk_in)
);

wire feedback_raw;
wire feedback;
wire clk5_raw;
wire locked;

BUFG feedback_buffer (
    .I(feedback_raw),
    .O(feedback)
);

BUFG output_buffer (
    .I(clk5_raw),
    .O(clk5)
);

MMCME2_BASE #(
    .CLKIN1_PERIOD(10.0),
    .DIVCLK_DIVIDE(1),
    .CLKFBOUT_MULT_F(6.0),
    .CLKOUT0_DIVIDE_F(120.0)
) mmcm (
    .CLKIN1(clk_in),
    .CLKFBIN(feedback),
    .CLKFBOUT(feedback_raw),
    .CLKOUT0(clk5_raw),
    .LOCKED(locked),
    .PWRDWN(1'b0),
    .RST(reset_in)
);

endmodule
