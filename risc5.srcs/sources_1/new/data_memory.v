`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/10/2025 11:31:39 AM
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    input wire clk,
    input  wire MWE,
    input wire [31:0]MA,
    input wire [31:0]MWD,
    output wire [31:0]MRD );
    
 reg [31:0] ram [63:0];

 assign MRD=ram[MA[31:2]];

 always @(posedge clk) begin
     if(MWE)
        ram[MA[31:2]]<=MWD;
 end
endmodule
