module mux_32_3bit(
input [31:0] in_a, in_b, in_c,
input [1:0] sel,
output reg [31:0] out
);
always@(*)
begin
    case(sel)
        2'b00: out = in_a;
        2'b01: out = in_b;
        2'b10: out = in_c;
    endcase
end
endmodule