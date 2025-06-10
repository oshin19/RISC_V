module imm_gen(
input [31:0] inst,
input [1:0] immSrc,
output reg [31:0] imm_ext
 );
 
 always @(*) begin
 case(immSrc)
  
 2'b00: imm_ext = { {20{inst[31]}} , inst[31:20]} ;
 2'b01: imm_ext = { {20{inst[31]}} , inst[31:25] , inst[11:7] } ;
 2'b10: imm_ext = { {19{inst[31]}} , inst[31] , inst[7] , inst[30:25] , inst[11:8] , 1'b0 } ;
 
 endcase
 end
 
endmodule
