//CONTROL UNIT
module contorl(opcode, regDst, ALUSrc, Memtoreg, reg_wrt, mem_read, mem_write, branch, jump, ALUop ,halt);
input [5:0] opcode;
output   reg regDst, ALUSrc, Memtoreg, reg_wrt, mem_read, mem_write, branch, jump, halt;
output reg [1:0] ALUop;      //
always @(*)
begin
    case (opcode)
    // R-TYPE
    6'b000000 : {regDst, ALUSrc, Memtoreg, reg_wrt, mem_read, mem_write, branch, jump, ALUop, halt} = 11'b10010000100;
    //LW
    6'b100011 : {regDst, ALUSrc, Memtoreg, reg_wrt, mem_read, mem_write, branch, jump, ALUop, halt} = 11'b01111000000;
    // SW
    6'b101011 : {regDst, ALUSrc, Memtoreg, reg_wrt, mem_read, mem_write, branch, jump, ALUop, halt} = 11'b01000100000;
    //BEQ
    6'b000100 : {regDst, ALUSrc, Memtoreg, reg_wrt, mem_read, mem_write, branch, jump, ALUop, halt} = 11'b00000010010;
    //JUMP
    6'b000010 : {regDst, ALUSrc, Memtoreg, reg_wrt, mem_read, mem_write, branch, jump, ALUop, halt} = 11'b00000001000;
    //ADD IMM(addi)
    6'b001000 : {regDst, ALUSrc, Memtoreg, reg_wrt, mem_read, mem_write, branch, jump, ALUop, halt} = 11'b01010000000;
    // SUB IMM (subi)
    6'b001001 : {regDst, ALUSrc, Memtoreg, reg_wrt, mem_read, mem_write, branch, jump, ALUop, halt} = 11'b01010000010;
    //HALT STOP PROGRAM
    6'b111111 : {regDst, ALUSrc, Memtoreg, reg_wrt, mem_read, mem_write, branch, jump, ALUop, halt} = 11'b00000000001;
    // ANDI
    //6'b001100 : {regDst, ALUSrc, Memtoreg, reg_wrt, mem_read, mem_write, branch, jump, ALUop, halt} = 11'b01010000011; 
    // ORI
    //6'b001101 : {regDst, ALUSrc, Memtoreg, reg_wrt, mem_read, mem_write, branch, jump, ALUop, halt} = 11'b01010000110; 
    //DEFAULT
    default:   {regDst, ALUSrc, Memtoreg, reg_wrt, mem_read, mem_write, branch, jump, ALUop, halt} = 11'b00000000110;
    endcase
end
endmodule































