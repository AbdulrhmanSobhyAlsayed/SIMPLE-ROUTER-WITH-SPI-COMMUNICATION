`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2019 04:50:41 PM
// Design Name: 
// Module Name: levelToPulse
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


module level(

    //inputs
    
    
    input clock,
    input reset,
    input pos,
    input neg,
    
    //outputs
    
    output reg level
    );
    
    // initialize the curren and next state
    
    reg  currentState,nextState;
    
    //encode the states 
    
    parameter S0=1'b0;
    parameter S1='b1;

    
    //this block to change from state to another
    
    always@(posedge clock, posedge reset)
    begin
    if (reset) currentState <= S0;
    else currentState <= nextState; 
    end
    
    //this block to define the next state
    
    always@(*)
    begin
    nextState = currentState;
    
    case(currentState)
    
    // the next state if the current state is S0
    
    S0: if (pos) nextState = S1;
    
    //the next state if the current state is S1
    
    S1:if (neg) nextState = S0;

    endcase
    end
    
    // the output for each state
    
    always@(*)
    begin
    
    if (currentState==S1) level=1'b1;
    else level=1'b0;
    
    end
    
endmodule
