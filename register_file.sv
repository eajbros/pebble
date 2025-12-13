
module register_file(
  input clk,
  input write_enable,
  input [1:0] read_a,
  input [1:0] read_b,
  input [1:0] read_c,
  input [1:0] write_addr,
  input [7:0] write_data,
  output [7:0] read_a_data,
  output [7:0] read_b_data,
  output [7:0] read_c_data
);
  logic [7:0] core[4];
  always_ff @(posedge clk)
    if(write_enable)
      core[write_addr] <= write_data;
  assign read_a_data = core[read_a];
  assign read_b_data = core[read_b];
  assign read_c_data = core[read_c];
endmodule
