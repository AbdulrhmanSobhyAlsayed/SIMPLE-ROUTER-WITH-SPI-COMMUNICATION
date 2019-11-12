`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2019 12:21:14 AM
// Design Name: 
// Module Name: simpleRouter
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


module simpleRouter#(parameter size=8,value=128)(

    //inputs
    
    input clock,
    input reset,
    input enable,
    input writeDes,
    input writeData,
    input writeCheck,
    input sendData,
    input [size:0] dataIn,
    
    //outputs 
    
    output [size-1:0] portData,
    output[1:0] port1Led,
    output[1:0] port2Led,
    output[1:0] errorFlagLed,
    output [6:0] seg,
    output [3:0] an,
    output dp

    );
    
    // internal signals 

    wire writeDesLevel,writeDataLevel,writeCheckLevel,sendDataLevel;
    wire errorData,desPort,enableDes,enableData,enableCheck;
    wire port1,port2,errorFlag;
    wire [7:0] outDes,outData;
    wire [7:0]data,destnation,port1Data,port2Data;
    wire [8:0]checkSum;
    wire [11:0] outBCD;
    
    //the output led equations
    
    assign port1Led = {port1,port1};
    assign port2Led = {port2,port2};
    assign errorFlagLed ={errorFlag,errorFlag};
   
   
                       
    //this is the datapath of the system 
                  
    dataPath#(size,value)    path(.clock(clock),
                                  .reset(reset),
                                  .enableDes(enableDes),
                                  .enableData(enableData),
                                  .enableCheck(enableCheck),
                                  .enablePort1(port1),
                                  .enablePort2(port2),
                                  .destnation(destnation),
                                  .data(data),
                                  .checkSum(checkSum),
                                  .port1Data(port1Data),
                                  .port2Data(port2Data),
                                  .errorData(errorData),
                                  .desPort(desPort));
                                  
     // convert from binary to BCD
     
     BCD conv(.number(portData),.hundreds(outBCD[11:8]), .tens(outBCD[7:4]), .ones(outBCD[3:0]));
     
     //display in 7-segment
     
     displayBCD dis(.DataIn(outBCD),.clk(clock),.clr(reset),.seg(seg),.an(an),.dp(dp));
     
     


    
endmodule
