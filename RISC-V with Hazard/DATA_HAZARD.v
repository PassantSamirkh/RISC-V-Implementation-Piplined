////////////////
/// DATA HAZARD 
///////////////
 module DATA_HAZARD (
					output reg [1:0] MUXA_SEL, MUXB_SEL, 
					input [31:0]insx, insm, insw
 
 
 
 );
 always @(*)
		 begin 
		    if (insx[19:15]==5'b0 ) 
						 MUXA_SEL=2'b00; 
			else if (insx[19:15]== insm[11:7])
						 MUXA_SEL=2'b01;
						 
						 
			 else if (insx[19:15]== insw[11:7])
						 MUXA_SEL=2'b10; 
						 
						 
			else  MUXA_SEL=2'b00; 
			
			if (insx[24:20]==5'b0 ) 
						 MUXB_SEL=2'b00; 
			else if (insx[24:20]== insm[11:7])
						 MUXB_SEL=2'b01;
						 
						 
			 else if (insx[24:20]== insw[11:7])
						MUXB_SEL=2'b10; 
						 
						 
			else  MUXB_SEL=2'b00; 
						 
			
				
		 
		 
		 
		 
		 end 
		 
 
endmodule  