`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2019 04:08:03 PM
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
    input enable,
    input writeDes,
    input writeData,
    input writeCheck,
    input sendData,
    input errorData,
    input desPort,
    
    //outputs 
    
    output reg enableDes,
    output reg enableData,
    output reg enableCheck,
    output reg errorFlag,
    output reg enablePort1,
    output reg enablePort2
    );
    
    //initialize the current and next states
    
    reg[3:0] currentState,nextState;
    
    //encode the states 
    
    parameter[3:0] S0=4'b0000;
    parameter[3:0] S1=4'b0001;
    parameter[3:0] S2=4'b0010;
    parameter[3:0] S3=4'b0011;
    parameter[3:0] S4=4'b0100;
    parameter[3:0] S5=4'b0101;
    parameter[3:0] S6=4'b0110;
    parameter[3:0] S7=4'b0111;
    parameter[3:0] S8=4'b1000;
    parameter[3:0] S9=4'b1001;
    parameter[3:0] S10=4'b1010;
    parameter[3:0] S11=4'b1011;
    parameter[3:0] S12=4'b1100;



    
    //this block to chang the state with positive edge of the clock cycle
    
    always@(posedge clock,posedge reset)
    begin
    if (reset) currentState <= S0;
    else currentState <= nextState;
    end
    
    // this block to define the next state
    
    always@(*)
    begin
    
    nextState = currentState;
    
    case(currentState)
    
    //define the next state if the current state S0
    
    S0:if (enable) nextState = S1;
    
    //define the next state if the current state S1
    
    S1:if (writeDes) nextState = S2;
    
    //define the next state if the current state S2
    
    S2:nextState=S3;
    
    //define the next state if the current state S3
    
    S3: if (writeData) nextState = S4;
    
    //define the next state if the current state S4
    
    S4:nextState=S5;
    
    
    //define the next state if the current state S5
    
    S5:if(writeCheck) nextState = S6;
    
    //define the next state if the current state S6
    
    S6:nextState=S7;
    
    //define the next state if the current state S7
    
    S7: if (sendData) nextState = S8;
    
    //define the next state if the current state S8
    
    S8:
    begin
    if (errorData) nextState=S9;
    else nextState=S10;
    end
    
    //define the next state if the current state S9
    
    S9:if (~enable) nextState=S0;
    
    //define the next state if the current state S10
    
    S10:
    begin
    if (desPort) nextState=S11;
    else nextState =S12;
    end
    
    //define the next state if the current state S11
    
    S11:if(~enable) nextState=S0;
    
    //define the next state if the current state S11
    
    S12:if(~enable) nextState=S0;
    

   
    endcase
    end
    
    // generate the moore output for each state
    
    always@(*)
    begin
    
    {enableDes,enableData,enableCheck}=3'b000;
    {enablePort1,enablePort2,errorFlag}=3'b000;
    
    case(currentState)
    
    //the output in S2
    
    S2: enableDes = 1'b1;
    
    //the output in S4
    
    S4: enableData = 1'b1;
    
    //the output in S6
    
    S6: enableCheck = 1'b1;
    
    //the output in S9
    
    S9: errorFlag = 1'b1;
    
    //the output in S11
    
    S11: enablePort2 = 1'b1;
    
    //the output in S12
    
    S12: enablePort1 = 1'b1;
    
    endcase
    end
    
endmodule
