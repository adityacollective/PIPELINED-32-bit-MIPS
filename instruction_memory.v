module instruction_mem(
input [31:0] address,
output [31:0] instruction
);
    reg [7:0] ins_mem [1023:0];
    initial $readmemh("ins_file.dat", ins_mem);
    
    assign instruction[7:0]   =  ins_mem[address+3];
    assign instruction[15:8]  =  ins_mem[address+2];
    assign instruction[23:16] =  ins_mem[address+1];
    assign instruction[31:24] =  ins_mem[address];
endmodule