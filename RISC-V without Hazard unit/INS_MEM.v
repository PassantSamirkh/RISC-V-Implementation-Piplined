////////////////
//// INSTRUCTION MEM 
//////////////////
`timescale 1ps/1ps 
module INS_MEM(
				output [31:0] ins , 
				input [7:0] addr  
		

);
		 
		 reg [31:0] MEM [0:255]; 
		 initial 
		 $readmemh ( "fib.txt"  , MEM); 
		 assign #100 ins = MEM[addr]; 

 
endmodule 