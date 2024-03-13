module mux_32(
input [31:0] in_a, in_b,
input sel,
output [31:0] out
);
    assign out = sel ? in_b : in_a;
endmodule


module register #(parameter width = 0)
                 (input clk, rst,
                  input  [width-1 : 0] in,
                  output reg [width-1 : 0] out
                 );
                 
                 always@(posedge clk)
                 begin
                     if(rst)
                         out <= 0;
                     else
                         out <= in;
                 end
endmodule