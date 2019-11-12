`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2019 07:05:38 PM
// Design Name: 
// Module Name: register
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


module register #(parameter size=8)(
    
    //inputs
    
    input clock,
    input reset,
    input enable,
    input[size-1:0] dataIn,
    
    //output
    
    output reg [size-1:0] dataOut
    );
    
    always@(posedge clock,posedge reset)
    begin
    if(reset) dataOut <= 0;
    else if (enable) dataOut <= dataIn;
    else dataOut<=dataOut;
    end
endmodule
