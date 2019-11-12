`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2019 05:18:48 AM
// Design Name: 
// Module Name: dataInput
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


module dataInput#(parameter size=8)(
    
    //inputs 
    
    input clock,
    input reset,
    input writeDes,
    input writeData,
    input writeCheck,
    input[size:0] dataIn,
    
    //outputs
    
    output reg[size-1:0]destnation,
    output reg[size-1:0]data,
    output reg[size:0]checkSum
    );
    
    //this block to determine the input value of each register 
    //after the user enter the value by switches he will enter the one of the push button 
    always@(posedge clock)
    begin
    {destnation,data,checkSum}<=0; 
    if (reset) {destnation,data,checkSum}<=0;
    else if (writeDes) destnation <= dataIn;
    else if(writeData) data<=dataIn;
    else if (writeCheck) checkSum<=dataIn;
   
    end
endmodule
