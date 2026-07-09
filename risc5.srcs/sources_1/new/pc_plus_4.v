`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2025 11:01:52 AM
// Design Name: 
// Module Name: pc_plus_4
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


module pc_plus_4(
input wire [31:0]current_pc,
output wire [31:0]next_pc);

assign next_pc=current_pc+32'd4;
endmodule
