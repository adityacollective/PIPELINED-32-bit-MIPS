module register_en #(parameter width = 0)
                 (input clk, rst, en,
                  input  [width-1 : 0] in,
                  output reg [width-1 : 0] out
                 );
                 
                 always@(posedge clk)
                 begin
                     if(rst)
                         out <= 0;
                     else
                     begin
                         if(en) out <= in;
                         //else   out <= out;
                     end
                 end
endmodule