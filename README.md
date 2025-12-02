# Pebble
A minimal 9-bit RISC architecture

# Architecture Overview
Pebble is a small, simple load-store architecture that uses a 9-bit instruction format. It supports key operations like arithmetic, logic, branching and memory operations.

# Key Features
- **9-bit instruction format** for compact code
- **4 general-purpose registers** (8-bit each)
- **Load-store architecture** - mem access through dedicated LW/SW instr
- **Word-aligned addressing** 
- **5-bit signed branch offset** for conditional jumps

# Instruction Format
```
| opcode | done | r0  | r1  | jump |
|   2    |  1   |  2  |  2  |  2   |
| [8:7]  | [6]  |[5:4]|[3:2]| [1:0]|
```

## Modules

# ALU
**Purpose**: Arithmetic Logic Unit for computational operations
**Interface**:
- `alu_op[2:0]` - 3-bit operation selector
- `r0[7:0], r1[7:0]` - 8-bit input operands
- `result[7:0]` - 8-bit output result
- `done` - done flag for conditional operations

**Supported Operations**:
- `000`: ADD - Addition
- `001`: SUB - Subtraction  
- `010`: AND - Bitwise AND
- `011`: OR - Bitwise OR
- `100`: XOR - Bitwise XOR
- `101`: SHL - Shift left by 1
- `110`: SHR - Shift right by 1
- `111`: CMP - Compare equal (returns 1 if equal, 0 if not)

# Register File
**Purpose**: Storage for 4 general-purpose registers
**Interface**:
- `clk` - System clock
- `write_enable` - Write enable
- `read_a[1:0], read_b[1:0]` - Read addresses for dual-port read
- `write_addr[1:0]` - Write address
- `write_data[7:0]` - Write data input
- `read_a_data[7:0], read_b_data[7:0]` - Read data outputs

**Features**:
- **4 registers × 8 bits** - storage array
- **Dual-port read** - supports binary ALU operations
- **Single-port write** - synchronized updates
- **Write enable control** - prevents accidental overwrites 

# Data Memory
**Purpose**


# Instruction Memory
**Purpose**


# Program Counter
**Purpose**


# Control
**Purpose**


# MUX
**Purpose**


# Top
**Purpose**

