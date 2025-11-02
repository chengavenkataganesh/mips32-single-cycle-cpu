//MUX AT INPUT OF REGISTER FILE
module in_mux_reg(reg2, wrt_reg, to_wrt_reg, regDst);
input regDst;
input [4:0] reg2, wrt_reg;
output [4:0] to_wrt_reg;
assign to_wrt_reg = regDst ? wrt_reg : reg2;
endmodule

// MUX BETWEEN REG FILE AND ALU
module mux_reg_alu( data2, xtended,to_alu, alusrc);
input [31:0] data2, xtended;
input alusrc;
output [31:0] to_alu;
assign to_alu = alusrc ? xtended : data2;
endmodule

// MUX AT DATA MEMORY
module mux_data_mem(rd_data, alu_out, to_reg_file, mem2reg);
input [31:0] rd_data, alu_out;
input mem2reg;
output [31:0] to_reg_file;
assign to_reg_file = mem2reg ? rd_data : alu_out;
endmodule

// MUX FOR BRANCH OR PC+4 (MUX1)
module mux1(branched_addr, pc_1, branched, to_mux2);
input [31:0] branched_addr, pc_1;
input branched;
output [31:0] to_mux2;
assign to_mux2 = branched ? branched_addr : pc_1;
endmodule

//MUX FOR JUMP OR PC+4/BRANCH (MUX2)
module mux2(jump_addr, frm_mux1, jmp, to_pc);
input [31:0] jump_addr, frm_mux1;
input jmp;
output [31:0] to_pc;
assign to_pc = jmp ? jump_addr : frm_mux1;
endmodule

// AND GATE
module and1(brnch, zero_alu, to_mux1);
input brnch, zero_alu;
output to_mux1;
assign to_mux1 = brnch & zero_alu;
endmodule
