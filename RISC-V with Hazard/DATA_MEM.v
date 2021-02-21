/////////
//DATA MEM
////////////
`timescale 1ps/1ps 

module DATA_MEM (
				output [31:0] mem_rd, 
				input clk , dm_we, 
				input [7:0] mem_addr, 
				input [31:0] mem_wd
);

	 reg [31:0] RAM [0:255];
/*************  READ OP *****************/
	 assign #100 mem_rd = RAM[mem_addr] ;
/***********  WRITE ********************/
	 always @ (posedge clk)
				begin
				if (dm_we) 
					RAM[mem_addr] <= #100 mem_wd;
					
					//else RAM[mem_addr] <= RAM[mem_addr]; 
				end

endmodule