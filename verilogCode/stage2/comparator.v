`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2019 07:45:03 PM
// Design Name: 
// Module Name: comparator
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


module comparatorEquall #(parameter size=8)(
    input[size-1:0] source1,
    input[size-1:0] source2,
    output reg result
    );
    
    always@(*)
    begin
    if (source1!=source2) result = 1'b1;
    else result =1'b0;
    end 
endmodule
