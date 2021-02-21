/////////////
/// ALU 
///////////////
`timescale 1ps/1ps 
module ALU (
			
			output reg [31:0] rd, 
			input [31:0] rs1, 
			input [31:0] rs2, 
			input [3:0] alu_sel
);
			////Parameters
			parameter SUM = 3'b000;
			parameter OR  = 3'b110;
			parameter AND = 3'b111;
			////wires
			wire [31:0] sum;
			wire [31:0] add_sub;

		assign #50 add_sub = alu_sel[3] ? ~rs2 : rs2;   /// last bit ? if 1  sub rs1-rs2, if 0 rs1+rs2 
		assign #50 sum = rs1 + add_sub + alu_sel[3];


		always@ (*)
				begin  #50
			case (alu_sel[2:0])
			SUM:     begin 	    rd = sum ;       	end
			OR:      begin 	    rd = rs1 | rs2 ; 	end 
			AND:     begin 	    rd = rs1 & rs2 ;    end
			default: begin      rd = 32'bx; 	    end
			endcase 
			end 
endmodule