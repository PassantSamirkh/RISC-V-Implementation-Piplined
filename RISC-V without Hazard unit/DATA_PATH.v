 //////////////////
 ///// DATA PATH 
 /////////////////////
 
 
 
 `timescale 1ps/1ps 
 
  module DATA_PATH (
			output beq , 
			
			output [31:0] pc, MEM_wDATA, insx_op, 
			output [7:0]MEM_addr, 
			
			input clk , rest, pc_sel , a_sel , b_sel , RF_we,
			
			input [1:0]wb_sel , 
			
			input [2:0]imm_sel, 
			
			input [3:0]alu_sel , 
			
			input [31:0] ins , MEM_rData 
 
  ); 
		  /***********PC *********/
		  wire [31:0] PC_NXT, PC_PLS4, PCi; 
		  
		  /*********INPUT DATA **********/
		  wire [31:0] rs1, rs2, wDATAs1, wDATAs2; 
		  
			/*******I TYPE *********/
			
		 wire [31:0]imm;
		 wire [31:0] ALU_rs1, ALU_rs2 , ALU_rd;
		 
			/*****************NEW REGS ***********************/
		 wire [31:0]  RS1X, RS2X, INSX, INSD, RS2M, ALUM,INSM, INSW , DATA_W,PCD, PCX, PCM, PCM_PLS4; 
	 
	 
	 
		 
		 /***********PC CURRET STATE **************/
		 assign pc=PCi; 
		 
		 assign MEM_addr = ALUM [7:0]; 
		 
		 assign MEM_wDATA = RS2M; 
		 
		 /**********************************************/
		 assign insx_op  = INSX; 
		 
		 /***************PC NEXT STATE ******************/
		PCREG  PCREg ( .dout(PCi) , .rest(rest),.clk(clk), .din(PC_NXT) );
		
		adder PCP4 (.PC_pLUS4(PC_PLS4), .PC(PCi), .b(32'b100) );
		
		MUX   PCMUX  ( .M_out(PC_NXT) , .M_IN1(PC_PLS4), .M_in2( ALU_rd) , .sel(pc_sel)) ;///OOUTPUT OF NEW REG AFTER ADDING 4
		/******************PC REGS *******************************/
		REG  PCREgD ( .dout(PCD) , .rest(rest),.clk(clk), .din(PCi) );
		REG  PCREgX ( .dout(PCX) , .rest(rest),.clk(clk), .din(PCD) );
		REG  PCREgM ( .dout(PCM) , .rest(rest),.clk(clk), .din(PCX) );
		adder PCMREG_P4M (.PC_pLUS4(PCM_PLS4), .PC(PCM), .b(32'b100) );
		
		/******************2 REGS WB TO REG FILE  *********************/
		REG  instM ( .dout(INSM) , .rest(rest),.clk(clk), .din(INSX) );   
		REG  instW ( .dout(INSW) , .rest(rest),.clk(clk), .din(INSM) ); //INSW IS THE INPUT IS ADDRESS TO THE REG FILE >>WRITE ADDRESS 
		
		
		/***************** INPUT IS INST [THE OUTPUT OF IM ] OUTPUT IS THE 2 RERAD ADDRESS TO THE RF ********************/
		REG  instD ( .dout(INSD) , .rest(rest),.clk(clk), .din(ins) );
		/************REGISTER FILE *******************/
		
		RF  rf(.r_data1(rs1), .r_data2(rs2), .clk(clk), .we(RF_we),  .r_add1(INSD[19:15]), .r_add2(INSD[24:20]), .w_add(INSW[11:7]), .w_data(DATA_W)  );
		
		/**************************O/P REGS OF RF ***********************/
		REG  rs1X ( .dout(RS1X) , .rest(rest),.clk(clk), .din(rs1) );
		REG  rs2X ( .dout(RS2X) , .rest(rest),.clk(clk), .din(rs2) );
		
		/*************BRANCHING ****************/

		 BR_COMP  bc( .beq(beq) , .rs1(RS1X) , .rs2(RS2X) ); //DONE 
		 
		 /*************** INST X REG *********************************/ 
		 
		 REG  instX ( .dout(INSX) , .rest(rest),.clk(clk), .din(INSD) ); // THE INPUT OF IT IS INSD THAT COME FROM IM REG THAT IT'S INPUT IS INS 
		
		 imm_gen img( .imm(imm), .ins(INSX), .imm_sel(imm_sel));
		 
		 
		 /***********ALU ************/
		 
		 MUX   AMUX( .M_out(ALU_rs1) , .M_IN1(RS1X), .M_in2( PCX) , .sel(a_sel)) ; //ALU MUX A DONE 
		 
		 MUX  BMUX ( .M_out(ALU_rs2) , .M_IN1(RS2X), .M_in2( imm) , .sel(b_sel)) ;     //ALU MUXB DN 
		 
		 ALU  alu ( .rd(ALU_rd), .rs1(ALU_rs1), .rs2(ALU_rs2), .alu_sel(alu_sel));
		 /****************** ALUREG OUTPUT  REG TO DM AND MUX  *********************/
		REG  aluM  ( .dout(ALUM) , .rest(rest),.clk(clk), .din(ALU_rd) ); /// THE OUTPUT OF THIS REG IS GOING TO DM 
		 
		 
		/************ WRITE BACK *************/
		
		 MUX   wbmux1( .M_out(wDATAs1) , .M_IN1(MEM_rData), .M_in2( ALUM) , .sel(wb_sel[0])) ; //00>>>mem_data 01>>>alu  >>10 >> pc+4
		 
		 MUX   wbmux2( .M_out(wDATAs2) , .M_IN1(wDATAs1), .M_in2( PCM_PLS4) , .sel(wb_sel[1])) ;
		 
		 
		 
		 /**********WB REG  FROM ALU RS2 TO DM **************/
		 REG  rs2M ( .dout(RS2M) , .rest(rest),.clk(clk), .din(RS2X) );   //THIS REG  i/p from 2nd inp of alu , o/p >> DATA MEM 
		 
		 
		 
		 /**************WB REG FROM MUX 3*1 TO RG FILE *****************/
		  REG  wbDW( .dout(DATA_W) , .rest(rest),.clk(clk), .din(wDATAs2) ); 
		 


		 
		 
		 
		
		 
		 
	 
  
  endmodule 