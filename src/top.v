// ALL MODULES ARE
// INSTANTIATING IN 
// MODULE
module top(clk,reset);
input clk,reset;

wire [31:0] pc_address, instr_addr, pc_added_1, instr_from_mem, rd_data1, rd_data2, wrt_reg_file_data, jump_addr, sign_xtended, ALU_in_B, ALU_out, shifted_branch, Branch_Adder_Out, Branched_Mux_out, Memory_Data;
wire RegDst, RegWrite, ALU_SRC, MemtoReg, Reg_Wrt, Memory_read, Memory_Write, Branch, jmp, alu_zero, Branched_top, HLT;
wire [1:0] ALUOperation;
wire [3:0] ALU_funct;
wire [4:0] wrt_reg_addr;

// PROGRAM COUNTER
pc program_counter(.clk(clk), .reset(reset), .pc_out(instr_addr), .pc_in(pc_address));
// AADER PC+4
pcplus4 pc_adder(.frompc(instr_addr), .nexttopc(pc_added_1),.halted(HLT));
//INSTRUCTION MEMORY
intstruction_memory code_memory(.clk(clk), .reset(reset), .read_address(instr_addr), .instruction(instr_from_mem));
//REGISTER FILE
reg_file register_file(.clk(clk), .reset(reset), .read_addr_1(instr_from_mem[25:21]) ,.read_addr_2(instr_from_mem[20:16]), .write_addr(wrt_reg_addr),.read_data_1(rd_data1),.read_data_2(rd_data2),.write_data(wrt_reg_file_data),.reg_write(RegWrite));
//MUX AT INPUT OF REGISTER FILE
in_mux_reg dest_reg_mux(.reg2(instr_from_mem[20:16]), .wrt_reg(instr_from_mem[15:11]), .to_wrt_reg(wrt_reg_addr), .regDst(RegDst));
//SHIFT LEFT 2 JUMP
//shift_left_jump jmp_calcltn(.in_sequence(instr_from_mem[25:0]), .shifted_out(jump_addr), .pcplus4_for_jump(pc_added_4));
jump_addr_gen jmp_addr_cal(.in_sequence(instr_from_mem[25:0]), .jump_addr(jump_addr), .pcplus1_for_jump(pc_added_1));
//CONTROL UNIT
contorl control_unit_top(.opcode(instr_from_mem[31:26]), .regDst(RegDst), .ALUSrc(ALU_SRC), .Memtoreg(MemtoReg), .reg_wrt(RegWrite), .mem_read(Memory_read), .mem_write(Memory_Write), .branch(Branch), .jump(jmp), .ALUop(ALUOperation), .halt(HLT));
//SIGN EXTENTENTION UNIT
sign_xtend sign_extention(.imm_data(instr_from_mem[15:0]), .xtended(sign_xtended));
// MUX BETWEEN REG FILE AND ALU
mux_reg_alu ALU_Src_mux(.data2(rd_data2), .xtended(sign_xtended), .to_alu(ALU_in_B), .alusrc(ALU_SRC));
// ALU CONTROL
alu_control ALU_control_unit(.alu_op(ALUOperation), .funct(instr_from_mem[5:0]), .alu_function(ALU_funct));
//ALU
alu ALU_Unit(.A(rd_data1),.B(ALU_in_B), .alu_function(ALU_funct), .zero(alu_zero), .alu_result(ALU_out));
//SHIFT LEFT 2 BRANCH
//shift_left_branch shifter_branch(.in_sequence(sign_xtended), .shifted_out(shifted_branch));
//ADDER IN BRANCH DATAPATH
add_in_branch adder_branch(.shifted_sign(sign_xtended),.pcplus1_for_branch(pc_added_1), .to_mux(Branch_Adder_Out));
// MUX FOR BRANCH OR PC+4 (MUX1)
mux1 Mux_Branch_PC(.branched_addr(Branch_Adder_Out), .pc_1(pc_added_1), .branched(Branched_top), .to_mux2(Branched_Mux_out));
//MUX FOR JUMP OR PC+4/BRANCH (MUX2)
mux2 Jump_Mux(.jump_addr(jump_addr), .frm_mux1(Branched_Mux_out), .jmp(jmp), .to_pc(pc_address));
// AND GATE
and1 AND_Gate(.brnch(Branch), .zero_alu(alu_zero), .to_mux1(Branched_top));
//DATA MEMORY
datamem Data_Memory(.clk(clk), .reset(reset), .mem_rd(Memory_read), .mem_wrt(Memory_Write), .address(ALU_out), .read_data(Memory_Data), .write_data(rd_data2));
// MUX AT DATA MEMORY
mux_data_mem Data_Mem_Mux(.rd_data(Memory_Data), .alu_out(ALU_out), .to_reg_file(wrt_reg_file_data), .mem2reg(MemtoReg));
endmodule
