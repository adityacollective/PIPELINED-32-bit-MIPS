module comparator(
input [31:0] a, b,
output z
);
assign z = (a == b) ? 1'b1 : 1'b0;
endmodule