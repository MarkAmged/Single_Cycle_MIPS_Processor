module Data_Memory(address,writeData,readData,clk,rst,memWrite);
    input clk;
    input rst;
    input memWrite;
    input [31:0] address;
    input [31:0] writeData;
    output reg [31:0] readData;

	reg [31:0] mem [99:0];  

	always @(posedge clk or posedge rst) begin
    if (rst) begin
        if (memWrite) begin
            mem[address]<=writeData;
        end
    end
    end

    // MEMORY Read
    always @(*) begin
        readData[31:0]=0;
        if (rst) begin
            readData=0;
        end
        else begin
            readData=mem[address];
        end
    end
endmodule