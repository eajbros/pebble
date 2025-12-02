// Instruction Memory Module
// Reads machine_code.txt and output instruction at address
module instruction_memory #(
    parameter ADDR_WIDTH = 10,
    parameter DATA_WIDTH = 9,
    parameter MEM_DEPTH  = 1024
)(
    input  logic [ADDR_WIDTH-1:0] addr,
    output logic [DATA_WIDTH-1:0] instruction
);

    logic [DATA_WIDTH-1:0] mem [MEM_DEPTH-1:0];

    // Load machine code from file
    initial begin
        $readmemb("machine_code.txt", mem);
    end

    // Output instruction at address
    assign instruction = mem[addr];

endmodule
