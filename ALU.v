module ALU (

input wire [31:0] a,
input wire [31:0] b,
input wire [2:0] alu_control,
output reg [31:0] result,
output wire zero,
output wire negative,
output reg carry,
output reg overflow,
output reg slt
 );
 
  localparam alu_add= 3'b000;
  localparam alu_sub= 3'b001;
  localparam alu_and= 3'b010;
  localparam alu_or = 3'b011;
  localparam alu_slt= 3'b101;
 
  wire [31:0] bin;
  wire [31:0] sum;
  wire cout;
  
  assign bin = (alu_control==alu_add) ? b : ~b;
  assign {cout,sum} = a + bin + (alu_control == alu_sub);
 
  
  assign zero = (result==0);
  assign negative =result[31];
  
  always @(*) begin
  
  result = 32'd0;
  carry = 0 ;
  overflow = 0 ;
  slt=0;
  
  case(alu_control) 
  
  alu_add: begin
  result=sum;
  carry=cout;
  overflow= (a[31] == b[31]) &&
             (a[31] != result[31]);
  end           
  
  alu_sub: begin
  result= sum;
  carry=cout;
  overflow= (a[31] != b[31]) &&
             (a[31] != result[31]);
  end
  
  alu_and: begin
  result = a&b;
  end
  
  alu_or: begin
  result = a|b;
  end
  
  alu_slt:begin
  slt=( $signed(a) < $signed(b));
  result={31'd0,slt};
  end
  
  endcase
  end
                      
  