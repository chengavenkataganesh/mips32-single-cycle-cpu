// ALU CONTROL
module alu_control(alu_op, funct, alu_function);
input [1:0] alu_op;
input [5:0] funct;
output reg [3:0] alu_function;

parameter R_TYPE  = 2'b10;
parameter LW = 2'b00;
parameter SW = 2'b00;
parameter BEQ = 2'b01;
parameter ADDI = 2'b00;
parameter SUBI = 2'b00;


parameter add = 6'b100000;
parameter subtract = 6'b100010;
parameter ANDed = 6'b100100;
parameter ORed = 6'b100101;
parameter XORed = 6'b100011;
parameter XNORed = 6'b100110;
parameter slt = 6'b101010;
parameter SHL_f = 6'b000111;
parameter SHR_f = 6'b000110;
parameter CPL_f = 6'b101100;


always @(*) begin
    case(alu_op)
        LW, ADDI, SW : alu_function = 4'b0010;   // add
        BEQ, SUBI     : alu_function = 4'b0110;  // subtract
       
        R_TYPE: case(funct)
            add      : alu_function = 4'b0010;
            subtract : alu_function = 4'b0110;
            ANDed    : alu_function = 4'b0000;
            ORed     : alu_function = 4'b0001;
            XORed    : alu_function = 4'b0011;
            XNORed   : alu_function = 4'b0100;
            slt      : alu_function = 4'b0111;
            SHL_f    : alu_function = 4'b0101;
            SHR_f    : alu_function = 4'b1000;
            CPL_f    : alu_function = 4'b1001;
            default  : alu_function = 4'b1111;
        endcase
        default: alu_function = 4'b1111;
    endcase
end
endmodule
