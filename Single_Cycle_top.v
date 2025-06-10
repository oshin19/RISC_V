`include  "pc.v"
`include "instruction_mem.v"
`include "register_file.v"
`include "ALU.v"
`include "control_unit.v"
`include "data_memory.v"
`include "branch_unit.v"
`include "mux.v"

module single_cycle_top
( input clk, rst
);

wire [31:0] pc_top, rd_instr;
wire [31:0] rd1_top, rd2_top, src_b;
wire [31:0] alu_result, read_data;
wire [31:0] imm_ext_top, pc_next_top, result_to_write;
wire [2:0]  alu_control_top;
wire [1:0]  immSrc_top;
wire        regwrite_top, aluSrc_top, memwrite_top, resultSrc_top, branch_top, branch_taken_top;



// PC SELECTION //

mux2 pc_next_result (
    .a(pc_top + imm_ext_top),
    .b(pc_top + 32'd4),
    .sel(branch_taken_top),
    .out(pc_next_top)
);

pc pc_instance ( 
    .clk(clk),
    .rst(rst), 
    .pc(pc_top),
    .pcnext(pc_next_top)
);
 
 
 // INSTRUCTION FETCHING //
 
instruction_mem imem_instance(
    .address(pc_top),
    .read(rd_instr) 
);
 
// REGISTER FILE ACCESS//
 
register_file rfile_instance(
    .clk(clk),
    .a1(rd_instr[19:15]),
    .a2(rd_instr[24:20]),
    .a3(rd_instr[11:7]),
    .wd3(result_to_write),
    .we3(regwrite_top),
    .rd1(rd1_top),
    .rd2(rd2_top)
);
 
// IMMEDIATE GENERATION //
  
imm_gen imm_gen_instance (
    .inst(rd_instr),
    .immSrc(immSrc_top),
    .imm_ext(imm_ext_top)
);
  
// ALU //
  
mux2 operand_b (
    .a(imm_ext_top),
    .b(rd2_top),
    .sel(aluSrc_top),
    .out(src_b)
);

ALU alu(
    .a(rd1_top),
    .b(src_b),
    .alu_control(alu_control_top),
    .result(alu_result),
    .zero(),
    .negative(),
    .carry(),
    .overflow(),
    .slt()
);

// CONTROL SIGNALS //
 
control_unit control_unit_instance(
    .op(rd_instr[6:0]),
    .funct7(rd_instr[31:25]),
    .funct3(rd_instr[14:12]),
    .regwrite(regwrite_top),
    .aluSrc(aluSrc_top),
    .memwrite(memwrite_top),
    .resultSrc(resultSrc_top),
    .branch(branch_top),
    .immSrc(immSrc_top),
    .alu_control(alu_control_top)
); 

// DATA MEMORY // 

data_memory data_memory_instance(
    .clk(clk),
    .we(memwrite_top),
    .a(alu_result),
    .wd(rd2_top),
    .rd(read_data)
); 

// WRITE BACK MUX //

mux2 result_mux (
    .a(read_data),
    .b(alu_result),
    .sel(resultSrc_top),
    .out(result_to_write)
);

///BRANCH DECISION //

branch_unit branch_unit_instance (
    .branch(branch_top),
    .funct3(rd_instr[14:12]),
    .rd1(rd1_top),
    .rd2(rd2_top),
    .branch_taken(branch_taken_top)
);

endmodule
