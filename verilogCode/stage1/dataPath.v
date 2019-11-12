`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2019 07:03:51 PM
// Design Name: 
// Module Name: dataPath
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


module dataPath #(parameter size = 8,value=128)(

    //inputs
    
    input clock,
    input reset,
    input enableDes,
    input enableData,
    input enableCheck,
    input enablePort1,
    input enablePort2,
    input[size-1:0] destnation,
    input[size-1:0] data,
    input[size:0] checkSum,
    
    //outputs
    
    output[size-1:0] port1Data,
    output[size-1:0] port2Data,
    output errorData,
    output desPort
    );
    
    //internal signals 
    wire [size-1:0] outDes,outData;
    wire [size:0]outCheck,adderValue;
    
    // the destnation register
    
    register#(size) desReg(.clock(clock),.reset(reset),.enable(enableDes),.dataIn(destnation),.dataOut(outDes));
    
    //the data register
    
    register#(size) dataReg(.clock(clock),.reset(reset),.enable(enableData),.dataIn(data),.dataOut(outData));
    
    //the checkSum register
    
    register#(size+1) checkReg(.clock(clock),.reset(reset),.enable(enableCheck),.dataIn(checkSum),.dataOut(outCheck));
    
    //the data of port1 register
    
    register#(size) outPort1(.clock(clock),.reset(reset),.enable(enablePort1),.dataIn(outData),.dataOut(port1Data));
    
    //the data of port2 register
    
    register#(size) outPort2(.clock(clock),.reset(reset),.enable(enablePort2),.dataIn(outData),.dataOut(port2Data));
    
    //the adder 
    
    adder#(size)    add(.source1(outDes),.source2(outData),.result(adderValue));    
    
    // the comparator the compare the output od adder with the distbation register
    
    comparatorEquall#(size+1) errD(.source1(adderValue),.source2(outCheck),.result(errorData));
    
    // the comparator that compare the output of the destnation register with value 128 to determine the desrnation port 
    
    comparatorWithNumber#(size,value) desP(.source1(outDes),.result(desPort));
    
    
endmodule
