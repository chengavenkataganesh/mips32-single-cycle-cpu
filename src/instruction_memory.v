//INSTRUCTION MEMORY
module intstruction_memory(clk, reset, read_address, instruction);
input clk, reset;
input [31:0] read_address;
output reg [31:0] instruction;
reg [31:0] instr_mem [1023:0];
integer k;
always @(posedge clk or posedge reset)
begin
    if(reset) 
    begin
        for(k=0; k<1024; k=k+1)
        begin
        instr_mem[k]<= 32'b0;
        end
    end
    //instruction<= instr_mem[read_address];
end
always @(*)
begin
instruction = instr_mem[read_address];
end
endmodule
