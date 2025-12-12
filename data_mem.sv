// Data Memory Module - compatible with TopLevel0 harness
module data_mem(
  input        clk,
  input  [7:0] DataAddress,
  input        ReadMem,      // kept for compatibility
  input        WriteMem,
  input  [7:0] DataIn,
  output logic [7:0] DataOut
);

  // Full memory array (backing store)
  logic [7:0] core[256];
  
  // Small window the testbench accesses directly
  logic [7:0] mem_core [0:3];

  // Write on clock rise
  always_ff @(posedge clk) begin
    if(WriteMem) begin
      core[DataAddress] <= DataIn;
      // Keep mem_core in sync for addresses 0-3
      if(DataAddress < 4)
        mem_core[DataAddress] <= DataIn;
    end
  end

  // Read data (always use core so preloaded values are visible to CPU)
  assign DataOut = core[DataAddress];

endmodule
