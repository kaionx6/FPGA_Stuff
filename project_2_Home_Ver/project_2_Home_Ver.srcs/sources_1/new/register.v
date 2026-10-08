module shifter(
    input clk,
    input A,
    output [15:0] led
);

    // 15-bit SHIFT REGISTER
    reg [15:0] SHIFT_REG = 0;

    always @(posedge clk_1HZ)
    begin
        SHIFT_REG[15:0] <= {SHIFT_REG[14:0], A};
        // shift all bits one position to the left, bring in A from the right
    end

    // OUTPUT TO LEDS
    assign led = SHIFT_REG;

    // CLOCK DIVIDER
    reg clk_1HZ = 0;
    reg [25:0] counter_for_clk_1HZ = 0;
    // 26-bit register to count 50M at 10ns clock

    always @(posedge clk)
    begin
        if (counter_for_clk_1HZ == 26'd50000000)
        begin
            counter_for_clk_1HZ <= 0;
            clk_1HZ <= ~clk_1HZ;
        end
        else
            counter_for_clk_1HZ <= counter_for_clk_1HZ + 1;
    end

    // assign clk_1HZ = clk;

endmodule
