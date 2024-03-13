module register_en_clr #(parameter width = 0)
                 (input clk, rst, en, clr,
                  input  [width-1 : 0] in,
                  output reg [width-1 : 0] out
                 );
                 
                 always@(posedge clk)
                 begin
                     if(rst || clr)
                         out <= 0;
                     else
                     begin
                         if(en) out <= in;
                         //else   out <= out;
                     end
                 end
endmodule