`timescale 1ns / 1ps

// Reference lookup for initial functional tests, using the tested ROM patterns.
// This is NOT the supplied course file. For the final lab project, use the
// lecturer's unmodified hex2seg.v instead. Do not compile two hex2seg modules.
module hex2seg(input wire [3:0] number, output reg [6:0] pattern);
    always @* begin
        case (number)
            4'h0: pattern = 7'h01;
            4'h1: pattern = 7'h4F;
            4'h2: pattern = 7'h12;
            4'h3: pattern = 7'h06;
            4'h4: pattern = 7'h4C;
            4'h5: pattern = 7'h24;
            4'h6: pattern = 7'h20;
            4'h7: pattern = 7'h0F;
            4'h8: pattern = 7'h00;
            4'h9: pattern = 7'h04;
            4'hA: pattern = 7'h08;
            4'hB: pattern = 7'h60;
            4'hC: pattern = 7'h31;
            4'hD: pattern = 7'h42;
            4'hE: pattern = 7'h30;
            4'hF: pattern = 7'h38;
            default: pattern = 7'h7F;
        endcase
    end
endmodule
