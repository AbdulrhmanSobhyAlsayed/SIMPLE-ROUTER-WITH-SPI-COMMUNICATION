`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2019 05:50:04 AM
// Design Name: 
// Module Name: dataOut
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


module dataOutput#(parameter size=8)(

    //inputs 
    
    input clock,
    input reset,
    input port1,
    input port2,
    input [size-1:0] port1Data,
    input [size-1:0] port2Data,
    
    //output
    
     output reg [size-1:0] portData
    );
    
    //this block to determine the out data from the system depnding on the active port      
    always@(posedge clock,posedge reset)
    begin
    portData<=0;
    if (reset)portData<=0;
    else if (port1) portData<= port1Data;
    else if (port2) portData <= port2Data;
     
    end
    
endmodule
