//DATA MEMORY
module datamem(clk, reset, mem_rd, mem_wrt, address, read_data, write_data);
input mem_rd, mem_wrt,clk, reset;
input [31:0] address,write_data;
output reg [31:0] read_data;
reg [31:0] data_memory [1023:0];
integer k;
always @(posedge clk or posedge reset)
begin
   if(reset) 
    begin
        for(k=0; k<1024; k=k+1)
        begin
        data_memory[k]<= 32'b00;
        end
    end
    else if(mem_wrt)
    begin
        data_memory[address] <= write_data;
    end
end
always @(*)
begin
    if(mem_rd)
    begin
        read_data<= data_memory[address];
    end
end
endmodule
