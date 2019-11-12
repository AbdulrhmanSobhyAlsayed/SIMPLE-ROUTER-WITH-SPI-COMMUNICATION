`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2019 06:43:19 PM
// Design Name: 
// Module Name: clockDivider
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


module clockDivider(

    //inputs 
    input clockIn,
    input reset,
    
    //outputs
    
    output clockOut
    );
    
    //internal signal
    
    reg [29:0] counter;
    
    //the counter 
    always@(posedge clockIn,posedge reset)
    begin
    if(reset) counter <= 0;
    else counter <= counter+1;
    end
    
    //the output of equation 
    assign clockOut = counter[1];
endmodule
