`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2026 22:28:26
// Design Name: 
// Module Name: test_full_adder
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


module test_full_adder (

);

reg A;
reg B;
reg CIN;

wire SUM ;
wire COUT ;

//instantiate DUT

full_adder dut (A,B,CIN,SUM,COUT);

initial
begin

A=0; B =0; CIN= 0; #10;
A=0; B =0; CIN= 1; #10;
A=0; B =1; CIN= 0; #10;
A=0; B =1; CIN= 1; #10;
A=1; B =0; CIN= 0; #10;
A=1; B =0; CIN= 1; #10;
A=1; B =1; CIN= 0; #10;
A=1; B =1; CIN= 1; #10;


end

endmodule
