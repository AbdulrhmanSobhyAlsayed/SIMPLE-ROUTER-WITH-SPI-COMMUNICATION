`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2019 01:53:53 AM
// Design Name: 
// Module Name: multiplexer
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


module demultiplexer#(parameter size=2)(

    //inputs
    
    input [1:0]selector,
    input enable,
    input [size-1:0] dataIn,
    
    //outputs
    output reg[size-1:0] data0,
    output reg [size-1:0] data1
    
    );
    
    always@(posedge enable)
    begin
    {data0,data1}=0;
    if (selector[0]&&~selector[1] ) data1 = dataIn;
    else if (~selector[0]&&~selector[1])  data0 = dataIn;
    end 
endmodule
