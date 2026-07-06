`timescale 1ns / 1ps
module alu #(
    parameter WIDTH = 32
)(
    input  [WIDTH-1:0] A,
    input  [WIDTH-1:0] B,
    input  [3:0] ALU_Sel,
    output reg [WIDTH-1:0] Result,
    output Zero,
    output Carry,
    output Overflow,
    output Negative
);

reg carry_r;

// Overflow helper wires
wire overflow_add;
wire overflow_sub;

always @(*) begin
    Result  = {WIDTH{1'b0}};
    carry_r = 1'b0;

    case (ALU_Sel)
        4'b0000: begin // ADD
            {carry_r, Result} = A + B;
        end

        4'b0001: begin // SUB
            {carry_r, Result} = A - B;
        end

        4'b0010: begin // MUL
            Result = A * B;
        end

        4'b0011: begin // DIV
            if (B != 0)
                Result = A / B;
            else
                Result = {WIDTH{1'b1}};
        end

        4'b0100: Result = A & B;                        // AND
        4'b0101: Result = A | B;                        // OR
        4'b0110: Result = A ^ B;                        // XOR
        4'b0111: Result = ~A;                           // NOT
        4'b1000: Result = A << B[4:0];                  // LSL
        4'b1001: Result = A >> B[4:0];                  // LSR
        4'b1010: Result = $signed(A) >>> B[4:0];        // ASR
        4'b1011: Result = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0; // SLT
        4'b1100: Result = ~(A & B);                     // NAND
        4'b1101: Result = ~(A | B);                     // NOR
        4'b1110: Result = ~(A ^ B);                     // XNOR
        4'b1111: Result = A;                            // PASS A
        default: Result = {WIDTH{1'b0}};
    endcase
end

assign Zero     = (Result == {WIDTH{1'b0}});
assign Carry    = carry_r;
assign Negative = Result[WIDTH-1];

assign overflow_add =
    (ALU_Sel == 4'b0000) &&
    (A[WIDTH-1] == B[WIDTH-1]) &&
    (Result[WIDTH-1] != A[WIDTH-1]);

assign overflow_sub =
    (ALU_Sel == 4'b0001) &&
    (A[WIDTH-1] != B[WIDTH-1]) &&
    (Result[WIDTH-1] != A[WIDTH-1]);

assign Overflow = overflow_add | overflow_sub;

endmodule
