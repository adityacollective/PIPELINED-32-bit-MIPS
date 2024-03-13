module forwarding_unit_ch(
input [4:0] if_id_rs, if_id_rt, id_ex_rd, ex_mem_rd,
input ex_mem_regwrite, id_ex_regwrite,
output reg fa, fb
);
    always@(*)  //for fb
    begin
        if((id_ex_rd == if_id_rt) && (id_ex_rd != 0) && (id_ex_regwrite == 1))
            fb = 1'b1;
        else if((ex_mem_rd == if_id_rt) && (ex_mem_rd != 0) && (ex_mem_regwrite == 1))
            fb = 1'b1;
            
        else
            fb = 1'b0;
    end
    
    always@(*) //for fa
    begin
        if((id_ex_rd == if_id_rs) && (id_ex_rd != 0) && (id_ex_regwrite == 1))
            fa = 1'b1;
        else if((ex_mem_rd == if_id_rs) && (ex_mem_rd != 0) && (ex_mem_regwrite == 1))
            fa = 1'b1;
        else
            fa = 1'b0;
    end
endmodule