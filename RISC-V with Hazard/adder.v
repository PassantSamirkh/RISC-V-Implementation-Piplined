/////////////
//ADDER 
/////////////

`timescale 1ps/1ps 

module adder (
			output [31:0]PC_pLUS4,  
			input [31:0]PC , b
);

		assign #10 PC_pLUS4= PC + b ; 





endmodule 