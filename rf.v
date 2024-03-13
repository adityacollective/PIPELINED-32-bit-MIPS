module register_file(
input [31:0] pc_mux_out, 
output [31:0] pc_out,
input pcwrite, rst, regwrite, clk,
input [4:0] read_register1,
input [4:0] read_register2,
input [4:0] write_register,
input [31:0] write_data,
output [31:0] read_data1,
output [31:0] read_data2
);
    reg [31:0] register [31:0];
        assign read_data1 = (read_register1 != 0) ? register[read_register1] : register[0];
        assign read_data2 = (read_register2 != 0) ? register[read_register2] : register[0];
    always@(negedge clk)
    begin
        register[0] <= 32'd0;
        if(regwrite && write_register!=0 && write_register!= 29)
            register[write_register] <= write_data;
    end
    always@(posedge clk)
                 begin
                     if(rst)
                         register[29] <= 0;
                     else
                     begin
                         if(pcwrite) register[29] <= pc_mux_out;
                         //else   out <= out;
                     end
                 end
    assign pc_out = register[29];
endmodule