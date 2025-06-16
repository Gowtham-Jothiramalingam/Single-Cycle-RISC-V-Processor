module pc_mux(
    input [31:0] pcplus4,       
    input [31:0] pc_branch,   
    input pc_select,          
    output reg[31:0] pc_next  
);
   always @(*) begin
        if (pc_select==1'b0) begin
            pc_next = pcplus4;  
        end else begin
            pc_next = pc_branch;      
        end
    end

endmodule
