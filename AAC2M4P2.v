module RAM128x32 
#(
  parameter Data_width = 32,  //# of bits in word
            Addr_width = 7  // # of address bits
  )
  (  //ports
    input wire clk,
    input wire we,
    input wire [(Addr_width-1):0] address, 
    input wire [(Data_width-1):0] d,
    output wire [(Data_width-1):0] q
  );

    reg [Data_width-1:0] memory [0:127]; // 128x32 RAM

    always @(posedge clk) begin
        if (we) begin
            // Write operation: Store data into the specified address
            memory[address] <= d;
        end
    end

    assign q = memory[address]; // Read operation: Output data from the specified address

endmodule