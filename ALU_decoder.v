module alu_decoder(
input [1:0] aluop,
input [2:0] funct3,
input [6:0]funct7,
output [2:0]alu_control
);

assign alu_control= (aluop==2'b00) ? 3'b000 :
                    (aluop==2'b01) ? 3'b001 :
                    (aluop==2'b10) & (funct3==3'b000) & (funct7[5]==0) ? 3'b000 :
                    (aluop==2'b10) & (funct3==3'b000) & (funct7[5]==1) ? 3'b001 :
                    (aluop==2'b10) & (funct3==3'b010) ? 3'b101:
                    (aluop==2'b10) & (funct3==3'b110) ? 3'b011:
                    (aluop==2'b10) & (funct3==3'b111) ? 3'b010 : 3'b000;
                    

endmodule
