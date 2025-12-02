module prog_ctr(
  input             Clk,
                    Reset,
					          JumpEnable,
  input       [9:0] JumpAddr,
  output logic[9:0] PC);

  always_ff @(posedge Clk)
    if(Reset) PC <= 'b0;
	else if(JumpEnable) PC <= JumpAddr;
	else PC <= PC + 10'd1;

endmodule