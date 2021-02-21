/////////////
/// BRANCH COMP
////////////////

`timescale 1ps/1ps 
module BR_COMP (
				output reg  beq , 
				input [31:0] rs1 , rs2 
); 
 

		always @(*)
		begin #10
		 if (rs1 ==rs2)
		
			beq = 1 ; 
		 else
		    beq =0 ; 
	
	
	
	  end



endmodule