////////////////
/// PROGRAME COUNTER 
//////////////
`timescale 1ps/1ps 

 module PCREG (
		output reg [31:0] dout , 
		input rest,clk,  
		input [31:0] din 
 
 ); 
	always @(posedge clk, posedge rest)
		begin  #50
 
 
			if (rest)
			      dout <=0; 
				  
			else dout<= din;

		end 

 endmodule 