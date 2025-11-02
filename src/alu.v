// ALU
module alu(
    input [31:0] A, B,
    input [3:0] alu_function,
    output reg [31:0] alu_result,
    output reg zero
);

    parameter ANDed   = 4'b0000;
    parameter ORed    = 4'b0001;
    parameter add     = 4'b0010;
    parameter XORed   = 4'b0011;
    parameter XNORed  = 4'b0100;
    parameter SHL     = 4'b0101;   // shift left by 1
    parameter subtract= 4'b0110;
    parameter slt     = 4'b0111;
    parameter SHR     = 4'b1000;   // shift right by 1
    parameter CPL     = 4'b1001;   // complement

    always @(*) begin
        case (alu_function)
            add:      alu_result = A + B;
            subtract: alu_result = A - B;
            ANDed:    alu_result = A & B;
            ORed:     alu_result = A | B;
            XORed:    alu_result = A ^ B;
            XNORed:   alu_result = ~(A ^ B);
            SHL:      alu_result = A << 1;
            SHR:      alu_result = A >> 1;
            slt:      alu_result = (A < B) ? 32'b1 : 32'b0;
            CPL:      alu_result = ~A;
            default:  alu_result = 32'b0;
        endcase
        zero = (alu_result == 32'b0);
    end
endmodule



//====================
// ALU STRCTURAL BUT CANT IMPLEMENT ALL THE FUNCTIONS THAT ARE DONE BY BEHAVIOURAL ALU
// UNCOMMENT IF YOU WANT TO USE STRCTURAL ALU
//====================
/*
// 1-bit full adder
module full_adder(input a, b, cin, output sum, cout);
    wire axb, axb_cin, ab;
    xor g1(axb, a, b);
    xor g2(sum, axb, cin);
    and g3(axb_cin, axb, cin);
    and g4(ab, a, b);
    or  g5(cout, axb_cin, ab);
endmodule

// 32-bit adder
module adder32(input [31:0] a, b, output [31:0] sum);
    wire [31:0] carry;
    full_adder fa0(a[0], b[0], 1'b0, sum[0], carry[0]);
    genvar i;
    generate
        for(i=1; i<32; i=i+1) begin : adder_bits
            full_adder fa(a[i], b[i], carry[i-1], sum[i], carry[i]);
        end
    endgenerate
endmodule

// 32-bit subtractor
module subtract32(input [31:0] a, b, output [31:0] diff);
    wire [31:0] not_b;
    wire [31:0] carry;
    genvar i;
    generate
        for(i=0; i<32; i=i+1) begin : invert_bits
            not g1(not_b[i], b[i]);
        end
    endgenerate
    full_adder fa0(a[0], not_b[0], 1'b1, diff[0], carry[0]);
    generate
        for(i=1; i<32; i=i+1) begin : sub_bits
            full_adder fa(a[i], not_b[i], carry[i-1], diff[i], carry[i]);
        end
    endgenerate
endmodule

// 32-bit AND
module and32(input [31:0] a, b, output [31:0] y);
    genvar i;
    generate
        for(i=0;i<32;i=i+1) begin : and_bits
            and g(y[i], a[i], b[i]);
        end
    endgenerate
endmodule

// 32-bit OR
module or32(input [31:0] a, b, output [31:0] y);
    genvar i;
    generate
        for(i=0;i<32;i=i+1) begin : or_bits
            or g(y[i], a[i], b[i]);
        end
    endgenerate
endmodule

// 32-bit XOR
module xor32(input [31:0] a, b, output [31:0] y);
    genvar i;
    generate
        for(i=0;i<32;i=i+1) begin : xor_bits
            xor g(y[i], a[i], b[i]);
        end
    endgenerate
endmodule

// 32-bit XNOR
module xnor32(input [31:0] a, b, output [31:0] y);
    genvar i;
    generate
        for(i=0;i<32;i=i+1) begin : xnor_bits
            xnor g(y[i], a[i], b[i]);
        end
    endgenerate
endmodule

// SLT (set less than)
module slt32(input [31:0] a, b, output [31:0] y);
    wire [31:0] diff;
    subtract32 sub(a, b, diff);
    assign y = {31'b0, diff[31]};
endmodule

// shift left 1
module shl1_32(input [31:0] b, output [31:0] y);
    assign y = {b[30:0], 1'b0};
endmodule

// shift right 1
module shr1_32(input [31:0] b, output [31:0] y);
    assign y = {1'b0, b[31:1]};
endmodule

// 1-bit 2:1 mux
module mux2to1_1(input d0, d1, sel, output y);
    wire nsel, w0, w1;
    not g0(nsel, sel);
    and g1(w0, d0, nsel);
    and g2(w1, d1, sel);
    or g3(y, w0, w1);
endmodule

// 32-bit 2:1 mux using generate
module mux2to1_32_gen(input [31:0] d0, d1, input sel, output [31:0] y);
    genvar i;
    generate
        for(i=0; i<32; i=i+1) begin : mux_bits
            assign y[i] = sel ? d1[i] : d0[i];
        end
    endgenerate
endmodule

// 32-bit 4:1 mux
module mux4to1_32(input [31:0] d0,d1,d2,d3, input [1:0] sel, output [31:0] y);
    wire [31:0] w0, w1;
    mux2to1_32_gen m0(d0,d1,sel[0],w0);
    mux2to1_32_gen m1(d2,d3,sel[0],w1);
    mux2to1_32_gen m2(w0,w1,sel[1],y);
endmodule

// 32-bit 16:1 mux
module mux16to1_32(
    input [31:0] d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,
    input [3:0] sel,
    output [31:0] y
);
    wire [31:0] w0,w1,w2,w3;
    mux4to1_32 m0(d0,d1,d2,d3,sel[1:0],w0);
    mux4to1_32 m1(d4,d5,d6,d7,sel[1:0],w1);
    mux4to1_32 m2(d8,d9,d10,d11,sel[1:0],w2);
    mux4to1_32 m3(d12,d13,d14,d15,sel[1:0],w3);
    mux4to1_32 m4(w0,w1,w2,w3,sel[3:2],y);
endmodule

// top-level structural ALU
module alu(
    input [31:0] A,B,
    input [3:0] alu_function,
    output [31:0] alu_result,
    output zero
);
    wire [31:0] and_out,or_out,add_out,sub_out,xor_out,xnor_out,shl_out,shr_out,slt_out;

    // ALU operations
    and32 u_and(A,B,and_out);
    or32 u_or(A,B,or_out);
    adder32 u_add(A,B,add_out);
    subtract32 u_sub(A,B,sub_out);
    xor32 u_xor(A,B,xor_out);
    xnor32 u_xnor(A,B,xnor_out);
    slt32 u_slt(A,B,slt_out);
    shl1_32 u_shl(B,shl_out);
    shr1_32 u_shr(B,shr_out);

    // final result selection using 16:1 mux
    mux16to1_32 u_result_mux(
        .d0(and_out), .d1(or_out), .d2(add_out), .d3(sub_out),
        .d4(xor_out), .d5(xnor_out), .d6(shl_out), .d7(shr_out),
        .d8(slt_out), .d9(32'b0), .d10(32'b0), .d11(32'b0),
        .d12(32'b0), .d13(32'b0), .d14(32'b0), .d15(32'b0),
        .sel(alu_function),
        .y(alu_result)
    );

    assign zero = (alu_result == 32'b0);
endmodule
*/
//==================
// ALU STRUCTURAL END 
//==================
