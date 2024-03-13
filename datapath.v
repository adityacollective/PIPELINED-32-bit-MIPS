module datapath(
input clk, rst,
input alusrc, regdst, branch,
input regwrite, memread, memwrite, memtoreg, 
output zero,
input [1:0] aluop,
output [5:0] opcode,
output [31:0] display_ins,
output [31:0] alu_result, last_mux_out,
output [4:0] write_reg_disp,
output [31:0] pc_mux_out, branch_adder_out, pc_adder_out,
output [1:0] fa, fb,
output pcwrite, if_write, hu_sel,
output [8:0] hu_mux_out,
output [31:0] alu_mux_out, mux_dh1_out, mux_dh2_out, data_mem_out
);
wire [31:0]  instruction, read_data1, read_data2, sign_extend_out, readdata, pc_out, shift_left_out, ch1_out, ch2_out, load_hz_mux_out;
wire [4:0]   wb_mux_out, id_dh_out;
wire [63:0]  if_out;
wire [151:0] id_out;
wire [106:0] ex_out;
wire [70:0]  wb_out;
wire [3:0]   alu_control_out;
wire pcsrc, z, if_flush, fa_d, fb_d, ld_sel;

assign if_flush = pcsrc;
assign opcode = if_out[31:26];
assign display_ins = if_out[31:0];
assign write_reg_disp = wb_out[4:0];
assign data_mem_out = wb_out[36:5];
assign pcsrc = z & branch;


    register_en_clr #(64)  IF(clk, rst, if_write, if_flush, {pc_adder_out, instruction}, if_out);
    register #(152)        ID(clk, rst, {hu_mux_out, if_out[10:6], if_out[63:32], read_data1, read_data2, sign_extend_out, if_out[20:16], if_out[15:11]}, id_out);
    register #(107)        EX(clk, rst, {id_out[151:147], zero, branch_adder_out, alu_result, mux_dh2_out, wb_mux_out}, ex_out);
    register #(71)         WB(clk, rst, {ex_out[106:105], readdata, ex_out[68:37], ex_out[4:0]}, wb_out);
    register #(5)          ID_DH(clk, rst, if_out[25:21], id_dh_out);
    mux_32                 pc_mux(pc_adder_out, branch_adder_out, pcsrc, pc_mux_out);
    adder                  pc_adder(pc_out, 32'd4, pc_adder_out);
    instruction_mem        instruction_memory(pc_out, instruction);
    register_file          RF(pc_mux_out, pc_out, pcwrite, rst, wb_out[70], clk, if_out[25:21], if_out[20:16], wb_out[4:0], last_mux_out, read_data1, read_data2);
    sign_extend            sign_extender(if_out[15:0], sign_extend_out);
    shift_left_32          shift_left(sign_extend_out, shift_left_out);
    adder                  branch_adder(if_out[63:32], shift_left_out, branch_adder_out);
    mux_32                 alu_mux(mux_dh2_out, id_out[41:10], id_out[143], alu_mux_out);
    mux_5                  wb_mux(id_out[9:5], id_out[4:0], id_out[146], wb_mux_out);
    alu                    ALU(mux_dh1_out, alu_mux_out, alu_control_out, alu_result, id_out[142:138], zero);
    alucontrol             ALU_CONTROL(id_out[145:144], id_out[15:10], alu_control_out);
    data_mem               data_memory(ex_out[103], ex_out[102], ex_out[68:37], load_hz_mux_out, readdata);
    mux_32                 last_mux(wb_out[36:5], wb_out[68:37], wb_out[69], last_mux_out);
    forwarding_unit        fu(id_dh_out, id_out[9:5], ex_out[4:0], wb_out[4:0], ex_out[106], wb_out[70], fa, fb);
    mux_32_3bit            mux_dh1(id_out[105:74], last_mux_out, ex_out[68:37], fa, mux_dh1_out);
    mux_32_3bit            mux_dh2(id_out[73:42], last_mux_out, ex_out[68:37], fb, mux_dh2_out);
    mux_9                  hu_mux({regwrite, memtoreg, branch, memread, memwrite, regdst, aluop, alusrc}, 9'd0, hu_sel, hu_mux_out);
    hdu                    hu(id_out[9:5], if_out[25:21], if_out[20:16], id_out[148], pcwrite, if_write, hu_sel);
    comparator             comparator(ch1_out, ch2_out, z);
    mux_32                 ch1(read_data1, ex_out[68:37], fa_d, ch1_out);
    mux_32                 ch2(read_data2, ex_out[68:37], fb_d, ch2_out);
    forwarding_unit_ch     fu_ch(if_out[25:21], if_out[20:16], wb_mux_out, ex_out[4:0], ex_out[106], id_out[151], fa_d, fb_d);
    mux_32                 load_hz_mux(ex_out[36:5], wb_out[68:37], ld_sel, load_hz_mux_out);
    load_hz                hz(ex_out[4:0], wb_out[4:0], wb_out[70], ld_sel);
    
endmodule