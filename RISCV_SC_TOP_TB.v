
module RISCV_SC_TOP_TB;

    reg clk, rst;
    
    RISCV_Singlecycle_TOP UUT (
        .clk(clk), 
        .rst(rst)
    );

    // Clock generation
    initial begin
        clk = 0;
    end

    always #50 clk = ~clk; 

    // Reset generation
    initial begin
        //rst = 1'b1;
        //#50;
        rst = 1'b0; 
        //#5200; 
        //$finish; 
    end

    
    initial begin
        $dumpfile("waveform.vcd");  
        $dumpvars(0, UUT);          
    end

endmodule
