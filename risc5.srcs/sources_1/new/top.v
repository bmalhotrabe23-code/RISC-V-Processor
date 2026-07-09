`timescale 1ns / 1ps

module top(
    input wire clk,
    input wire reset
);

    // ALU
    wire [2:0] ALUcontroltop;
    wire [31:0] srcA, srcB;
    wire [31:0] AluresultTop;
    wire zeroTop, signTop;

    alu alu(
        .A(srcA),
        .B(srcB),
        .ALUControl_in(ALUcontroltop),
        .ALU_result(AluresultTop),
        .zero(zeroTop),
        .sign(signTop)
    );

    // Program Counter
    wire [31:0] pc_next;
    wire [31:0] pc;

    PC PC(
        .clk(clk),
        .reset(reset),
        .load(1'b1),
        .PC_next(pc_next),
        .PC(pc)
    );

    // Instruction Memory
    wire [31:0] Instr;
    instruction_memory instruction_memory(
        .A(pc),
        .RD(Instr)
    );

    // Sign Extender
    wire [31:0] ImmExt;
    wire [1:0] ImmSrc;

    sign_extender sign_extender(
        .instruction(Instr),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );

    // Register File 
    wire [4:0] Rs1, Rs2, Rd;
    assign Rs1 = Instr[19:15];
    assign Rs2 = Instr[24:20];
    assign Rd  = Instr[11:7];
    wire [31:0] read_data2top;
    wire [31:0] Result;
    wire RegWriteTop, ALUSrc;

    register_file register_file (
        .clk(clk),
        .reset(reset),
        .A1(Rs1),
        .A2(Rs2),
        .A3(Rd),
        .WD3(Result),
        .WE3(RegWriteTop),
        .RD1(srcA),
        .RD2(read_data2top)
    );

    // MUX for ALU input B
    wire [31:0] SrcB;
    mux2to1 alumux(
        .in0(read_data2top),
        .in1(ImmExt),
        .sel(ALUSrc),
        .out(SrcB)
    );

    // Control Unit
    wire PCSrc, Branch;
    wire memwrite, ResultSrc;
    wire [31:0] pcplus4;
    wire [31:0] pctarget;

    control_unit cu(
        .Opcode(Instr[6:0]),
        .funct3(Instr[14:12]),
        .funct7(Instr[30]),
        .RegWrite(RegWriteTop),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(memwrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .ALUControl(ALUcontroltop)
    );

    wire [2:0] funct3 = Instr[14:12];

    assign PCSrc = Branch && (
        (funct3 == 3'b000 && zeroTop == 1'b1) || // beq
        (funct3 == 3'b001 && zeroTop == 1'b0) || // bne
        (funct3 == 3'b100 && signTop == 1'b1)    // blt
    );

    mux2to1 PC_MUX(
        .in0(pcplus4),
        .in1(pctarget),
        .sel(PCSrc),
        .out(pc_next)
    );

    pc_plus_4 pc_plus_4(
        .current_pc(pc),
        .next_pc(pcplus4)
    );

    // PC Target
    PCtarget PCtarget(
        .PC_current(pc),
        .ImmExtt(ImmExt),
        .PCtarget(pctarget)
    );

    // Data Memory
    wire [31:0] ReadData;

    data_memory DATAMEMORY(
        .clk(clk),
        .MWE(memwrite),
        .MA(AluresultTop),
        .MWD(read_data2top),
        .MRD(ReadData)
    );

    mux2to1 DATA_MUX(
        .in0(AluresultTop),
        .in1(ReadData),
        .sel(ResultSrc),
        .out(Result)
    );

endmodule
