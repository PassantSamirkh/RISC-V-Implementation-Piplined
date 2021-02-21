///////////
///TB_RISC_TOP
///////////////////////
  `timescale 1ps/1ps 

module TB_RISC_TOP;

	
	reg clk; 
	reg rset;
	 
	wire  [31:0] ins;   
	wire  [31:0] MEM_rData;
   wire  [31:0] pc; 
   wire  [7:0] MEM_addr;
	wire  [31:0] MEM_wDATA;
	wire  dm_we; 
	// Instantiate the Unit Under Test (UUT)
		RISCV_TOP uut (
						.dm_we(dm_we), 
						.pc(pc), 
						.MEM_addr(MEM_addr), 
						.MEM_wDATA(MEM_wDATA), 
						.clk(clk), 
						.rset(rset), 
						.ins(ins), 
						.MEM_rData(MEM_rData)
					);
					
		/************ DATA MEMORY INSTANTIATION ******************/			
		DATA_MEM DM(.mem_rd(MEM_rData), 
					.clk(clk) , 
					.dm_we(dm_we), 
					.mem_addr(MEM_addr),
					.mem_wd(MEM_wDATA));
					
					
			/*************INTERACTION MEMORY *********************/		
			INS_MEM IM(.ins(ins) ,  .addr (pc[9:2]) );

	initial begin
		// Initialize Inputs
		 
		
		
		#2000 rset = 1;
	
		#200 rset=0; 
		#100 rset=1; 
		#2000 rset=0; 

	end
     
	initial begin
		// Initialize Inputs
		clk=0; end 
		always begin #2000 clk=~clk ;  end 
endmodule

