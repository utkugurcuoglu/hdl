module LS161a(
    input [3:0] D,        // Parallel Input
    input CLK,            // Clock
    input CLR_n,          // Active Low Asynchronous Reset
    input LOAD_n,         // Enable Parallel Input
    input ENP,            // Count Enable Parallel
    input ENT,            // Count Enable Trickle
    output [3:0]Q,        // Parallel Output 	
    output RCO            // Ripple Carry Output (Terminal Count)
); 

    reg [3:0] count; // 4-bit counter

    assign Q = count;
    assign RCO = (count == 4'b1111); // Terminal count output

    always @(posedge CLK or negedge CLR_n) begin
        if (!CLR_n) begin
            count <= 4'b0000; // Reset the counter on active low CLR
        end else if (LOAD_n == 0) begin
            count <= D; // Load parallel input if LOAD_n is active low
        end else if (ENP && ENT) begin
            count <= count + 1; // Increment the counter when both enable signals are active
        end
    end

endmodule
