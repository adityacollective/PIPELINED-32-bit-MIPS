module mux_9(
input [8:0] in_a, in_b,
input sel,
output [8:0] out
);
    assign out = sel ? in_b : in_a;
endmodule