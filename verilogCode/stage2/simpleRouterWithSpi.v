`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2019 01:33:27 AM
// Design Name: 
// Module Name: simpleRouterWithSpi
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


module simpleRouterWithSpi#(parameter size=8)(

    //inputs
    
    input clock,
    input reset,
    input selector,
    input bitIn,
    input masterClock,
    
    //outputs 
    
    output [15:0] LED,
    output  error,
//    output [size-1:0]dataOut
    output [6:0] seg,
    output [3:0] an,
    output dp

    );
    
  //internal signals

    wire [size-1:0]dataOut,dataOut1,dataOut2;
    wire [11:0]outBCD;
    wire loadFinish,errorData,enableSpi,enableRegs,desPort,port1,port2;
    
    



    //to determine the output value from the system
    
    dataOutput#(size)  out(.clock(clock),.reset(reset),.port1(port1),.port2(port2),.portData(dataOut),
                           .port1Data(dataOut1),.port2Data(dataOut2));
           
    //data path of the system
    
    dataPath#(size)   path(.clock(clock),.reset(reset),.enableSpi(enableSpi),
                           .enableRegs(enableRegs),.enablePort1(port1),.enablePort2(port2),
                           .bitIn(bitIn),.masterClock(masterClock),.portData1(dataOut1),.portData2(dataOut2),.errorData(errorData),
                           .desPort(desPort),.loadFinish(loadFinish));
    

  // controller of the system
  
  controller   con(.clock(clock),.reset(reset),.selector(selector),.errorData(errorData),.desPort(desPort), .loadFinish(loadFinish),
                    .enableSpi(enableSpi),.enableRegs(enableRegs),.errorFlage(error),.enablePort1(port1),
                    .enablePort2(port2),.errorPortLed(LED));
    
    // convert from binary to BCD
    
    BCD conv(.number(dataOut),.hundreds(outBCD[11:8]), .tens(outBCD[7:4]), .ones(outBCD[3:0]));
    
    //display in 7-segment
    
    displayBCD dis(.DataIn(outBCD),.clk(clock),.clr(reset),.seg(seg),.an(an),.dp(dp));
endmodule
