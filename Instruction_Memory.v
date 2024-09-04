module Instruction_Memory(address,instruction);
    input [31:0] address;
    output [31:0] instruction;

	reg [31:0] I_mem [99:0];  

	assign instruction = I_mem[address>>2];


endmodule