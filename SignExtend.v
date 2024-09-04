module Sign_Extend(in,extended); 

    input [15:0] in;
    output reg [31:0] extended;

    always@(*) begin
         if (in[15]) begin
            extended = {{16{1'b1}}, in};
        end
        else begin
            extended = {{16{1'b0}}, in};
        end
    end

endmodule