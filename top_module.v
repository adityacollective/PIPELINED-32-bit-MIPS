module upper_module(
input clk, rst,
output [31:0] display_ins,
output [31:0] alu_result, last_mux_out,
output [4:0] write_reg_disp,
output [31:0] pc_mux_out, branch_adder_out, pc_adder_out,
output [1:0] fa, fb,
output [8:0] hu_mux_out,
output [31:0] alu_mux_out, mux_dh1_out, mux_dh2_out, data_mem_out
);
wire [5:0] opcode;
wire memtoreg, regdst, alusrc, branch, regwrite, memread, memwrite, zero;
wire [1:0] aluop;
wire pcwrite, if_write, hu_sel;

datapath dp(clk, rst, alusrc, regdst, branch, regwrite, memread, memwrite, memtoreg, zero, aluop, opcode, display_ins, alu_result, last_mux_out, write_reg_disp, pc_mux_out, branch_adder_out, pc_adder_out, fa, 
fb, pcwrite, if_write, hu_sel, hu_mux_out, alu_mux_out, mux_dh1_out, mux_dh2_out, data_mem_out);
control cp(opcode, regdst, alusrc, memtoreg, regwrite, memread, memwrite, branch, aluop);

endmodule