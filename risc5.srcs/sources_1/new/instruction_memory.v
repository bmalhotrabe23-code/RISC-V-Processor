`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2025 11:29:22 AM
// Design Name: 
// Module Name: instruction_memory
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

module instruction_memory(
    input wire [31:0] A,
    output wire [31:0] RD
);

    reg [31:0] memory [63:0];

    assign RD = memory[A[31:2]];

    initial begin
        $readmemh("/home/user/Desktop/risc5/risc5.srcs/sources_1/new/program.mem", memory);
    end

endmodule
