`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2025 01:52:32 PM
// Design Name: 
// Module Name: program_counter
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


module PC (
    input wire clk,
    input wire reset,         // asynchronous, active high
    input wire load,          // enable writing to PC
    input wire [31:0] PC_next,
    output reg [31:0] PC
);
always @(posedge clk or negedge reset) begin
    if (~reset)
        PC <= 32'b0;          // reset PC to 0
    else if (load)
        PC <= PC_next;        // update PC only when load is high
end
endmodule 
