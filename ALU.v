module ALU (
	input [31:0] readData1,      // First operand from register file
    input [31:0] readData2,      // Second operand from register file
    input [31:0] extended,       // Extended immediate value
    input [2:0]  ALUControl,     // ALU control signal
    input ALUSrc,                // ALU source selector
    output reg [31:0] ALU_RESULT, // ALU result
    output reg Zero              // Zero flag
);

    reg [31:0] B;  // ALU second operand

    // ALU operation
    always @(*) begin
        //default value
            Zero=0;
            ALU_RESULT=0;
        // Select ALU's second operand
        if (ALUSrc) begin
            B = extended;
        end else begin
            B = readData2;
        end
        
        // ALU operation based on ALUControl
        case (ALUControl)
            3'b000: ALU_RESULT = readData1 & B; // AND
            3'b001: ALU_RESULT = readData1 | B; // OR
            3'b010: ALU_RESULT = readData1 + B; // ADD
            3'b110: ALU_RESULT = readData1 - B; // SUB
            3'b111: ALU_RESULT = (readData1 < B) ? 1 : 0; // SLT
            default: ALU_RESULT = 0;
        endcase

        // Set Zero flag
        Zero = (ALU_RESULT == 0) ? 1 : 0 ;
    end
endmodule