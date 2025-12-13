
module instr_mem #(
    parameter ADDR_WIDTH = 10,
    parameter DATA_WIDTH = 9,
    parameter MEM_DEPTH  = 1024
)(
    input  logic [ADDR_WIDTH-1:0] addr,
    output logic [DATA_WIDTH-1:0] instruction
);
    logic [DATA_WIDTH-1:0] mem [MEM_DEPTH-1:0];
    initial begin
        $readmemb("instrs.txt", mem);
    end
    assign instruction = mem[addr];
endmodule
