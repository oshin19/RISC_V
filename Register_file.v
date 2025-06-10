module register_file(
input clk,
input [4:0] a1,a2,a3,
input [31:0] wd3,
input we3,
output wire [31:0] rd1,rd2
 );
 
 reg [31:0] memory [0:31];
 
 assign rd1= (a1==0)? 32'd0:  memory[a1];
 assign rd2= (a2==0)? 32'd0:  memory[a2];
 
 always @(posedge clk) begin
 
 if(we3 && (a3!=0) )
 memory[a3]<=wd3;

 end
 
endmodule
