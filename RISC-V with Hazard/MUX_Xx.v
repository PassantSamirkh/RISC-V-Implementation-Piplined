//////
/// MUX4 TO 1
///////


module MUX_Xx (
			output reg[31:0] MUX_X , 
			input[1:0]	 sel ,
      		input [31:0] rx1 ,rx2, rx3, rx4  



); 


		always @(*)
		begin 
		#10
		 if(sel== 2'b00)
			 MUX_X=rx1;
	      else if(sel== 2'b01)
			 MUX_X=rx2;
			 
			else if(sel== 2'b10)
			 MUX_X=rx3;
		
			else   MUX_X=rx4;
		
		end 

endmodule 