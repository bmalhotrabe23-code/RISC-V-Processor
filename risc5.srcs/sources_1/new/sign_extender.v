`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2025 11:28:39 AM
// Design Name: 
// Module Name: sign_extender
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


module sign_extender(
input wire [31:0] instruction,
input wire [1:0] ImmSrc,
output reg [31:0] ImmExt
    );

    always @(*) begin
        case (ImmSrc)
            2'b00:
            ImmExt={{20{instruction[31]}},instruction[31:20]};
            2'b01:
            ImmExt={{20{instruction[31]}},instruction[31:25],instruction[11:7]};
            2'b10:
            ImmExt={{19{instruction[31]}},instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0};
            default: ImmExt=32'b0;
        endcase
    end
endmodule
