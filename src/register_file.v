//REGISTER FILE
module reg_file(clk,reset, read_addr_1,read_addr_2, write_addr,read_data_1,read_data_2,write_data,reg_write);
input clk,reg_write, reset;
input [4:0] read_addr_1,read_addr_2, write_addr;
input [31:0] write_data;
output reg [31:0] read_data_1,read_data_2;
reg [31:0] registers [31:0];
integer k;
always @(posedge clk or posedge reset)
begin
    if(reset) 
    begin
        for(k=0; k<32; k=k+1)
        begin
        registers[k]<= 32'b00;
        end
    end
    else if (reg_write&(write_addr != 5'b00000))
    begin
        registers[write_addr]<= write_data;
    end
end

//always @(*) begin
    // read port 1
//    if (read_addr_1 == 5'b00000)
//        read_data_1 = 32'b0;
 //   else if (reg_write && (write_addr == read_addr_1))
//        read_data_1 = write_data; // forward new value
//    else
//        read_data_1 = registers[read_addr_1];

    // read port 2
//    if (read_addr_2 == 5'b00000)
//        read_data_2 = 32'b0;
//    else if (reg_write && (write_addr == read_addr_2))
//        read_data_2 = write_data; // forward new value
//    else
//        read_data_2 = registers[read_addr_2];
//end
always @(*) begin
    read_data_1 = (read_addr_1 == 5'b00000) ? 32'b0 : registers[read_addr_1];
    read_data_2 = (read_addr_2 == 5'b00000) ? 32'b0 : registers[read_addr_2];
end
endmodule











































