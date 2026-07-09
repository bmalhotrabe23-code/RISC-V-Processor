`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2025 10:06:44 AM
// Design Name: 
// Module Name: alu_tb
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


`timescale 1ns / 1ps

module alu_tb;

    // Inputs
    reg [31:0] A, B;
    reg [2:0] ALUControl_in;

    // Outputs
    wire [31:0] ALU_result;
    wire zero, sign;

    // Instantiate the ALU
    alu uut (
        .A(A),
        .B(B),
        .ALUControl_in(ALUControl_in),
        .ALU_result(ALU_result),
        .zero(zero),
        .sign(sign)
    );

    // Task for displaying results
    task display_result;
        begin
            $display("Time=%0t | ALUControl=%b | A=%h | B=%h | Result=%h | Zero=%b | Sign=%b",
                     $time, ALUControl_in, A, B, ALU_result, zero, sign);
        end
    endtask

    initial begin
        $display("Starting ALU testbench...");

        // Test 1: A + B
        A = 32'd10; B = 32'd5; ALUControl_in = 3'b000;
        #10 display_result;

        // Test 2: A << B (Shift Left)
        A = 32'h00000001; B = 32'd4; ALUControl_in = 3'b001;
        #10 display_result;

        // Test 3: A - B
        A = 32'd10; B = 32'd10; ALUControl_in = 3'b010;
        #10 display_result;

        // Test 4: A ^ B
        A = 32'hF0F0F0F0; B = 32'h0F0F0F0F; ALUControl_in = 3'b100;
        #10 display_result;

        // Test 5: A >> B (Logical Right Shift)
        A = 32'h80000000; B = 32'd1; ALUControl_in = 3'b101;
        #10 display_result;

        // Test 6: A | B
        A = 32'h0000FF00; B = 32'h00FF0000; ALUControl_in = 3'b110;
        #10 display_result;

        // Test 7: A & B
        A = 32'hFF00FF00; B = 32'h0F0F0F0F; ALUControl_in = 3'b111;
        #10 display_result;

        // Test 8: Default case
        A = 32'd123; B = 32'd456; ALUControl_in = 3'b011;
        #10 display_result;

        $display("Testbench completed.");
        $finish;
    end

endmodule
