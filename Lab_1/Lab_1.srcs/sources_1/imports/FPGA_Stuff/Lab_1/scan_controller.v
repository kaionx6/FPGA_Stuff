`timescale 1ns / 1ps

// Timing block: the timer and the digit-position counter.
// One clock drives everything. A timer decides WHEN to move to the next digit.
module scan_controller #(
    parameter NDIGIT = 5,
    parameter SLOT_CYCLES = 5000
)(
    input  wire       clock,
    input  wire       reset,
    output reg  [2:0] position,
    output wire [2:0] sample_position,
    output wire      capture,
    output reg       running,
    output wire      blank
);
    localparam TIMER_BITS = (SLOT_CYCLES < 2) ? 1 : $clog2(SLOT_CYCLES);
    reg [TIMER_BITS-1:0] timer;
    wire last_cycle = (timer == SLOT_CYCLES-1);
    wire [2:0] next_position = (position == NDIGIT-1)
                                  ? 3'd0 : position + 3'd1;

    // On a slot boundary, the data path must sample the UPCOMING digit.
    assign sample_position = !running ? 3'd0
                              : last_cycle ? next_position : position;
    assign capture = !running || last_cycle;
    // Keep the anodes off for one clock while the new segment pattern settles.
    assign blank = !running || (timer == 0);

    // Reset is synchronous: it acts only at a rising clock edge.
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
endmodule
