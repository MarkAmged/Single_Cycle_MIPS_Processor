module Program_Counter(clk,rst,next_pc,pc);
	input clk,rst;
	input [31:0] next_pc;
    output reg [31:0] pc;
    always@(posedge clk or posedge rst)begin
    	if(rst)
    		pc <=0;
    	else
    		pc<=next_pc;	
    end
endmodule