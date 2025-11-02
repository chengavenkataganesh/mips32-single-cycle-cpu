// AADER PC+1
module pcplus1(frompc, nexttopc,halted);
input halted;
input [31:0] frompc;
output reg [31:0] nexttopc;
always @(*)
begin
    if (halted==1'b1)
    begin
    nexttopc = frompc;
    end
    else
    begin
            nexttopc = frompc + 1;   // normal PC increment
    end
end
endmodule
