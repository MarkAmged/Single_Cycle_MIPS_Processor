module MIPS_tb(
    input clk,
    input rst
);
    wire [31:0] instruction, pc, next_pc, pc_plus4, branch_target,address;
    wire [31:0] readData1, readData2, extended, ALU_RESULT, writeData, memData;
    wire [4:0] writeReg;
    wire [2:0] ALUControl;
    wire [5:0] opcode, funct;
    wire Zero, RegDst, ALUSrc, MemToReg, regWrite, memWrite, Branch, Jump;

    // Program Counter
    Program_Counter PC (
        .clk(clk),
        .rst(rst),
        .next_pc(next_pc),
        .pc(pc)
    );

    // Instruction Memory
    Instruction_Memory IM (
        .address(address),
        .instruction(instruction)
    );

    // Control Unit
    Control_Unit CU (
        .opcode(opcode),
        .funct(funct),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemToReg(MemToReg),
        .regWrite(regWrite),
        .memWrite(memWrite),
        .Branch(Branch),
        .Jump(Jump),
        .ALUControl(ALUControl)
    );

    // Register File
    Register_File RF (
        .clk(clk),
        .rst(rst),
        .regWrite(regWrite),
        .readReg1(instruction[25:21]),
        .readReg2(instruction[20:16]),
        .writeReg(writeReg),
        .writeData(writeData),
        .readData1(readData1),
        .readData2(readData2)
    );

    // ALU Control and ALU
    ALU ALU_ (
        .readData1(readData1),
        .readData2(readData2),
        .extended(extended),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .Zero(Zero),
        .ALU_RESULT(ALU_RESULT)
    );

    // Sign Extension
    Sign_Extend sign_extend (
        .in(instruction[15:0]),
        .extended(extended)
    );

    // Data Memory
    Data_Memory DM (
        .clk(clk),
        .rst(rst),
        .address(ALU_RESULT),
        .writeData(readData2),
        .memWrite(memWrite),
        .readData(memData)
    );

    // MUX for write register
    assign writeReg = RegDst ? instruction[15:11] : instruction[20:16];

    // MUX for ALU result or memory data
    assign writeData = MemToReg ? memData : ALU_RESULT;

    // Next PC logic
    assign pc_plus4 = pc + 4;
    assign branch_target = pc_plus4 + (extended << 2);
    assign next_pc = (Jump) ? {pc_plus4[31:28], instruction[25:0], 2'b00} :
                     (Branch & Zero) ? branch_target : pc_plus4;

    assign address = pc;        
    assign opcode = instruction[31:26];        
    assign funct = instruction[5:0];
endmodule
