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
    input enableSpi,
    input enableRegs,
    input enablePort1,
    input enablePort2,
    input bitIn,
    input masterClock,

    
    //outputs
    
    output[size-1:0] portData1,
    output[size-1:0] portData2,
    output  errorData,
    output desPort,
    output loadFinish
    );
    
    //internal signals 
    wire [size-1:0] outDes,outData;
    wire [size:0]adderValue,outCheck;
    wire [24:0] dataShift,data;
 
    
    
    //spi part of the datapath
    
    spi#(25) sp(.clock(clock),.reset(reset),.clear(enableRegs),.selector(enableSpi),.masterClock(masterClock),.bitInMaster(bitIn),
          .loadFinish(loadFinish),.dataOut(dataShift));
          
          
    //pipelin registe
    
    register#(25)   pi (.clock(clock),.reset(reset),.enable(enableSpi),.dataIn(dataShift),.dataOut(data));
    
    
    // the destnation register
    
    register#(size) desReg(.clock(clock),.reset(reset),.enable(enableRegs),.dataIn(data[24:17]),.dataOut(outDes));
    
    //the data register
    
    register#(size) dataReg(.clock(clock),.reset(reset),.enable(enableRegs),.dataIn(data[16:9]),.dataOut(outData));
    
    //the checkSum register
    
    register#(size+1) checkReg(.clock(clock),.reset(reset),.enable(enableRegs),.dataIn(data[8:0]),.dataOut(outCheck));
    
    //the data of port data  register
    
    register#(size) outPort1(.clock(clock),.reset(reset),.enable(enablePort1),.dataIn(outData),.dataOut(portData1));
    
    register#(size) outPort2(.clock(clock),.reset(reset),.enable(enablePort2),.dataIn(outData),.dataOut(portData2));
    
    
    //the adder 
    
    adder#(size)    add(.source1(outDes),.source2(outData),.result(adderValue));    
    
    // the comparator the compare the output od adder with the distbation register
    
    comparatorEquall#(size+1) errD(.source1(adderValue),.source2(outCheck),.result(errorData));
    
    // the comparator that compare the output of the destnation register with value 128 to determine the desrnation port 
    
    comparatorWithNumber#(size,value) desP(.source1(outDes),.result(desPort));
    

    
endmodule
