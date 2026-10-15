`timescale 1ns / 1ps

// Simulation only. Test the public outputs against a frame/slot schedule.
module display_checker #(
    parameter NDIGIT = 5,
    parameter SLOT_CYCLES = 8,
    parameter EXHAUSTIVE = 1
)(output reg done = 0);
    reg clock = 0;
    always #100 clock = ~clock; // 200 ns period = 5 MHz
    reg reset = 1;
    reg [4*NDIGIT-1:0] value = 0;
    reg [NDIGIT-1:0] dots = 0;
    wire [7:0] digit, segment;
    displayInterface #(.NDIGIT(NDIGIT), .SLOT_CYCLES(SLOT_CYCLES)) dut (
        .clock(clock), .reset(reset), .value(value), .dots(dots),
        .digit(digit), .segment(segment)
    );

    // Independent expected table: list segments that should be ON, then invert.
    function automatic [6:0] expected_pattern(input [3:0] n);
        reg [6:0] lit;
        begin
            case(n)
                0: lit = 7'b1111110;  1: lit = 7'b0110000;
                2: lit = 7'b1101101;  3: lit = 7'b1111001;
                4: lit = 7'b0110011;  5: lit = 7'b1011011;
                6: lit = 7'b1011111;  7: lit = 7'b1110000;
                8: lit = 7'b1111111;  9: lit = 7'b1111011;
               10: lit = 7'b1110111; 11: lit = 7'b0011111;
               12: lit = 7'b1001110; 13: lit = 7'b0111101;
               14: lit = 7'b1001111; 15: lit = 7'b1000111;
                default: lit = 0;
            endcase
            expected_pattern = ~lit;
        end
    endfunction

    integer edge_number = -1;
    integer expected_position;
    integer check_count = 0;
    reg [7:0] expected_digit, held_segment;
    reg [3:0] expected_number;
    always @(posedge clock) begin
        if (reset) begin
            edge_number = -1;
            expected_digit = 8'hFF;
            held_segment = 8'hFF;
        end else begin
            edge_number = edge_number + 1;
            expected_position = (edge_number / SLOT_CYCLES) % NDIGIT;
            // A digit's contents are sampled once, at the start of its slot.
            if ((edge_number % SLOT_CYCLES) == 0) begin
                expected_number = value[4*expected_position +: 4];
                held_segment = {expected_pattern(expected_number), ~dots[expected_position]};
                expected_digit = 8'hFF;
            end else begin
                expected_digit = ~(8'b1 << expected_position);
            end
        end
        #2;
        check_count = check_count + 1;
        if (digit !== expected_digit || segment !== held_segment)
            $fatal(1, "FAIL: N=%0d slot=%0d edge=%0d: digit=%h expected=%h, segment=%h expected=%h",
                   NDIGIT, SLOT_CYCLES, edge_number, digit, expected_digit, segment, held_segment);
        if ((digit | ((8'h01 << NDIGIT)-1)) !== 8'hFF)
            $fatal(1, "FAIL: an unused digit turned on");
    end

    integer n, d, i;
    reg [7:0] before_digit, before_segment;
    initial begin
        // Check reset held across several clocks, then run known distinct digits.
        repeat (3) @(negedge clock);
        reset = 0;
        value = (NDIGIT == 5) ? 24'h012345 : 24'hA12345;
        dots = 'h15;
        repeat (2*NDIGIT*SLOT_CYCLES) @(negedge clock);

        if (EXHAUSTIVE) begin
            // Every hex symbol on every position, combined with every dot mask.
            for (n = 0; n < 16; n = n+1)
                for (d = 0; d < (1 << NDIGIT); d = d+1) begin
                    for (i = 0; i < NDIGIT; i = i+1)
                        value[4*i +: 4] = (n + 3*i) % 16;
                    dots = d;
                    repeat (NDIGIT*SLOT_CYCLES) @(negedge clock);
                end
        end

        // Assert reset between rising edges: synchronous reset must wait.
        repeat (2*SLOT_CYCLES + 1) @(negedge clock);
        before_digit = digit;
        before_segment = segment;
        reset = 1;
        #25;
        if (digit !== before_digit || segment !== before_segment)
            $fatal(1, "FAIL: reset acted before the rising edge");
        repeat (2) @(negedge clock);
        reset = 0;
        value = (NDIGIT == 5) ? 24'h06789A : 24'hB6789A;
        dots = 'h0A;
        repeat (NDIGIT*SLOT_CYCLES) @(negedge clock);
        $display("PASS: N=%0d SLOT_CYCLES=%0d, %0d clock-edge checks", NDIGIT, SLOT_CYCLES, check_count);
        done = 1;
    end
endmodule

module tb_displayInterface;
    wire a, b, c, d;
    display_checker #(.NDIGIT(5), .SLOT_CYCLES(8))   fast_five(a);
    display_checker #(.NDIGIT(6), .SLOT_CYCLES(10))  fast_six(b);
    display_checker #(.NDIGIT(5), .SLOT_CYCLES(2))   minimum_slot(c);
    display_checker #(.NDIGIT(5), .SLOT_CYCLES(5000), .EXHAUSTIVE(0)) hardware_timing(d);
    initial begin
        wait (a && b && c && d);
        $display("PASS: displayInterface - scan order, all symbols/dot masks, blanking, held data, reset, and hardware timing");
        $finish;
    end
    initial begin
        #100000000;
        $fatal(1, "FAIL: simulation timed out");
    end
endmodule
