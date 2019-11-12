`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2019 09:43:30 PM
// Design Name: 
// Module Name: spi
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


module spi#(parameter size=25)(

    //inputs

    input clock,
    input reset,
    input clear,
    input masterClock,
    input bitInMaster,
    input selector,
    
    //outputs
    output loadFinish,
    output[size-1:0] dataOut
   
    );
    
    
    //generate the clock that will use in the spi operation depending on ghr FPGA clock and the master clock
    wire [1:0] clkOut;
    wire loadClk;
    shiftRegister#(2) clk(.clock(clock),.reset(reset),.clear(clear),.enable(selector),.bitIn(masterClock),.dataOut(clkOut),.load(loadClk));
    wire systemClock = clkOut[1];
    
    //the shift register that store the input from the master 
   
    shiftRegister#(size)  da(.clock(systemClock),.reset(reset),.clear(clear),.enable(selector),.bitIn(bitInMaster),.dataOut(dataOut),.load(loadFinish));

    
    
    
    
endmodule
