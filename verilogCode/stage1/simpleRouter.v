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
    
//    output [size-1:0] portData,
    output[15:0] LED,
    output [6:0] seg,
    output [3:0] an,
    output dp

    );
    
    // internal signals 

    wire writeDesLevel,writeDataLevel,writeCheckLevel,sendDataLevel;
    wire errorData,desPort,enableDes,enableData,enableCheck;
    wire port1,port2,errorFlag;
    wire [7:0] outDes,outData;
    wire [7:0]data,destnation,port1Data,port2Data,portData;
    wire [8:0]checkSum;
    wire [11:0] outBCD;
    
    //the output led 
    
   generateLed   led(.reset(reset),.clock(clock),.input1(port1),.input2(port2),.input3(errorFlag),.led(LED)); 
   
    // this module to define the the input for each register in the pucket
    
    dataInput#(size) in(.clock(clock),.reset(reset),.writeDes(writeDesLevel),.writeData(writeDataLevel),.writeCheck(writeCheckLevel),
                        .dataIn(dataIn),.destnation(destnation),.data(data),.checkSum(checkSum));
                        
     // this module to define the output port                    
   
    dataOutput#(size)  out(.clock(clock),.reset(reset),.port1(port1),.port2(port2),.portData(portData),.port1Data(port1Data),.port2Data(port2Data));
    
    //these modules to control the push button inputs 
        
    level  enbDes(.clock(clock),.reset(reset),.pos(writeDes),.neg(writeData),.level(writeDesLevel));
    
    level  enbData(.clock(clock),.reset(reset),.pos(writeData),.neg(writeCheck),.level(writeDataLevel));
    
    level  enbCheck(.clock(clock),.reset(reset),.pos(writeCheck),.neg(sendData),.level(writeCheckLevel));
    
    level  send(.clock(clock),.reset(reset),.pos(sendData),.neg(~enable),.level(sendDataLevel));
    

    //this is the controller of the system 
    
    controller    cont(.clock(clock),
                       .reset(reset),
                       .enable(enable),
                       .writeDes(writeDesLevel),
                       .writeData(writeDataLevel),
                       .writeCheck(writeCheckLevel),
                       .sendData(sendDataLevel),
                       .errorData(errorData),
                       .desPort(desPort),
                       .enableDes(enableDes),
                       .enableData(enableData),
                       .enableCheck(enableCheck),
                       .errorFlag(errorFlag),
                       .enablePort1(port1),
                       .enablePort2(port2));
                       
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
