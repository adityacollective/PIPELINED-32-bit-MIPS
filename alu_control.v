module alucontrol(
input [1:0] aluop,
input [5:0] funct,
output [3:0] alucontrol_w
);
reg [3:0] alucontrol;
assign alucontrol_w = alucontrol;
  always @(*)
  begin
    case(aluop)
      2'b00: alucontrol <= 4'b0010;//addition
      2'b01: alucontrol <= 4'b0110;//subtraction
      //4'b0100: alucontrol <= 4'b0000;//and
      //4'b0101: alucontrol <= 4'b0001;//or
      //4'b0111: alucontrol <= 4'b0111;//slt
      default: case(funct)//RTYPE
          6'b100000: alucontrol <= 4'b0010;//ADD
          6'b100010: alucontrol <= 4'b0110;//SUB
          6'b100100: alucontrol <= 4'b0000;//AND
          6'b100101: alucontrol <= 4'b0001;//OR
          6'b101010: alucontrol <= 4'b0111;//SLT
          default:   alucontrol <= 4'bxxxx;//???
        endcase
    endcase
  end
endmodule