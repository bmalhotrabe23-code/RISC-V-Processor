`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2025 11:10:01 AM
// Design Name: 
// Module Name: pc_target
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


module PCtarget(
input wire [31:0]PC_current,
input wire [31:0]ImmExtt,
output wire [31:0]PCtarget
    );
    assign PCtarget=PC_current+ImmExtt;
endmodule
