`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2025 12:18:43 PM
// Design Name: 
// Module Name: register_file
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


module register_file(
    input wire clk,
    input wire reset,
    input wire [4:0] A1,A2,
    output wire [4:0] A3,//adress for writing
    input wire [31:0] WD3,
    input wire WE3,
    output wire [31:0] RD1,RD2);

    reg [31:0] registers [31:0];


    assign RD1=registers[A1];
    assign RD2=registers[A2];

    integer k;

    always @(posedge clk or negedge reset) begin
        if(~reset)
        for(k=0;k<31;k=k+1)begin
            registers[k]<=32'b0;
        end
        else if(WE3 && A3 !=5'd0)
            registers[A3]<=WD3;
    end
    

endmodule
