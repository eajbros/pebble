// Data Memory Module
module data_memory(
  input        Clk,
               WriteEnable,
  input  [7:0] WriteData,
               Addr,
  output logic [7:0] ReadData
);

  logic [7:0] Mem[256];

  // Write on clock rise
  always_ff @(posedge Clk)
    if(WriteEnable) Mem[Addr] <= WriteData;

  // Read data
  assign ReadData = Mem[Addr];

endmodule
