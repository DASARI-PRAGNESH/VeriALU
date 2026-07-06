`timescale 1ns / 1ps

module alu_tb;

parameter WIDTH = 32;

reg  [WIDTH-1:0] A;
reg  [WIDTH-1:0] B;
reg  [3:0] ALU_Sel;

wire [WIDTH-1:0] Result;
wire Zero;
wire Carry;
wire Overflow;
wire Negative;

integer total_tests = 0;
integer passed_tests = 0;
integer failed_tests = 0;

// DUT
alu #(WIDTH) DUT (
    .A(A),
    .B(B),
    .ALU_Sel(ALU_Sel),
    .Result(Result),
    .Zero(Zero),
    .Carry(Carry),
    .Overflow(Overflow),
    .Negative(Negative)
);

// Self-checking task
task test;
input [WIDTH-1:0] inA;
input [WIDTH-1:0] inB;
input [3:0] op;
input [WIDTH-1:0] exp_result;
input exp_zero;
input exp_carry;
input exp_overflow;
input exp_negative;
begin
    total_tests = total_tests + 1;

    A = inA;
    B = inB;
    ALU_Sel = op;

    #10;

    if ((Result===exp_result) &&
        (Zero===exp_zero) &&
        (Carry===exp_carry) &&
        (Overflow===exp_overflow) &&
        (Negative===exp_negative))
    begin
        passed_tests = passed_tests + 1;
        $display("------------------------------------------------");
        $display("TEST %0d : PASS", total_tests);
    end
    else
    begin
        failed_tests = failed_tests + 1;
        $display("------------------------------------------------");
        $display("TEST %0d : FAIL", total_tests);
        $display("A=%h B=%h OP=%b",A,B,ALU_Sel);
        $display("Expected Result=%h Actual=%h",exp_result,Result);
        $display("Expected Z=%b C=%b O=%b N=%b",
                  exp_zero,exp_carry,exp_overflow,exp_negative);
        $display("Actual   Z=%b C=%b O=%b N=%b",
                  Zero,Carry,Overflow,Negative);
    end
end
endtask

initial begin

// Basic directed tests
test(15,20,4'b0000,35,0,0,0,0);                  // ADD
test(50,15,4'b0001,35,0,0,0,0);                  // SUB
test(5,10,4'b0010,50,0,0,0,0);                   // MUL
test(40,8,4'b0011,5,0,0,0,0);                    // DIV
test(12,10,4'b0100,8,0,0,0,0);                   // AND
test(12,10,4'b0101,14,0,0,0,0);                  // OR
test(12,10,4'b0110,6,0,0,0,0);                   // XOR
test(12,0,4'b0111,32'hFFFFFFF3,0,0,0,1);         // NOT
test(5,2,4'b1000,20,0,0,0,0);                    // LSL
test(20,2,4'b1001,5,0,0,0,0);                    // LSR
test(32'hFFFFFFF0,2,4'b1010,32'hFFFFFFFC,0,0,0,1);// ASR
test(5,10,4'b1011,1,0,0,0,0);                    // SLT
test(12,10,4'b1100,32'hFFFFFFF7,0,0,0,1);        // NAND
test(12,10,4'b1101,32'hFFFFFFF1,0,0,0,1);        // NOR
test(12,10,4'b1110,32'hFFFFFFF9,0,0,0,1);        // XNOR
test(55,0,4'b1111,55,0,0,0,0);                   // PASS A

// Flag tests
test(10,10,4'b0001,0,1,0,0,0);                   // Zero
test(32'hFFFFFFFF,1,4'b0000,0,1,1,0,0);          // Carry
test(32'h7FFFFFFF,1,4'b0000,32'h80000000,0,0,1,1);// Overflow
test(5,10,4'b0001,32'hFFFFFFFB,0,1,0,1);         // Negative

$display("");
$display("=======================================");
$display("Simulation Summary");
$display("=======================================");
$display("Total Tests : %0d", total_tests);
$display("Passed      : %0d", passed_tests);
$display("Failed      : %0d", failed_tests);
$display("=======================================");

$finish;

end

endmodule
