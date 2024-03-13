module hdu(
input [4:0] id_ex_rt, if_id_rs, if_id_rt,
input id_ex_memread,
output reg pcwrite, if_id_write, hu_sel
);
always@(*)
begin
    if((id_ex_memread) && ((id_ex_rt == if_id_rs) || (id_ex_rt == if_id_rt)))
    begin
        pcwrite = 0;
        if_id_write = 0;
        hu_sel = 1;
    end
    else
    begin
        pcwrite = 1;
        if_id_write = 1;
        hu_sel = 0;
    end
end
endmodule