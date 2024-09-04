module mips_tb;
	reg clk;
	reg rst;

MIPS_tb DUT (clk,rst);

initial begin
    clk=0;
    forever begin
    	#10 clk= ~clk;
    end
end

initial begin

    $readmemh("D:/MIPS_Project/mem.dat", DUT.DM.mem);
    $readmemh("D:/MIPS_Project/inst.dat", DUT.IM.I_mem);
    
    rst=1;
    repeat(2) @(negedge clk);
    rst=0;

    repeat(13) @(negedge clk);
    $stop;
end
endmodule