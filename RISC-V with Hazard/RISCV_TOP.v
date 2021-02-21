////////////////
//// RISCV-32 TOP MODULE 
////////////////

`timescale 1ps/1ps 

module RISCV_TOP(

			output dm_we ,
			output [31:0] pc ,  MEM_wDATA, 
			output [7:0]MEM_addr, 
			
			input clk, rset,
			input [31:0] ins, MEM_rData
			
			); 



		wire beq, pc_sel, RF_wet, a_sel, b_sel, dmwe_ct_r1;
		wire [2:0] imm_sel;
		wire [3:0] alu_sel;
		wire [1:0] wb_sel ;
		wire [31:0]  insx_oop ;
		wire [31:0]REG1_OP, REG2_OP; 
		assign dm_we =REG1_OP[2]; 

     Control_Unit ctrl (.ins(insx_oop),
                   .beq(beq),
				   .pcsel(pc_sel),
				   .imm_sel(imm_sel),
				   .RF_we(RF_wet),
				   .a_sel(a_sel),
				   .b_sel(b_sel),
				   .alu_sel(alu_sel),
				   .dm_we(dmwe_ct_r1),
				   .wb_sel(wb_sel));
				   
	
	 DATA_PATH dp (.clk(clk),
				 .rest(rset),
				 .pc_sel(pc_sel),
				 .imm_sel(imm_sel),
				 .wb_sel(REG1_OP[1:0]),
				 .RF_we(REG2_OP[0]),
				 .a_sel(a_sel),
				 .b_sel(b_sel),
				 .alu_sel(alu_sel),
				 .insx_op( insx_oop), 
				 .beq(beq),
				 .ins(ins),
				 .pc(pc),
				 .MEM_addr(MEM_addr),
				 .MEM_rData(MEM_rData),
				 .MEM_wDATA(MEM_wDATA));
				 
				 
				 
				 /**********************REG ***********************************/
				 
			REG  R1( .dout(REG1_OP) , .rest(rset),.clk(clk), .din({28'b0, RF_wet, dmwe_ct_r1 , wb_sel}) ); 
			REG  R2( .dout(REG2_OP) , .rest(rset),.clk(clk), .din({31'b0, REG1_OP[3]}) ); 
						   
					   
				   
endmodule