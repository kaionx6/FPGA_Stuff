`timescale 1ns / 1ps
// Board support, separate from the synchronous-reset display core.
// 100 MHz * 6 / 120 = 5 MHz; MMCM VCO = 600 MHz.
module clockReset7Series(
    input wire clk100,
    input wire reset_in,
    output wire clk5,
    output wire reset
);
    wire clk_in, feedback_raw, feedback, clk5_raw, locked;
    IBUF input_buffer (.I(clk100), .O(clk_in));
    BUFG feedback_buffer (.I(feedback_raw), .O(feedback));
    BUFG output_buffer (.I(clk5_raw), .O(clk5));
    MMCME2_BASE #(
        .BANDWIDTH("OPTIMIZED"),
        .CLKIN1_PERIOD(10.0),
        .DIVCLK_DIVIDE(1),
        .CLKFBOUT_MULT_F(6.0),
        .CLKOUT0_DIVIDE_F(120.0),
        .CLKOUT0_DUTY_CYCLE(0.5),
        .STARTUP_WAIT("FALSE")
    ) mmcm (
        .CLKIN1(clk_in), .CLKFBIN(feedback),
        .CLKFBOUT(feedback_raw), .CLKFBOUTB(),
        .CLKOUT0(clk5_raw), .CLKOUT0B(),
        .CLKOUT1(), .CLKOUT1B(), .CLKOUT2(), .CLKOUT2B(),
        .CLKOUT3(), .CLKOUT3B(), .CLKOUT4(), .CLKOUT5(), .CLKOUT6(),
        .LOCKED(locked), .PWRDWN(1'b0), .RST(reset_in)
    );
    wire reset_request = reset_in || !locked;
    // Assert immediately; release on the 5 MHz clock after two rising edges.
    (* ASYNC_REG = "TRUE" *) reg [1:0] reset_pipe = 2'b11;
    always @(posedge clk5 or posedge reset_request)
        if (reset_request) reset_pipe <= 2'b11;
        else reset_pipe <= {reset_pipe[0], 1'b0};
    assign reset = reset_pipe[1];
endmodule
