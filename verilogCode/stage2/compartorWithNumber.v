`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2019 07:52:35 PM
// Design Name: 
// Module Name: compartorWithNumber
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


module comparatorWithNumber#(parameter size=8,value=128)(
    input[size-1:0] source1,
    output reg result
    );
    
    reg[size-1:0] source2=value;
    
    always@(*)
    begin
    if(source1>=source2) result = 1'b1;
    else result =1'b0;
    end
endmodule
