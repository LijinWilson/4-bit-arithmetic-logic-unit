`timescale 1ns / 1ps

module alu4bit_tb;

reg [3:0] a, b;
reg [2:0] sel;
wire [3:0] result;
wire carry, zero;

// Instantiate ALU
alu4bit uut (
    .a(a),
    .b(b),
    .sel(sel),
    .result(result),
    .carry(carry),
    .zero(zero)
);

initial begin
    $monitor("Time=%0t | sel=%b | a=%b | b=%b | result=%b | carry=%b | zero=%b",
             $time, sel, a, b, result, carry, zero);

    // Test Addition
    a = 4'b0011; b = 4'b0101; sel = 3'b000; #10; // 3 + 5 = 8

    // Test Subtraction
    a = 4'b1000; b = 4'b0010; sel = 3'b001; #10; // 8 - 2 = 6

    a = 4'b0010; b = 4'b0100; sel = 3'b001; #10; // 2 - 4 = borrow

    // Test AND
    a = 4'b1100; b = 4'b1010; sel = 3'b010; #10; // 1100 & 1010 = 1000

    // Test OR
    a = 4'b1100; b = 4'b1010; sel = 3'b011; #10; // 1100 | 1010 = 1110

    // Test XOR
    a = 4'b1100; b = 4'b1010; sel = 3'b100; #10; // 1100 ^ 1010 = 0110

    // Test NOT
    a = 4'b1100; b = 4'b0000; sel = 3'b101; #10; // ~1100 = 0011

    // Test Transfer b
    a = 4'b0000; b = 4'b1111; sel = 3'b110; #10; // result = b = 1111

    // Test Transfer a
    a = 4'b1010; b = 4'b0000; sel = 3'b111; #10; // result = a = 1010

    $finish;
end

initial
    begin
        $display("selection = %d result = %d", sel, result);
    end

endmodule
