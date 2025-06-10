module data_memory(
input clk,
input we,
input [31:0] a,
input [31:0] wd,
output [31:0] rd
    );
    
    reg [31:0] memory [0:1023];
    
    assign rd = memory[a[11:2]];
    
    always @(posedge clk) begin
    if(we)
    memory[a[11:2]]= wd;
    end
    
    
    
endmodule
