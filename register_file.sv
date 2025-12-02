module register_file(
  input       clk,           // clock
              write_enable,  
  input[1:0]  read_a,        // read address A (r0 field from instruction)
              read_b,        // read address B (r1 field from instruction)
              write_addr,    
  input[7:0]  write_data,    
  output[7:0] read_a_data,   // read data out A
              read_b_data    // read data out B
);

  logic[7:0] core[4]; // reg file: 4 registers, 8 bits

  // synchronous write
  always_ff @(posedge clk)
    if(write_enable) core[write_addr] <= write_data;

  // asynchronous read
  assign read_a_data = core[read_a];
  assign read_b_data = core[read_b];

endmodule
