`timescale 1ns / 1ps

// Timer, digit-position counter, and the two selection multiplexers.
module scan_select #(
    parameter NDIGIT = 5,
    parameter SLOT_CYCLES = 5000
)(
    input  wire                  clock,
    input  wire                  reset,
    input  wire [4*NDIGIT-1:0]    value,
    input  wire [NDIGIT-1:0]      dots,
    output reg  [2:0]            position,
    output reg  [3:0]            number,
    output reg                  dot,
    output wire                 capture,
    output reg                  running,
    output wire                 blank
);
    localparam TIMER_BITS = (SLOT_CYCLES < 2) ? 1 : $clog2(SLOT_CYCLES);
    reg [TIMER_BITS-1:0] timer;

    wire last_cycle = (timer == SLOT_CYCLES-1);
    wire [2:0] next_position = (position == NDIGIT-1)
                              ? 3'd0 : position + 3'd1;

    // At a slot boundary, select the upcoming digit before capturing its data.
    wire [2:0] sample_position = !running ? 3'd0
                              : last_cycle ? next_position : position;
    assign capture = !running || last_cycle;
    assign blank = !running || (timer == 0);

    always @(posedge clock) begin
        if (reset) begin
            timer    <= 0;
            position <= 0;
            running  <= 1'b0;
        end else if (!running) begin
            timer    <= 0;
            position <= 0;
            running  <= 1'b1;
        end else if (last_cycle) begin
            timer    <= 0;
            position <= next_position;
        end else begin
            timer <= timer + 1'b1;
        end
    end

    // Each hexadecimal number is a group of four bits; each dot is one bit.
    always @* begin
        number = 4'd0;
        dot = 1'b0;
        if (sample_position < NDIGIT) begin
            number = value[4*sample_position +: 4];
            dot = dots[sample_position];
        end
    end
endmodule
