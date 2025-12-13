# Pebble
A simple 9-bit RISC CPU for learning and small projects.

## What is Pebble?
Pebble is a tiny CPU with a 9-bit instruction format, 4 general-purpose 8-bit registers, and basic support for arithmetic, logic, memory, and branching. It's meant to be easy to understand and use for simple programs.

## How to Use Pebble
1. Write your program in machine code (see `prog1/` and `prog2/` for examples).
2. Put your machine code in `instrs.txt` (overwrite the placeholder).
3. Simulate the design using a Verilog tool.
4. The top module is `pebble_top.sv` (called `TopLevel`).
5. The CPU runs your program from `instrs.txt` and you can check outputs in memory or registers.

## Inputs and Outputs
- **Inputs:**
  - `clk`: clock
  - `reset`: resets the CPU
  - `start`: starts execution
- **Outputs:**
  - `done`: goes high when the program signals it's finished

## Instruction Types and Formats

- **R-type (Register):** Arithmetic/logic between registers
  - Format: `| 00 | ALUop[2:0] | src1[1:0] | src2[1:0] | dest[1:0] |`
    - bits [8:7]=00, [6:4]=ALU op, [5:4]=src1, [3:2]=src2, [1:0]=dest
    - Operations:
      - 000: ADD (add)
      - 001: SUB (subtract)
      - 010: AND (bitwise and)
      - 011: OR (bitwise or)
      - 100: XOR (bitwise xor)
      - 101: SHL (shift left by 1)
      - 110: SHR (shift right by 1)
      - 111: SLT (set if less than)

- **I-type (Immediate):** Load an immediate value into a register
  - Format: `| 01 | dest[1:0] | immediate[4:0] |`
    - bits [8:7]=01, [6:5]=dest, [4:0]=immediate
    - Operation: LI (load immediate)

- **Memory (M-type):** Load/store between register and memory
  - Format: `| 10 | load/store | data_reg[1:0] | addr_reg[1:0] | unused[1:0] |`
    - bits [8:7]=10, [6]=1 for load (LW), 0 for store (SW), [5:4]=data reg, [3:2]=address reg, [1:0]=unused
    - Operations: LW (load word), SW (store word)

- **Branch (B-type):** Conditional jump or program done
  - Format: `| 11 | done | reg1[1:0] | reg2[1:0] | target[1:0] |`
    - bits [8:7]=11, [6]=done flag, [5:4]=reg1, [3:2]=reg2, [1:0]=branch target reg
    - Operations: BEQ (branch if equal), DONE (program finished)

## Example Instructions
- `ADD R0, R1, R2`  (R-type)
- `LI R0, 8`         (I-type, load immediate)
- `LW R1, R2`        (load word from memory)
- `SW R0, R2`        (store word to memory)
- `BEQ R0, R1, R2`   (branch if equal)

## Modules (Short Summary)
- **ALU:** Does math and logic
- **Register File:** 4 registers, 8 bits each
- **Data Memory:** 256 bytes
- **Instruction Memory:** Loads program from `instrs.txt`
- **Program Counter:** Steps through instructions
- **Control:** Decodes instructions

## Programs

### Program 1: Closest Pair (Hamming Distance)
Finds the smallest and largest Hamming distances among all pairs in an array of 16 bytes (8-bit integers). The array starts at memory location 0. After running, the minimum distance is stored at location 16 and the maximum at location 17.

### Program 2: 2-Term Product (Unsigned Only)
Computes the product of two unsigned 8-bit numbers using shift-and-add (no multiply instruction). Operand A is at memory[0], operand B at memory[1]. The result is written to memory[2] (high bits) and memory[3] (low bits). Only works for unsigned values (MSB = 0).

## Tips
- Edit `instrs.txt` to change the program.
- Use the testbenches or your own to simulate.
- Outputs are usually in memory or registers, check them after `done` goes high.