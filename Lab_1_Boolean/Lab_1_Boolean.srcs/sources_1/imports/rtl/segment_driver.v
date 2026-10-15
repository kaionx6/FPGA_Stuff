`timescale 1ns / 1ps

// Data block: remember the selected number/dot for one complete slot,
// use the supplied lookup table, and join the segment and dot wires.
module segment_driver(
    input  wire       clock,
    input  wire       reset,
    input  wire       capture,
    input  wire       running,
    input  wire [3:0] number,
    input  wire       dot,
    output wire [7:0] segment
);
    reg [3:0] stored_number;
    reg stored_dot;
    wire [6:0] pattern;

    always @(posedge clock) begin
        if (reset) begin
            stored_number <= 4'd0;
            stored_dot    <= 1'b0;
        end else if (capture) begin
            stored_number <= number;
            stored_dot    <= dot;
        end
    end

    // Course lookup: preserve its original file. Its ports are number/pattern.
    hex2seg lookup (.number(stored_number), .pattern(pattern));

    // segment[7:1] = A B C D E F G; segment[0] = decimal point.
    // Incoming dot is 1=ON, so invert it for the active-low physical output.
    assign segment = running ? {pattern, ~stored_dot} : 8'hFF;
endmodule
