module mux_5(
input [4:0] in_a, in_b,
input sel,
output [4:0] out
);
    assign out = sel ? in_b : in_a;
endmodule