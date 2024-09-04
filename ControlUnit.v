module Control_Unit(
    input [5:0] opcode,
    input [5:0] funct, // For R-type instructions
    output wire RegDst,
    output wire ALUSrc,
    output wire MemToReg,
    output wire regWrite,
    output wire memWrite,
    output wire Branch,
    output wire Jump,
    output wire [2:0] ALUControl
);
    wire [1:0] ALUOp;
    
    // Instantiate the Main Decoder
    Main_Decoder main_decoder_inst (
        .opcode(opcode),
        .regWrite(regWrite),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .memWrite(memWrite),
        .MemToReg(MemToReg),
        .Branch(Branch),
        .Jump(Jump),
        .ALUOp(ALUOp)
    );
    
    // Instantiate the ALU Decoder
    ALU_Decoder alu_decoder_inst (
        .funct(funct),
        .ALUOp(ALUOp),
        .ALUControl(ALUControl)
    );
endmodule
