module data_mem(
input memread, memwrite,
input [31:0] address,
input [31:0] write_data,
output reg [31:0] read_data
);
    reg [7:0] data_mem [1023:0];
    initial $readmemh("data_file.dat", data_mem);
    always@(*) read_data = (memread) ? {data_mem[address], data_mem[address+1], data_mem[address+2], data_mem[address+3]} : read_data;
    always@(*)
    begin
    if(memwrite)
    begin
        data_mem[address+3] = write_data[7:0];
        data_mem[address+2] = write_data[15:8];
        data_mem[address+1] = write_data[23:16];
        data_mem[address] = write_data[31:24];
    end
    end
endmodule