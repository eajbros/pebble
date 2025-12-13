
module data_mem(
  input clk,
  input [7:0] DataAddress,
  input ReadMem,
  input WriteMem,
  input [7:0] DataIn,
  output logic [7:0] DataOut
);
  logic [7:0] core[256];
  logic [7:0] mem_core [0:3];
  always_ff @(posedge clk) begin
    if(WriteMem) begin
      core[DataAddress] <= DataIn;
      if(DataAddress < 4)
        mem_core[DataAddress] <= DataIn;
    end
  end
  assign DataOut = core[DataAddress];
endmodule
