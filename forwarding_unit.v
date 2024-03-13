module forwarding_unit(
input [4:0] id_ex_rs, id_ex_rt, ex_mem_rd, mem_wb_rd,
input ex_mem_regwrite, mem_wb_regwrite,
output reg [1:0] fa, fb
);
    always@(*)  //for fb
    begin
        if((ex_mem_rd == id_ex_rt) && (ex_mem_rd != 0) && (ex_mem_regwrite == 1))
            fb = 2'b10;
        else if((mem_wb_rd == id_ex_rt) && (mem_wb_rd != 0) && (mem_wb_regwrite == 1))
            fb = 2'b01;
            
        else
            fb = 2'b00;
    end
    
    always@(*) //for fa
    begin
        if((ex_mem_rd == id_ex_rs) && (ex_mem_rd != 0) && (ex_mem_regwrite == 1))
            fa = 2'b10;
        else if((mem_wb_rd == id_ex_rs) && (mem_wb_rd != 0) && (mem_wb_regwrite == 1))
            fa = 2'b01;
        else
            fa = 2'b00;
    end
endmodule