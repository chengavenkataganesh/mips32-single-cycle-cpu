# MIPS32 Single-Cycle CPU  
A modular and fully functional implementation of a **32-bit MIPS single-cycle processor**, developed and tested using **Xilinx Vivado**.  
This project includes all essential components of the MIPS architecture along with a GitHub Pages deployment showing a high-level datapath visualization.

---

## 🌐 Live Datapath Visualization (GitHub Pages)

🔗 **View the MIPS Datapath Diagram:**  
👉 https://chengavenkataganesh.github.io/mips32-single-cycle-cpu/

---

# 📌 Overview

This project implements a **single-cycle MIPS32 processor** based on the classic architecture model.  
Designed and simulated entirely using **Xilinx Vivado**, it supports:

✅ R-type operations  
✅ I-type instructions  
✅ Jumps & branches  
✅ Register file operations  
✅ ALU arithmetic & logical operations  
✅ Instruction & data memory  

The processor is built in a modular manner, enabling easy debugging and extension.

---

# 🧩 Architecture & Module List

The processor is composed of the following Verilog modules:

- `alu.v`
- `alucontrol.v`
- `control_unit.v`
- `program_counter.v`
- `register_file.v`
- `instruction_memory.v`
- `datamemory.v`
- `sign_extend.v`
- `branch_jump_address_units.v`
- `mux_and_logic_units.v`
- `pcplus1.v`
- `top.v` (integrated complete CPU datapath)

A high-level datapath diagram is available on the GitHub Pages deployment.

---
# 📁 Repository Structure
├── src/ # Vivado HDL source files
│ ├── alu.v
│ ├── alucontrol.v
│ ├── branch_jump_address_units.v
│ ├── control_unit.v
│ ├── datamemory.v
│ ├── instruction_memory.v
│ ├── mux_and_logic_units.v
│ ├── pcplus1.v
│ ├── program_counter.v
│ ├── register_file.v
│ ├── sign_extend.v
│ └── top.v
│
├── tb/ # Testbenches
│ ├── your_tb_files.v
│
├── index.html # GitHub Pages visualization
└── README.md # Documentation

# 🛠️ Running the CPU in Vivado
## ✅ 1. Create a Vivado Project
1. Open **Vivado**
2. Click **Create New Project**
3. Choose **RTL Project**
4. Add all files from the `src/` folder
5. (Optional) Add testbench files under **Simulation Sources**

## ✅ 2. Run Behavioral Simulation
1. Open **Flow Navigator → Simulation**
2. Click **Run Simulation → Run Behavioral Simulation**

Vivado will compile the design and display waveforms for:
- PC values  
- instructions  
- ALU output  
- register writes  
- branch decisions  
- memory accesses  
## ✅ 3. Run Synthesis
1. Go to **Flow Navigator → Synthesis**
2. Click **Run Synthesis**
Vivado will display:
- Timing summary  
- Utilization report (LUTs, FFs, BRAMs)  
- Netlist view  

## ✅ 4. (Optional) FPGA Implementation
To run on an FPGA board such as Basys3 or Nexys A7:
1. Add a constraints file (`.xdc`)
2. Assign pins for LEDs, switches, and clock
3. Run **Implementation**
4. Generate Bitstream
5. Program device

# ✅ Testbench Example (Vivado)
```verilog
module top_tb;
    reg clk;
    reg reset;
    top uut (.clk(clk), .reset(reset));
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clk
    end
    initial begin
        reset = 1;
        #20 reset = 0;
    end
endmodule

✅ Key Features
✔ MIPS32-compliant single-cycle CPU
✔ Clean and modular Verilog design
✔ Fully synthesizable in Vivado
✔ FPGA-ready
✔ Supports arithmetic, logic, branching, memory access
✔ Ideal for academic processor design projects

🚀 Future Enhancements
5-stage pipelined version (IF–ID–EX–MEM–WB)
Hazard detection & forwarding
Cache simulation
Additional instructions (MULT, DIV, etc.)

## ⭐ Support & Contributions
If you find this project helpful or interesting, please consider **starring the repository** — it helps others discover it!
⭐ **Star this repo:**  
👉 https://github.com/chengavenkataganesh/mips32-single-cycle-cpu
Contributions are **welcome and appreciated**!  
Whether it's fixing bugs, improving documentation, adding modules, or suggesting enhancements — feel free to open:
✅ Pull Requests  
✅ Issues  
✅ Feature Requests  
Your support helps this project grow. 🚀

