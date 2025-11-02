# mips32-single-cycle-cpu
Great — since you developed and tested your MIPS32 CPU using **Xilinx Vivado**, I will update your README to include **Vivado-specific instructions**, **simulation flow**, **synthesis steps**, and **FPGA compatibility notes**.

Here is the **updated, final, professional README.md** optimized for Vivado users:

---


```md
# MIPS32 Single-Cycle CPU  
A modular and fully functional implementation of a **32-bit MIPS single-cycle processor**, developed and tested using **Xilinx Vivado**.  
This project includes all essential components of the MIPS architecture along with a GitHub Pages deployment showing a high-level datapath visualization.

---

## 🌐 Live Datapath Visualization (GitHub Pages)

🔗 **View the MIPS Datapath Diagram:**  
👉 [https://YOUR-USERNAME.github.io/YOUR-REPO-NAME/](https://chengavenkataganesh.github.io/mips32-single-cycle-cpu/)


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

A high-level datapath diagram is available in the deployment page.

---

# 📁 Repository Structure

```

.
├── src/                     # Vivado HDL source files
│   ├── alu.v
│   ├── alucontrol.v
│   ├── branch_jump_address_units.v
│   ├── control_unit.v
│   ├── datamemory.v
│   ├── instruction_memory.v
│   ├── mux_and_logic_units.v
│   ├── pcplus1.v
│   ├── program_counter.v
│   ├── register_file.v
│   ├── sign_extend.v
│   └── top.v
│
├── tb/                      # Testbenches (add your testbench files here)
│   ├── (your_tb_files.v)
│
├── index.html               # GitHub Pages visualization
└── README.md                # Documentation

````

---

# 🛠️ Running the CPU in Vivado

## ✅ 1. **Create a Vivado Project**
1. Open **Vivado**
2. Click **Create New Project**
3. Select **RTL Project**
4. Add all files from the `src/` folder
5. (Optional) Add testbench files into **Simulation Sources**

---

## ✅ 2. **Run Behavioral Simulation**
1. Go to **Flow Navigator → Simulation**
2. Click **Run Simulation → Run Behavioral Simulation**
3. Vivado will:
   - open the testbench
   - compile design
   - show waveforms in the simulator

📌 You can view PC, instruction execution, ALU output, register write data, branch decisions, and memory interactions.

---

## ✅ 3. **Synthesize the CPU**
1. Go to **Flow Navigator → Synthesis**
2. Click **Run Synthesis**
3. Vivado will check:
   - timing
   - LUT/FF utilization
   - logic correctness

---

## ✅ 4. **(Optional) Implement on FPGA**
If you have a board (e.g., Basys3, Nexys A7):

1. Create constraints file (`.xdc`)
2. Map I/O pins for buttons, switches, LEDs
3. Run **Implementation**
4. Generate bitstream  
5. Program the FPGA

---

# ✅ Simulation Guide (Vivado Testbench)

Example Vivado testbench structure:

```verilog
module top_tb;
    reg clk;
    reg reset;

    top uut (.clk(clk), .reset(reset));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100MHz clock
    end

    initial begin
        reset = 1;
        #20 reset = 0;
    end

endmodule
````

You can add `$display`, `$monitor`, or waveform probes via Vivado.

---

# ✅ Key Features

* ✔ MIPS32 compliant single-cycle execution
* ✔ Modular & clean HDL structure
* ✔ Fully synthesizable in Vivado
* ✔ Easy to port to FPGA
* ✔ Supports branching, memory access, arithmetic, and logical operations
* ✔ Perfect for academic projects or learning processor design

---

# 🚀 Future Enhancements

* ✅ Pipelined 5-stage version (IF-ID-EX-MEM-WB)
* ✅ Hazard detection and forwarding
* ✅ Cache simulation
* ✅ More instructions (MULT, DIV, etc.)

---

# 📜 License

You can add MIT, GPL, or BSD license depending on your preference.

---

# 👤 Author

**Harsha**
Designed, verified, and implemented using **Xilinx Vivado**.

```

---

# ✅ If you want, I can also generate:
✅ A **Vivado constraints file (.xdc)** for FPGA  
✅ A **testbench template** for your top module  
✅ A **block diagram image** for your README  
✅ A **GitHub banner** for your repo  

Just tell me!
```
