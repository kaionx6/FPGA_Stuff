`timescale 1ns / 1ps

// Unit checks the partners can run before connecting their blocks.
module tb_blocks;
    reg [2:0] position;
    reg blank;
    wire [3:0] number;
    wire dot;
    wire [7:0] digit;
    digit_selector select5 (.value(20'h12345), .dots(5'b10101),
                            .position(position), .number(number), .dot(dot));
    digit_driver drive5 (.position(position), .blank(blank), .digit(digit));
    integer i;
    reg [3:0] expected_number;
    reg expected_dot;
    reg [7:0] expected_digit;
    initial begin
        blank = 0;
        for (i=0; i<8; i=i+1) begin
            position = i;
            expected_number = (i<5) ? (5-i) : 0;
            expected_dot = (i<5) && ((i%2)==0);
            expected_digit = (i<5) ? ~(8'b1 << i) : 8'hFF;
            #10;
            if (number !== expected_number || dot !== expected_dot || digit !== expected_digit)
                $fatal(1, "FAIL: selector/driver at position %0d", i);
            blank = 1;
            #10;
            if (digit !== 8'hFF) $fatal(1, "FAIL: blank did not turn everything off");
            blank = 0;
        end
        $display("PASS: blocks - nibble/dot selection, active-low digit control, invalid positions, and blanking");
        $finish;
    end
endmodule
