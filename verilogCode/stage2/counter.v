`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2019 10:14:42 PM
// Design Name: 
// Module Name: counter
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


module counter#(parameter size = 25)(

    //input 
    
    input clock,
    input reset,
    input enable,
    input clear,
    //output
    
    output reg [size-1:0] countOut
    );
    
    
    always@(posedge clock,posedge reset,posedge clear)
    begin 
    
    if (reset) countOut<=0;
    else if (clear)countOut<=0;
    else if (enable) countOut<= countOut+1;
    else countOut<=0;
    
    
    end
endmodule
