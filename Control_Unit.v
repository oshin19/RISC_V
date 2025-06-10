`include "alu_decoder.v"
`include "main_decoder.v"


module control_unit(
    input [6:0] op,funct7,
    input [2:0]funct3,
    output regwrite,aluSrc,memwrite,resultSrc,branch,
    output [1:0]immSrc,
    output [2:0]alu_control
 );


    
    wire [1:0]aluop;

    main_decoder main_decoder(
                .op(op),
                .regwrite(regwrite),
                .immsrc(immsrc),
                .memwrite(memwrite),
                .resultSrc(resultSrc),
                .Branch(Branch),
                .aluSrc(aluSrc),
                .aluop(aluop)
    );

    alu_decoder alu_decoder(
                            .aluop(aluop),
                            .funct3(funct3),
                            .funct7(funct7),
                            .alu_control(alu_control)
    );


endmodule

