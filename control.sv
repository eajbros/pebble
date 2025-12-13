
// Control Unit: Decodes 9-bit instructions
module control(
  input [8:0] instruction,
  output logic [1:0] instr_type,
  output logic [2:0] alu_func,
  output logic [1:0] src_reg1,
  output logic [1:0] src_reg2,
  output logic [1:0] dest_reg,
  output logic [4:0] immediate,
  output logic mem_load,
  output logic [1:0] mem_data_reg,
  output logic [1:0] mem_addr_reg,
  output logic done_flag,
  output logic [1:0] branch_reg
);
  assign instr_type = instruction[8:7];
  always_comb begin
    alu_func     = 3'b0;
    src_reg1     = 2'b0;
    src_reg2     = 2'b0;
    dest_reg     = 2'b0;
    immediate    = 5'b0;
    mem_load     = 1'b0;
    mem_data_reg = 2'b0;
    mem_addr_reg = 2'b0;
    done_flag    = 1'b0;
    branch_reg   = 2'b0;
    case(instr_type)
      2'b00: begin // R-type
        alu_func = instruction[6:4];
        src_reg1 = {1'b0, instruction[3]};
        src_reg2 = {1'b0, instruction[2]};
        dest_reg = instruction[1:0];
      end
      2'b01: begin // I-type
        dest_reg  = instruction[6:5];
        immediate = instruction[4:0];
      end
      2'b10: begin // Memory
        mem_load     = instruction[6];
        mem_data_reg = instruction[5:4];
        mem_addr_reg = instruction[3:2];
        src_reg1 = mem_addr_reg;
        if(mem_load)
          dest_reg = mem_data_reg;
        else
          src_reg2 = mem_data_reg;
      end
      2'b11: begin // Branch
        done_flag  = instruction[6];
        src_reg1   = instruction[5:4];
        src_reg2   = instruction[3:2];
        branch_reg = instruction[1:0];
      end
    endcase
  end
endmodule
