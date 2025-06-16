module Branch_Adder(
    input [31:0] pc_out,                    
    input [31:0] imm_out,                 
    output reg [31:0] pc_branch     
);

    always @(*) begin
       pc_branch <= pc_out + (imm_out);  
    end

endmodule
