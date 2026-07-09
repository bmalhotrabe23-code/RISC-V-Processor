`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2025 09:39:49 AM
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu(
input wire [31:0] A,B,
output reg [31:0] ALU_result,
output wire zero,sign,
input wire [2:0]  ALUControl_in );

always@(*)
 begin
 case(ALUControl_in)
 3'b000:ALU_result=A+B;
 3'b001:ALU_result=A<<B;
 3'b010:ALU_result=A-B;
 3'b100:ALU_result=A^B;
 3'b101:ALU_result=A>>B;
 3'b110:ALU_result=A|B;
 3'b111:ALU_result=A&B;
default : ALU_result=32'b0;
endcase
 end
 
assign zero=(ALU_result==32'b0);
assign sign=ALU_result[31];
endmodule
