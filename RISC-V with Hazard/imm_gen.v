///////////////////
////IMMEDIATE GENERATE 
//////////////////////
`timescale 1ps/1ps 
module imm_gen(
			output reg [31:0] imm, 
			input [31:0] ins, 
			input [2:0] imm_sel
			);



	always @(*)
		begin #50
		 case (imm_sel)
					
							/*******I_type*******/
					3'b001 :imm = {{21{ins[31]}}, ins[30:20]};      // imm = {{21{ins[31]}}, ins[30:25], ins[11:7]};   
							/*******s_type***/
					3'b010 : imm = {{21{ins[31]}}, ins[30:25], ins[11:8], ins[7]};  
								/**********B TYPE **********/
					3'b011 : imm = {{20{ins[31]}}, ins[7],ins[30:25],ins[11:8],1'b0}; 
							
						/*******J_type***/
		
					3'b100 : imm = {{11{ins[31]}}, ins[19:12],ins[20],ins[30:21],1'b0}; 
							/**********ILLAGAL OP ****************/
					default: imm = 32'bx;                                                   
		 endcase
		end
endmodule