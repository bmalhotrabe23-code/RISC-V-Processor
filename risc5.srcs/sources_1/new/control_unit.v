`timescale 1ns / 1ps

module control_unit(
    input wire [6:0] Opcode,
    input wire [2:0] funct3,
    input wire       funct7, // should be just 1 bit, or [0] if using Instr[30]
    output reg       RegWrite,
    output reg [1:0] ImmSrc,
    output reg       ALUSrc,
    output reg       MemWrite,
    output reg       ResultSrc,
    output reg       Branch,
    output reg [2:0] ALUControl
);

    reg [1:0] ALUOp;

    always @(*) begin
        // Set defaults
        RegWrite   = 1'b0;
        ALUSrc     = 1'b0;
        ImmSrc     = 2'b00;
        MemWrite   = 1'b0;
        ResultSrc  = 1'b0;
        Branch     = 1'b0;
        ALUOp      = 2'b00;
        ALUControl = 3'b000;

        case (Opcode)
            7'b000_0011: begin // lw (load word)
                RegWrite   = 1'b1;
                ImmSrc     = 2'b00;
                ResultSrc  = 1'b1;
                ALUSrc     = 1'b1;
                MemWrite   = 1'b0;
                Branch     = 1'b0;
                ALUOp      = 2'b00;
            end
            7'b010_0011: begin // sw (store word)
                RegWrite   = 1'b0;
                ImmSrc     = 2'b01;
                ResultSrc  = 1'b0;
                ALUSrc     = 1'b1;
                MemWrite   = 1'b1;
                Branch     = 1'b0;
                ALUOp      = 2'b00;
            end
            7'b011_0011: begin // R-type (add, sub, etc.)
                RegWrite   = 1'b1;
                ImmSrc     = 2'b00;
                ResultSrc  = 1'b0;
                ALUSrc     = 1'b0;
                MemWrite   = 1'b0;
                Branch     = 1'b0;
                ALUOp      = 2'b10;
            end
            7'b110_0011: begin // branch (beq, bne, blt, etc.)
                RegWrite   = 1'b0;
                ImmSrc     = 2'b10;
                ResultSrc  = 1'b0;
                ALUSrc     = 1'b0;
                MemWrite   = 1'b0;
                Branch     = 1'b1;
                ALUOp      = 2'b01;
            end
            7'b001_0011: begin // I-type (addi, andi, etc.)
                RegWrite   = 1'b1;
                ImmSrc     = 2'b00;
                ResultSrc  = 1'b0;
                ALUSrc     = 1'b1;
                MemWrite   = 1'b0;
                Branch     = 1'b0;
                ALUOp      = 2'b00;
            end
            default: begin
                // already set to zero above
            end
        endcase

        // ALUControl logic
        case (ALUOp)
            2'b00: ALUControl = 3'b000; // add (for lw, sw, addi)
            2'b01: ALUControl = 3'b010; // sub (for branch: beq, bne, etc.)
            2'b10: begin                // R-type
                case (funct3)
                    3'b000: ALUControl = (funct7 ? 3'b010 : 3'b000); // sub : add
                    3'b001: ALUControl = 3'b001; // sll
                    3'b100: ALUControl = 3'b100; // xor
                    3'b101: ALUControl = 3'b101; // srl
                    3'b110: ALUControl = 3'b110; // or
                    3'b111: ALUControl = 3'b111; // and
                    default: ALUControl = 3'b000;
                endcase
            end
            default: ALUControl = 3'b000;
        endcase
    end
endmodule
