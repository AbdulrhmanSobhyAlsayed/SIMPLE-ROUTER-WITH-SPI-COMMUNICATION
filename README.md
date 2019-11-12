# SIMPLE-ROUTER-WITH-SPI-COMMUNICATION

The project is designing a simple router and our router can receive a packet. After the router
receives the packet it will check if there any error occurs through the journey of the packet if
there is no error the router will send the data message which in the packet to the destination
port depending on the destination byte which in the packet. If there is an error occur during
the journey of the packet the router will detect the error and it will not send the data message
to the destination port and the error flag will be asserted.

The design and implementation stages
Stage1:
We design a simple router that its packet input from the FPGA’s switches and the output data
display in the FPGA’s four 7-segment display and the output port number display by the
FPGA’s LED.
Stage2:
We develop the design in stage 1. Since the simple router will receive the packet from the
Arduino by SPI protocol and the output data display in the FPGA’s four 7-segment display and
the output port number display by the FPGA’s led.
