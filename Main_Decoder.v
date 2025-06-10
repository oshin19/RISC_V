module main_decoder(
input [6:0] op,
output  branch,
output  resultSrc,
output  aluSrc,
output regwrite,
output  [1:0] immSrc,
output memwrite,
output [1:0] aluop
);

localparam lw= 7'b0000011;
localparam sw= 7'b0100011;
localparam r_type= 7'b0110011;
localparam beq= 7'b1100011;
localparam addi= 7'b0010011;

assign regwrite = (op==lw) || (op==addi) || (op==r_type);
assign aluSrc   = (op==lw) || (op==sw) || (op==addi) ;
assign memwrite = (op==sw);
assign branch   = (op==beq);
assign resultSrc= (op==lw);

assign immSrc= (op==lw)? 2'b00 :
               (op==sw)? 2'b01 :
               (op==beq)? 2'b10: 2'b00;
               
assign aluop= (op==lw || op==sw) ? 2'b00:
              (op==r_type) ? 2'b10:
              (op==beq) ? 2'b01 : 2'b00;
              
endmodule
