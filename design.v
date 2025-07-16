module alu4bit(
    input [3:0] a, b,
    input [2:0] sel, // select signal for operation
    output reg [3:0] result,
    output reg carry, zero
);

always @(*) begin
    case(sel)
        3'b000: {carry, result} = a + b;       // Addition
        3'b001: {carry, result} = a - b;       // Subtraction
        3'b010: result = a & b;                // Bitwise AND
        3'b011: result = a | b;                // Bitwise OR
        3'b100: result = a ^ b;                // Bitwise XOR
        3'b101: result = ~a;                   // Bitwise NOT on a
        3'b110: result = b;                    // Transfer b
        3'b111: result = a;                    // Transfer a
        default: result = 4'b0000;
    endcase

    // Carry output only valid for add/sub
    if(sel == 3'b000 || sel == 3'b001)
        carry = (sel == 3'b000) ? (a + b > 4'b1111) : (a < b);
    else
        carry = 0;

    // Zero flag
    zero = (result == 4'b0000) ? 1'b1 : 1'b0;
end

endmodule
