`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2019 02:37:48 PM
// Design Name: 
// Module Name: controller
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


module controller(

    //inputs 
    input clock,
    input reset,
    input selector,
    input loadFinish,
    input errorData,
    input desPort,
    
    //outputs
    
    output reg enableSpi,
    output reg enableRegs,
    output reg enablePort1,
    output reg enablePort2,
    output reg errorFlage,
    output reg [15:0]errorPortLed
    
    );
    
    reg[2:0] currentState,nextState;

    
    parameter [2:0] S0=3'b000;
    parameter [2:0] S1=3'b001;
    parameter [2:0] S2=3'b010;
    parameter [2:0] S3=3'b011;
    parameter [2:0] S4=3'b100;
    parameter [2:0] S5=3'b101;
    parameter [2:0] S6=3'b110;
    parameter [2:0] S7=3'b111;
    
    always@(posedge clock,posedge reset)
    begin
    if (reset) currentState <= S0;
    else currentState <= nextState;
    end
    
     always@(*)
       begin
       
       nextState = currentState;
       
       case(currentState)
       
       //define the next state if the current state S0
       
       S0:if (selector) nextState = S1;
       
       //define the next state if the current state S1
       
       S1:if (loadFinish) nextState = S2;
       
       
       //define the next state if the current state S2
       
       S2: nextState =S3;
       
       //define the next state if the current state S3
       
       S3:
       begin
       if (errorData) nextState = S4;
       else nextState = S5;
       end
       
       //define the next state if the current state S4
       
       S4:if (~selector) nextState = S0;
       
       
       //define the next state if the current state S5
       
       S5:
       begin
       if(desPort) nextState = S6;
       else nextState = S7;
       end
       //define the next state if the current state S6
       
       S6:if (~selector) nextState = S0;
       
       //define the next state if the current state S7
       
       S7:if (~selector) nextState = S0;
       endcase 
       end
       
        // generate the moore output for each state
          
          always@(*)
          begin
          
          {enableSpi,enableRegs,enablePort1,enablePort2,errorFlage}=5'b00000;
          errorPortLed =16'b0000000000000000;
      
          case(currentState)
          
          //the output in S1
          
          S1: enableSpi = 1'b1;
          
          //the output in S2
          
          S2: enableRegs = 1'b1;
          
          //the output in S3
          
          S4: 
          begin
          errorFlage = 1'b1;
          errorPortLed =16'b1111111111111111;
          end
          
          
          //the output in S5
          
          S6:
          begin
           enablePort2 = 1'b1;
           errorPortLed[15:8] =8'b11111111;
          end
          
          
          //the output in S5
          
          S7:
          begin
           enablePort1 = 1'b1;
           errorPortLed[7:0] =8'b11111111;
          end
          
          endcase
          end
          
endmodule
