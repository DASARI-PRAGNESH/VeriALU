# VeriALU

### A Parameterized 32-Bit Arithmetic Logic Unit (ALU) in Verilog HDL

VeriALU is a parameterized 32-bit Arithmetic Logic Unit (ALU) implemented in **Verilog HDL**. The project demonstrates the complete FPGA digital design workflow, including RTL design, functional simulation, synthesis, technology mapping, resource utilization analysis, and timing verification using **AMD Vivado 2026.1**.

# Project Overview

VeriALU is designed to perform a wide range of arithmetic, logical, shift, comparison, and data transfer operations on two 32-bit operands. A 4-bit control signal selects one of sixteen supported operations, while four status flags provide additional information about the result.

The design was verified using a **self-checking Verilog testbench** containing 20 directed test cases. Functional verification was performed through behavioral simulation, followed by synthesis and implementation analysis using AMD Vivado.

This project is intended to demonstrate good RTL design practices, functional verification, and FPGA implementation flow, making it suitable as a digital design portfolio project.

# Features

- Parameterized 32-bit ALU architecture
- Supports 16 different ALU operations
- Generates Carry, Zero, Overflow, and Negative status flags
- Self-checking Verilog testbench
- 20 functional test cases with automatic PASS/FAIL reporting
- Behavioral simulation and waveform verification
- RTL Schematic generation
- Technology Schematic generation
- FPGA resource utilization analysis
- Timing analysis using AMD Vivado
- Synthesizable and modular Verilog HDL design

# Supported 16 ALU Operations

| ALU_Sel | Operation | Description |
|:-------:|-----------|-------------|
| `0000` | ADD | Addition |
| `0001` | SUB | Subtraction |
| `0010` | MUL | Multiplication |
| `0011` | DIV | Division |
| `0100` | AND | Bitwise AND |
| `0101` | OR | Bitwise OR |
| `0110` | XOR | Bitwise XOR |
| `0111` | NOT | Bitwise NOT (Operand A) |
| `1000` | Logical Shift Left | A << 1 |
| `1001` | Logical Shift Right | A >> 1 |
| `1010` | Arithmetic Shift Right | Signed A >>> 1 |
| `1011` | Set Less Than | Result = (A < B) |
| `1100` | NAND | Bitwise NAND |
| `1101` | NOR | Bitwise NOR |
| `1110` | XNOR | Bitwise XNOR |
| `1111` | PASS A | Output Operand A |

# Architecture / Block Diagram

<p align="center">
  <img src="docs/Block Diagram.png" width="900"/>
</p>

# Folder Structure

```text
VeriALU/
│
├── RTL/
│   └── alu.v
│
├── TESTBENCH/
│   └── alu_tb.v
│
├── docs/
│   ├── Block Diagram.png
│   ├── Simulation Waveform.png
│   ├── Simulation Console.png
│   ├── RTL_Schematic.pdf
│   ├── Technology Schematic
│   ├── Utilization_Report.png
│   └── Timing Summary.png
│
├── vivado/
│   └── alu
│
├── README.md
├── LICENSE
└── .gitignore
```

---

# Tools Used

| Tool | Purpose |
|------|---------|
| Verilog HDL | RTL Design |
| AMD Vivado 2026.1 | Simulation, Synthesis, Implementation |
| Xilinx Artix-7 (xc7a200tfbg676-2) | Target FPGA Device |
| Git | Version Control |
| GitHub | Project Repository |

# How to Run the Simulation

1. Open the Vivado project (`.xpr`).
2. Open **Flow Navigator**.
3. Select **Run Behavioral Simulation**.
4. Observe the waveform and simulation console.
5. Verify that all 20 test cases pass successfully.
6. Run **Synthesis** to generate RTL and Technology Schematics.
7. Generate the Utilization Report and Timing Summary.

# Results

## Functional Verification

- 20 Test Cases Executed
- 20 Test Cases Passed
- 0 Test Cases Failed

## Simulation Waveform

<p align="center">
  <img src="docs/Simulation Waveform.png" alt="Simulation Waveform" width="1000"/>
</p>

## Simulation Console

<p align="center">
  <img src="docs/Simulation Console.png" alt="Simulation Console Output" width="1000"/>
</p>

## RTL Schematic

<p align="center">
  <img src="docs/RTL_Schematic.pdf" alt="RTL Schematic" width="1000"/>
</p>

## 📈 FPGA Resource Utilization

<p align="center">
  <img src="docs/Utilization_Report.png" alt="FPGA Resource Utilization" width="1000"/>
</p>

### Resource Summary

| Resource | Used | Available | Utilization |
|----------|-----:|----------:|------------:|
| LUT | 1541 | 134600 | 1.14% |
| DSP | 3 | 740 | 0.41% |
| IO | 104 | 400 | 26.00% |

## Timing Summary

<p align="center">
  <img src="docs/Timing Summary.png" alt="Timing Summary" width="1000"/>
</p>

### Timing Results

- Worst Negative Slack (WNS): **∞**
- Total Negative Slack (TNS): **0.000 ns**
- Failing Endpoints: **0**

> **Note:** VeriALU is a purely combinational design with no sequential elements. Since there are no clocked timing paths, Vivado reports infinite setup and hold slack, which is expected for this type of design.

# Future Improvements

- Pipeline architecture for higher operating frequency
- Configurable operand width (8/16/32/64-bit)
- Barrel shifter implementation
- Additional arithmetic operations (Modulo, Rotate Left/Right)
- Signed and unsigned multiplication modes
- Integration into a RISC-V processor datapath
- FPGA board implementation and hardware validation

# Author

**DASARI PRAGNESH**

Electronics and Communication Engineering (ECE)

**Project:** VeriALU — A Parameterized 32-Bit Arithmetic Logic Unit in Verilog HDL

If you found this project useful, consider giving it a **Star** on GitHub.
