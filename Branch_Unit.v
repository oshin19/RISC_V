module branch_unit( 
input [31:0] rd1, rd2, 
input branch,
input [2:0] funct3,
output reg branch_taken
);

always @(*) begin
case(funct3)
        3'b000: branch_taken = branch & (rd1 == rd2);                  // BEQ
        3'b001: branch_taken = branch & (rd1 != rd2);                  // BNE
        3'b100: branch_taken = branch & ($signed(rd1) < $signed(rd2)); // BLT
        3'b101: branch_taken = branch & ($signed(rd1) >= $signed(rd2));// BGE
        3'b110: branch_taken = branch & (rd1 < rd2);                   // BLTU
        3'b111: branch_taken = branch & (rd1 >= rd2);                  // BGEU
        default: branch_taken = 0;
endcase
end

endmodule
