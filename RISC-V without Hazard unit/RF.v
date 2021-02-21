////////////////
///// REGISTER FILE 
////////////////

`timescale 1ps/1ps 

module RF (
		output [31:0] r_data1, r_data2, 
		input clk, we, 
		input [4:0] r_add1, r_add2, w_add, 
		input [31:0] w_data 

); 
		reg [31:0] RF_R[0:31]; 
	/******************* WRITE DATA *******************/
		always @ (negedge clk)
		begin #50
		if (we)
			 RF_R[w_add]<= w_data; 
			 
		//else RF_R[w_add]<=RF_R[w_add]; 
		end 
		
		/**************READ DATA ******************/
		
		 assign #50 r_data1 = (r_add1==0)? 0 : RF_R[r_add1];
		
		 assign #50 r_data2 = (r_add2==0)? 0 : RF_R[r_add2];


endmodule 