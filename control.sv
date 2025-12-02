// Control Unit - Instruction Decoder
// 9-bit instruction format parsing
module control(
  input        [8:0] instruction,
  
  // Decoded fields
  output logic [1:0] instr_type,     // 00=R, 01=I, 10=Mem, 11=Branch
  output logic [2:0] alu_func,       // ALU function (R-type)
  output logic [1:0] src_reg1,       // Source register 1
  output logic [1:0] src_reg2,       // Source register 2
  output logic [1:0] dest_reg,       // Destination register
  output logic [4:0] immediate,      // Immediate value (I-type)
  output logic       mem_load,       // 1=load, 0=store (Mem-type)
  output logic [4:0] mem_addr,       // Memory address (Mem-type)
  output logic       done_flag,      // Program done flag (Branch-type)
  output logic [1:0] branch_reg      // Register with jump address (Branch-type)
);

  // Extract instruction type (first 2 bits)
  assign instr_type = instruction[8:7];

  always_comb begin
    // Default values
    alu_func    = 3'b0;
    src_reg1    = 2'b0;
    src_reg2    = 2'b0;
    dest_reg    = 2'b0;
    immediate   = 5'b0;
    mem_load    = 1'b0;
    mem_addr    = 5'b0;
    done_flag   = 1'b0;
    branch_reg  = 2'b0;

    case(instr_type)
      2'b00: begin  // R-type: [type(2) | func(3) | src1(1) | src2(1) | dest(2)]
        alu_func = instruction[6:4];
        src_reg1 = {1'b0, instruction[3]};  // Expand 1-bit to 2-bit (r0 or r1)
        src_reg2 = {1'b0, instruction[2]};
        dest_reg = instruction[1:0];
      end

      2'b01: begin  // I-type: [type(2) | dest(2) | immediate(5)]
        dest_reg  = instruction[6:5];
        immediate = instruction[4:0];
      end

      2'b10: begin  // Memory: [type(2) | load(1) | reg(1) | addr(5)]
        mem_load = instruction[6];
        src_reg1 = {1'b0, instruction[5]};  // Register to load to / store from
        mem_addr = instruction[4:0];
      end

      2'b11: begin  // Branch: [type(2) | done(1) | reg1(2) | reg2(2) | jump_reg(2)]
        done_flag  = instruction[6];
        src_reg1   = instruction[5:4];  // First register for BEQ
        src_reg2   = instruction[3:2];  // Second register for BEQ
        branch_reg = instruction[1:0];  // Register containing jump address
      end
    endcase
  end

endmodule
