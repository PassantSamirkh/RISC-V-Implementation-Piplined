//////////////
////MUX 
///////////////////
  `timescale 1ps/1ps 
  
module MUX  (
			output reg [31:0] M_out, 
			input [31:0]M_IN1, M_in2 , 
			input sel  

); 

		always @(*)
		begin 
		#10
		 if(!sel)
			M_out<= M_IN1; 
			else M_out<=M_in2; 
		
		end 


 
endmodule 