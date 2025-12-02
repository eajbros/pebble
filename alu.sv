module alu(
  input  [1:0] opcode,    // Operation code (2 bits from instruction[8:7])
  input  [7:0] dat_a,     // First operand (from register r0) - 8 bits
  input  [7:0] dat_b,     // Second operand (from register r1) - 8 bits
  output [7:0] result,    // ALU result - 8 bits
  output zero             // Zero flag - 1 bit
);

  reg [7:0] temp_result;  // 8-bit result

  always_comb begin
    case (opcode)
      2'b00: temp_result = dat_a + dat_b;  // ADD
      2'b01: temp_result = dat_a - dat_b;  // SUB
      2'b10: temp_result = dat_a & dat_b;  // AND
      2'b11: temp_result = dat_a | dat_b;  // OR
    endcase
  end

  assign result = temp_result;
  assign zero = (result == 8'b0);

endmodule
