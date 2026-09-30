`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2026 21:38:51
// Design Name: 
// Module Name: full_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module full_adder(
    input A,
    input B,
    input CIN,
    output reg SUM,
    output reg COUT
    );
    
    reg p, g ;
    
    always@ (A, B, CIN)
        begin 
            p = A ^ B ;
            g = A & B ;
            SUM <= p ^ CIN ;
            COUT <= g | (p & CIN) ;
        end
        
endmodule
