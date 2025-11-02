//SHIFT LEFT 2 JUMP(previously but modified by c.v.ganesh)
//JUMP ADDRESS GENERATOR/CALCULATOR
module jump_addr_gen(in_sequence, jump_addr, pcplus1_for_jump);
input [25:0] in_sequence;
input [31:0] pcplus1_for_jump;
output [31:0] jump_addr;
//assign shifted_out = {pcplus4_for_jump[31:28], in_sequence, 2'b00}; 
assign jump_addr = {pcplus1_for_jump[31:26],in_sequence};
endmodule



//ADDER IN BRANCH DATAPATH
module add_in_branch(shifted_sign,pcplus1_for_branch, to_mux);
input [31:0] shifted_sign, pcplus1_for_branch;
output [31:0] to_mux;
assign to_mux = shifted_sign + pcplus1_for_branch;
endmodule
