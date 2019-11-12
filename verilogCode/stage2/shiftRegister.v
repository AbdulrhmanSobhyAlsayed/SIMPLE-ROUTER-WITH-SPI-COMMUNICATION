`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2019 06:45:08 PM
// Design Name: 
// Module Name: shiftRegister
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


module shiftRegister#(parameter size=25)(
    //inputs
    
    input clock,
    input reset,
    input enable,
    input clear,
    input bitIn,
    
    //output
    output reg[size-1:0] dataOut,
    output load
    );
    
    //the shift rigister 
    always@(posedge clock,posedge reset,posedge clear)
    begin
    
    if (reset) dataOut<=0;
    else if (clear) dataOut<=0;
    else if(enable) dataOut<= {dataOut[size-2:0],bitIn};
    else dataOut<=0;
 
    end
    
    //counter
    wire [size:0]countOut;
    counter#(size+1) cou(.clock(clock),.reset(reset),.enable(enable),.clear(clear),.countOut(countOut));
    
    assign load = (countOut == (size)); //to know if the shift register store 25 bit from the master input 
    
endmodule
