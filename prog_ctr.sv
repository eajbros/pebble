module prog_ctr(
  input             Clk,
                    Reset,
					          JumpEnable,
  input       [9:0] JumpAddr,
  output logic[9:0] PC);

  always_ff @(posedge Clk)
    if(Reset) begin
      PC <= 'b0;
    end else if(JumpEnable) begin
      PC <= JumpAddr;
    end else begin
      PC <= PC + 10'd1;
    end

endmodule