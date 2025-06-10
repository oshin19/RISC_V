module pc(
input clk,
input rst,
input  [31:0] pcnext,
output  reg [31:0] pc
 );
 
 always @(posedge clk) begin
 if (rst) 
 pc<=32'd0;
 
 else
 pc<= pcnext;
 
 end
 
 
endmodule
