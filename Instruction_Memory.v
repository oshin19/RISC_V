module instruction_mem(
input wire [31:0] address,
output wire [31:0] read 
 );
 
 reg [31:0] memory [0:1023];
 
 assign read= memory[address[11:2]];

endmodule
