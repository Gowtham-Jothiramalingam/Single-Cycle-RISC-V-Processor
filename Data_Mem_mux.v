module Data_Mem_mux (
    input [31:0] ALU_Result,  
    input [31:0] read_data,  
    input MemToReg,         
    output [31:0] Write_data_reg     
);

    assign Write_data_reg = (MemToReg) ? read_data : ALU_Result; 

endmodule
