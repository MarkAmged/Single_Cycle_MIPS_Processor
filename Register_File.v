module Register_File(clk,rst,regWrite,readReg1,readReg2,writeReg,writeData,readData1,readData2);
	input clk;
    input rst;
	input regWrite;
	input [4:0]readReg1;
	input [4:0]readReg2;
	input [4:0] writeReg;
    input [31:0] writeData;
    output reg [31:0] readData1;
    output reg [31:0] readData2;

    reg [31:0] regs [31:0];

    integer i;
    always @(posedge clk or posedge rst) begin
        if (!rst) begin
            for (i = 0; i < 32; i = i + 1) begin
                regs[i] <= 0;
            end
        end
        else begin
            if (regWrite) begin
                regs[writeReg]<=writeData;
            end
        end
    end

    always @(*) begin
        if (!rst) begin
            readData1=0;
            readData2=0;
        end
        else begin
            readData1=regs[readReg1];
            readData2=regs[readReg2];
        end
    end
endmodule    