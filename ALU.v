module ALU(
    input [31:0] A,             
    input [31:0] B,            
    input [3:0] ALUcontrol,          
    output reg [31:0] ALU_Result,   
    output reg Zero             
);

    always @(A or B or ALUcontrol) begin
        case (ALUcontrol)
            4'b0000: ALU_Result = A + B;           		// ADD
            4'b0001: ALU_Result = A - B;           		// SUB
            4'b0010: ALU_Result = A & B;           		// AND
            4'b0011: ALU_Result = A | B;           		// OR
            4'b0100: ALU_Result = A ^ B;           		// XOR
            4'b0101: ALU_Result = A << B[4:0];     		// SLL (Shift Left Logical)
            4'b0110: ALU_Result = A >> B[4:0];     		// SRL (Shift Right Logical)
            4'b0111: ALU_Result = $signed(A) >>> B[4:0];    // SRA (Shift Right Arithmetic)
            4'b1000: ALU_Result =($signed(A) < $signed(B)) ? 32'b1 : 32'b0;
            default: ALU_Result = 32'b0;          		
        endcase

        
        Zero = (ALU_Result == 32'b0) ? 1 : 0;
    end

endmodule

