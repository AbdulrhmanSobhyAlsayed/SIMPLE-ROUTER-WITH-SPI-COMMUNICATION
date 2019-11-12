`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2019 07:26:59 PM
// Design Name: 
// Module Name: generateLed
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


module generateLed(
    //inputs
    input reset,
    input clock,
    input input1,
    input input2,
    input input3,
    //outputs
    output reg [15:0]led

    );
    
    always@(posedge clock,posedge reset)
    begin 

    if (reset) led<=6'b0000000000000000;
    else if (input1) led[7:0] =8'b11111111;   //port1
    else if (input2)  led[15:8] =8'b11111111; //port2
    else if (input3)  led<= 16'b1111111111111111; // error
    else  led <=16'b0000000000000000;
    
    end 
endmodule
