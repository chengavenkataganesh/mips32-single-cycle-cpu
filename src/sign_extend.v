//SIGN EXTENSION
module sign_xtend(imm_data, xtended);
input [15:0] imm_data;
output [31:0] xtended;
assign xtended = {{16{imm_data[15]}},imm_data};
endmodule
