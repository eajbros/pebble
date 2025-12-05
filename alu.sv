module alu(
  input [2:0] alu_op,
  input [7:0] r0, r1,
  output logic[7:0] result,
  output logic done);

always_comb begin
  case(alu_op)
    3'b000: result = r0 + r1;  // add
    3'b001: result = r0 - r1;  // sub
    3'b010: result = r0 & r1;  // and
    3'b011: result = r0 | r1;  // or
    3'b100: result = r0 ^ r1;  // xor
    3'b101: result = r0 << 1;  // shl
    3'b110: result = r0 >> 1;  // shr
    3'b111: result = (r0 == r1) ? 8'b1 : 8'b0; // cmp
  endcase
end
  assign zero = (result == 8'b0);
endmodule
