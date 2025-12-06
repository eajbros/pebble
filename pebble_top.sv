// Pebble Processor Top Module
module TopLevel(
  input        clk,
               reset,
               start,
  output logic done
);

  // Program Counter wires
  wire [9:0] PC;
  wire [9:0] JumpAddr;
  wire       JumpEnable;

  // Instruction Memory wires
  wire [8:0] mach_code;

  // Control Unit outputs
  wire [1:0] instr_type;
  wire [2:0] alu_func;
  wire [1:0] src_reg1;
  wire [1:0] src_reg2;
  wire [1:0] dest_reg;
  wire [4:0] immediate;
  wire       mem_load;
  wire [4:0] mem_addr;
  wire       done_flag;
  wire [1:0] branch_reg;

  // Register File wires
  wire [7:0] RdatA;      // RF data out (src1)
  wire [7:0] RdatB;      // RF data out (src2)
  wire [7:0] RdatC;      // RF data out (branch target)
  wire [7:0] WdatR;      // RF data in
  wire       WenR;       // RF write enable

  // ALU wires
  wire [7:0] DatA;       // ALU input A
  wire [7:0] DatB;       // ALU input B
  wire [7:0] Rslt;       // ALU result
  wire       Zero;       // ALU zero flag

  // Data Memory wires
  wire [7:0] DataOut;    // DM data out
  wire [7:0] DataIn;     // DM data in
  wire [7:0] DataAddress; // DM address
  wire       WriteMem;   // DM write enable
  wire       ReadMem;    // DM read enable (unused but required)

  // Additional control signals
  wire       Ldr;        // Load instruction
  wire       Str;        // Store instruction

  // Datapath connections
  assign DatA = RdatA;
  assign DatB = RdatB;
  
  // Write-back mux: choose between ALU result, immediate, or memory data
  assign WdatR = (instr_type == 2'b01) ? {3'b0, immediate} :  // I-type: load immediate
                 (Ldr) ? DataOut :                             // Memory load
                 Rslt;                                         // ALU result

  // Memory operations
  assign DataIn = RdatA;                   // Store data from register
  assign DataAddress = {3'b0, mem_addr};   // Memory address (extended to 8 bits)
  assign WriteMem = Str;                   // Write enable for store
  assign ReadMem = 1'b1;                   // Always enabled for reads

  // Register file write enable
  assign WenR = (instr_type == 2'b00) ||   // R-type writes result
                (instr_type == 2'b01) ||   // I-type writes immediate
                (Ldr);                      // Load writes memory data

  // Load/Store control
  assign Ldr = (instr_type == 2'b10) && mem_load;
  assign Str = (instr_type == 2'b10) && !mem_load;

  // Branch/Jump logic
  assign JumpEnable = (instr_type == 2'b11) && !done_flag && Zero;  // BEQ when zero
  assign JumpAddr = {2'b0, RdatC[7:0]};    // Jump address from register (branch_reg)

  // Done flag output
  assign done = done_flag;

  // Module instantiations
  prog_ctr PC1(
    .Clk(clk),
    .Reset(reset),
    .JumpEnable(JumpEnable),
    .JumpAddr(JumpAddr),
    .PC(PC)
  );

  instr_mem IM1(
    .addr(PC),
    .instruction(mach_code)
  );

  control CTRL1(
    .instruction(mach_code),
    .instr_type(instr_type),
    .alu_func(alu_func),
    .src_reg1(src_reg1),
    .src_reg2(src_reg2),
    .dest_reg(dest_reg),
    .immediate(immediate),
    .mem_load(mem_load),
    .mem_addr(mem_addr),
    .done_flag(done_flag),
    .branch_reg(branch_reg)
  );

  register_file RF1(
    .clk(clk),
    .write_enable(WenR),
    .read_a(src_reg1),
    .read_b(src_reg2),
    .read_c(branch_reg),
    .write_addr(dest_reg),
    .write_data(WdatR),
    .read_a_data(RdatA),
    .read_b_data(RdatB),
    .read_c_data(RdatC)
  );

  alu ALU1(
    .alu_op(alu_func),
    .r0(DatA),
    .r1(DatB),
    .result(Rslt),
    .zero(Zero)
  );

  data_mem       dm(.*);

endmodule
