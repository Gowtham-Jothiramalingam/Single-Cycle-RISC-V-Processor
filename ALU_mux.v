module ALU_mux (
    input [31:0] Read_data2,   
    input [31:0] imm_out,   
    input ALUSrc,          
    output [31:0] B      
);

    assign B = (ALUSrc) ? imm_out : Read_data2;  

endmodule
