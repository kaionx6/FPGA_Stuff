`timescale 1ns / 1ps
// Shared board support: clock/reset, switches, and a visible test value.
// FIXED_TEST=1 displays 12345 hex. FIXED_TEST=0 uses the lab counter pattern.
module displayBoardCore #(
    parameter FIXED_TEST = 1,
    parameter SLOT_CYCLES = 5000
)(
    input wire clk100,
    input wire reset_button,
    input wire [5:0] sw,
    output wire [7:0] digit,
    output wire [7:0] segment
);
    wire clk5, reset;
    clockReset7Series clock_gen (
        .clk100(clk100), .reset_in(reset_button), .clk5(clk5), .reset(reset)
    );
    (* ASYNC_REG = "TRUE" *) reg [5:0] sw_meta = 6'b0;
    (* ASYNC_REG = "TRUE" *) reg [5:0] sw_sync = 6'b0;
    always @(posedge clk5) begin
        if (reset) begin
            sw_meta <= 0;
            sw_sync <= 0;
        end else begin
            sw_meta <= sw;
            sw_sync <= sw_meta;
        end
    end
    reg [29:0] testCount;
    always @(posedge clk5)
        if (reset) testCount <= 0;
        else testCount <= testCount + 1'b1;
    wire [19:0] count_value = {testCount[29:26], testCount[28:25],
                               testCount[27:24], testCount[26:23], testCount[25:22]};
    wire [19:0] value = FIXED_TEST ? 20'h12345 : count_value;
    wire [4:0] dots = {sw_sync[5] | sw_sync[4], sw_sync[3:0]};
    wire [7:0] core_digit, core_segment;
    displayInterface #(.NDIGIT(5), .SLOT_CYCLES(SLOT_CYCLES)) display_unit (
        .clock(clk5), .reset(reset), .value(value), .dots(dots),
        .digit(core_digit), .segment(core_segment)
    );
    // Hold the physical display off while its MMCM is stopped or not locked.
    // This board-level gate leaves the core's synchronous reset unchanged.
    assign digit = reset ? 8'hFF : core_digit;
    assign segment = reset ? 8'hFF : core_segment;
endmodule
