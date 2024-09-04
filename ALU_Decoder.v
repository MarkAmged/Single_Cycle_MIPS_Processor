module ALU_Decoder(
    input [5:0] funct,
    input [1:0] ALUOp,
    output reg [2:0] ALUControl
);

always @(*) begin
    case (ALUOp)
        2'b00: ALUControl = 3'b010; // LW/SW (add)
        2'b01: ALUControl = 3'b110; // BEQ (subtract)
        2'b10: begin
            case (funct)
                6'b100000: ALUControl = 3'b010; // ADD
                6'b100010: ALUControl = 3'b110; // SUB
                6'b100100: ALUControl = 3'b000; // AND
                6'b100101: ALUControl = 3'b001; // OR
                6'b101010: ALUControl = 3'b111; // SLT
                default: ALUControl = 3'b010;   // Default to ADD
            endcase
        end
        default: ALUControl = 3'b010; // Default case
    endcase
end

endmodule