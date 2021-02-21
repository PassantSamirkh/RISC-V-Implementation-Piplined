///////////
//CONTROL UNIT 
////////////

`timescale 1ps/1ps 


module Control_Unit(
			output reg pcsel , RF_we, dm_we, b_sel , a_sel , 
			output reg [1:0]wb_sel , 
			output reg [2:0] imm_sel , 
			output reg [3:0]alu_sel , 
			input [31:0] ins, 
			input beq 
  
    );
	//parameter  NOPE =7'b000_0000; //DEFAULT 
	parameter  LW=7'b000_0011 ; 
	parameter  SW=7'b010_0011 ; 
	parameter  OP_I=7'b001_0011 ; //ADDI , ANDI , ORI 
	parameter  OP=7'b011_0011 ;   //ADD , AND , OR
	parameter  JAL =7'b110_1111 ; 
	parameter  JALR =7'b110_0111 ; 
	parameter  BRANCH =7'b110_0011 ; 
	
	
	
	


				always @(*)
				begin #50
				 case(ins[6:0]) 
						/******** I TYPE **********/
				 LW: begin 
						pcsel=0; 
						RF_we=1; 
						dm_we=0; 
						a_sel =0; //rs1 
						b_sel =1; //rs2 
						wb_sel=2'b00; 
						imm_sel = 3'b001; 
						alu_sel = 4'b0000;
				 
				 end
						/*******S TYPE *******/				 
				SW: begin 
						pcsel=0; 
						RF_we=0; 
						dm_we=1; 
						a_sel =0;
						b_sel =1;
						wb_sel=2'b00; 
						imm_sel = 3'b010; 
						alu_sel = 4'b0000;
				 
				 end 
				     /********I TYPE **********/
				OP_I: begin 			
						pcsel=0; 
						RF_we=1; 
						dm_we=0; 
						a_sel =0;
						b_sel =1;
						wb_sel=2'b01; 
						imm_sel = 3'b001; 
						alu_sel = {1'b0, ins[14:12]};
				 
				 end
						/*********R  TYPE ********/
				 OP: begin //ADD , SUB , OR 
						pcsel=0; 
						RF_we=1; 
						dm_we=0; 
						a_sel =0;
						b_sel =0;
						wb_sel=2'b01; 
						imm_sel = 3'b000; 
						alu_sel = {ins[30], ins[14:12]};
				 
				 end
				       /*******j TYPE *******/
				 JAL:  begin
						pcsel=1; 
						RF_we=1; 
						dm_we=0; 
						a_sel =1;
						b_sel =1;
						wb_sel=2'b10; 
						imm_sel = 3'b100; 
						alu_sel = 4'b0000;
						
				 end 
					/********i TYPE **********/
				 JALR:  begin
						pcsel=1; 
						RF_we=1; 
						dm_we=0; 
						a_sel =0;
						b_sel =1;
						wb_sel=2'b10; 
						imm_sel = 3'b001; 
						alu_sel = 4'b0000;
						
				 end 
				 /******* B TYPE *******/
				 BRANCH: begin
						pcsel= ins[12]?!beq  : beq ; 
						RF_we=1; 
						dm_we=0; 
						a_sel =1;
						b_sel =1;
						wb_sel=2'b00; 
						imm_sel = 3'b011; 
						alu_sel = 4'b0000;
						
				 end 
				  /**********ILLAGAL OP ****************/
				 default : begin
						pcsel=1'b0; 
						RF_we=1'b0; 
						dm_we=1'b0; 
						a_sel =1'bx;
						b_sel =1'bx;
						wb_sel=2'b00; 
						imm_sel = 3'bxxx; 
						alu_sel = 4'bxxxx;
						
				 end 
				 
				 
				 
				 
				   endcase 
				   end 
				   
				   
				   
endmodule 