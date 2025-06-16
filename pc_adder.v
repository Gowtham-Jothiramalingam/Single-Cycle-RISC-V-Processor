module pc_adder(
    input [31:0] pc_out,       
    output reg [31:0] pcplus4 
);

    always @(*) begin
        pcplus4 = pc_out + 4;  
    end

endmodule
