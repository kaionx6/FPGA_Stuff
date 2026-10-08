`timescale 1ns / 1ps

module test_shifter();

    // DECLARE INPUT SIGNALS
    reg clk;
    reg A;

    // DECLARE OUTPUT SIGNALS
    wire [15:0] led;

    // INSTANTIATE DUT
    shifter dut(clk, A, led);

    // STIMULI
    initial
    begin
        clk = 0;
        A = 1'b1; #20;
        A = 1'b0; #30;
        A = 1'b1;
    end

    // GENERATE CLOCK
    always
    begin
        #5 clk = ~clk;
        // invert clock every 5 time units
    end

endmodule
