`timescale 1ns/1ps

module tb_top();
    reg clk;
    reg reset;
    integer i, j;

    top cpu_inst(.clk(clk), .reset(reset));

    initial clk = 0;
    always #5 clk = ~clk; // 10ns period

    initial begin
        reset = 1;
        #10;
        reset = 0;
    end

    initial begin
        #12; // Wait for reset to complete
        cpu_inst.code_memory.instr_mem[0] = 32'h20030000; // MOVI R3, 0
        cpu_inst.code_memory.instr_mem[1] = 32'h2001000f; // MOVI R1, 16
        cpu_inst.code_memory.instr_mem[2] = 32'h20020005; // MOVI R2, 5 (for 5 iterations)
        cpu_inst.code_memory.instr_mem[3] = 32'h20210001; // ADDI R1, R1, 1 (INC)
        cpu_inst.code_memory.instr_mem[4] = 32'h8C240000; // LW R4, 0(R1)
        cpu_inst.code_memory.instr_mem[5] = 32'h00641820; // ADD R3, R3, R4
        cpu_inst.code_memory.instr_mem[6] = 32'h24420001; // SUBI R2, R2, 1 (DEC)
        cpu_inst.code_memory.instr_mem[7] = 32'h10400001; // BEQ R2, R0, +2 (to HALT)
        cpu_inst.code_memory.instr_mem[8] = 32'h08000003; // J 0x000002 (to PC=0x00000008)
        cpu_inst.code_memory.instr_mem[9] = 32'hFC000000; // HALT
    end

    initial begin
        #12; // Wait for reset
        for(i=16; i<=20; i=i+1) begin
            cpu_inst.Data_Memory.data_memory[i] = i/2; // data_memory[16]=16, [17]=17, ..., [20]=20
        end
    end

    initial begin
        $display("Time\tPC\tInstruction\tR0\tR1\tR2\tR3\tR4\tMem[16..32]");
        for(i=0; i<100; i=i+1) begin
            @(posedge clk);
            $write("%0t\t%0h\t%h\t", $time, cpu_inst.instr_addr, cpu_inst.instr_from_mem);
            $write("%0d\t%0d\t%0d\t%0d\t%0d\t", 
                cpu_inst.register_file.registers[0],
                cpu_inst.register_file.registers[1],
                cpu_inst.register_file.registers[2],
                cpu_inst.register_file.registers[3],
                cpu_inst.register_file.registers[4]
            );
            for(j=16; j<=32; j=j+1) begin
                $write("%0d ", cpu_inst.Data_Memory.data_memory[j]);
            end
            $display("");
        end
    end

    initial begin
        #1000;
        $display("Final R3=%0d (sum of Mem[16..32])", cpu_inst.register_file.registers[3]);
        $stop;
    end
endmodule
