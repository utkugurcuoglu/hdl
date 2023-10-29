module ALU ( 
  input [2:0] Op_code,
  input [31:0] A, B,
  output reg [31:0] Y
);

always @(A or B or Op_code) begin
  case (Op_code)
    3'b000: Y = A;         // A
    3'b001: Y = A + B;     // Add
    3'b010: Y = A - B;     // Subtract
    3'b011: Y = A & B;     // AND
    3'b100: Y = A | B;     // OR
    3'b101: Y = A + 1;     // Increment A
    3'b110: Y = A - 1;     // Decrement A
    3'b111: Y = B;         // B
    default: Y = 32'h00000000;    // Default behavior (optional)
  endcase
end

endmodule

