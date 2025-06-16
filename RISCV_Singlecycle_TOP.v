`include "program_counter.v"
`include "pc_adder.v"
`include "pc_mux.v"
`include "Instruction_Memory.v"
`include "Register_File.v"
`include "main_control_unit.v"
`include "ALU_Control.v"
`include "ALU.v"
`include "immediate_generator.v"
`include "ALU_mux.v"
`include "Data_Memory.v"
`include "Data_Mem_mux.v"
`include "Branch_Adder.v"

module RISCV_Singlecycle_TOP(
		  input clk, rst
		); 
//....................................................................//
wire [31:0] pc_next,pc_out,pcplus4,decode_wire, Write_data_reg, read_data1, regtomux,pc_branch,imm_out,B,ALU_Result,read_data ;
wire RegWrite,ALUSrc, MemRead,MemWrite,MemToReg,Branch,Zero;
wire [1:0] ALUOp;
wire [3:0] ALUcontrol;
//wire [31:0] pc_out_wire, pc_next_wire, pcplus4_wire, decode_wire, read_data1, regtomux, WB_wire, branch_target, immgen_wire,muxtoAlu,read_data_wire,WB_data_wire;
//wire RegWrite,ALUSrc, MemRead,MemWrite,MemToReg,Branch,Zero;
//wire [1:0] ALUOp;
//wire [3:0] ALUcontrol_wire;
//....................................................................//

// Program Counter
program_counter PC(.clk(clk),.rst(rst),.pc_next(pc_next),.pc_out(pc_out));
// PC Adder
pc_adder PC_adder(.pc_out(pc_out),.pcplus4(pcplus4));
// PC Mux
pc_mux pc_mux(.pcplus4(pcplus4),.pc_branch(pc_branch),.pc_select(Branch&Zero),.pc_next(pc_next));
// Instruction Memory
Instruction_Memory Instr_Mem(.rst(rst),.clk(clk),.read_address(pc_out),.instruction(decode_wire));
// Register File
Register_File Reg_File(.rst(rst), .clk(clk), .RegWrite(RegWrite), .Rs1(decode_wire[19:15]), .Rs2(decode_wire[24:20]), .Rd(decode_wire[11:7]), .Write_data(Write_data_reg), .read_data1(read_data1), .read_data2(regtomux));
// Control Unit
main_control_unit Control_Unit(.opcode(decode_wire[6:0]),.RegWrite(RegWrite),.MemRead(MemRead),.MemWrite(MemWrite),.MemToReg(MemToReg),.ALUSrc(ALUSrc),.Branch(Branch),.ALUOp(ALUOp));
// ALU_Control
ALU_Control ALU_Control(.funct3(decode_wire[14:12]),.funct7(decode_wire[31:25]),.ALUOp(ALUOp),.ALUcontrol(ALUcontrol));
// ALU
ALU ALU(.A(read_data1),.B(B),.ALUcontrol(ALUcontrol),.ALU_Result(ALU_Result),.Zero(Zero));
// Immediate Generator
immediate_generator Imm_Gen(.instruction(decode_wire),.imm_out(imm_out));
// ALU Mux
ALU_mux Imm_Mux(.Read_data2(regtomux),.imm_out(imm_out),.ALUSrc(ALUSrc),.B(B));
// Data Memory
Data_Memory Data_Mem(.clk(clk),.rst(rst),.MemRead(MemRead),.MemWrite(MemWrite),.address(ALU_Result),.write_data(regtomux),.read_data(read_data));
//WB Mux
Data_Mem_mux WB_Mux(.ALU_Result(ALU_Result),.read_data(read_data),.MemToReg(MemToReg),.Write_data_reg(Write_data_reg));
//Branch_Adder
Branch_Adder Branch_Adder(.pc_out(pc_out), .imm_out(imm_out), .pc_branch(pc_branch));

endmodule
