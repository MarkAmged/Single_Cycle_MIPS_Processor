module Main_Decoder(
    input [5:0] opcode,
    output reg RegDst,
    output reg ALUSrc,
    output reg MemToReg,
    output reg regWrite,
    output reg memWrite,
    output reg Branch,
    output reg Jump,
    output reg [1:0] ALUOp
);

always @(*) begin
    // Default values
    regWrite = 0;
    RegDst = 0;
    ALUSrc = 0;
    memWrite = 0;
    MemToReg = 0;
    ALUOp = 2'b00;
    Branch = 0;
    Jump = 0;

    case (opcode)
        6'b00_0000: begin // R-type
            regWrite = 1;
            RegDst = 1;
            ALUOp = 2'b10;
        end
        6'b00_0010: begin // J-type (jump)
            Jump = 1;
        end
        6'b00_0100: begin // BEQ (branch)
            Branch = 1;
            ALUOp = 2'b01;
        end
        6'b00_1000: begin // ADDI (I-type)
            regWrite = 1;
            ALUSrc = 1;
        end
        6'b10_0011: begin // LW (load)
            regWrite = 1;
            ALUSrc = 1;
            MemToReg = 1;
        end
        6'b10_1011: begin // SW (store)
            ALUSrc = 1;
            memWrite = 1;
        end
        default: begin
             RegDst=0;
             ALUSrc=0;
             MemToReg=0;
             regWrite=0;
             memWrite=0;
             Branch=0;
             Jump=0;
             ALUOp=0;
        end
    endcase
end

endmodule