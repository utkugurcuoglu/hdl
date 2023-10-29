module FIFO8x9(
  input clk, rst,
  input RdPtrClr, WrPtrClr, 
  input RdInc, WrInc,
  input [8:0] DataIn,
  output reg [8:0] DataOut,
  input rden, wren
	);
  //signal declarations
  reg [8:0] fifo_array[7:0];
  reg [7:0] wrptr, rdptr;
  wire [7:0] wr_cnt, rd_cnt;

  always @(posedge clk) begin
    if (rst) begin
      // Reset on active low reset signal
      wrptr <= 8'b0000;
      rdptr <= 8'b0000;
    end else if (WrPtrClr) begin
      // Clear write pointer
      wrptr <= 8'b0000;
    end else if (WrInc && wren) begin
      // Increment write pointer when write is enabled
      wrptr <= wrptr + 1;
    end else if (RdPtrClr) begin
      // Clear read pointer
      rdptr <= 8'b0000;
    end else if (RdInc && rden) begin
      // Increment read pointer when read is enabled
      rdptr <= rdptr + 1;
    end

    if (wren) begin
      // Write data to FIFO when write is enabled
      fifo_array[wrptr] <= DataIn;
    end

    // Output data based on read pointer
    DataOut <= (rden) ? fifo_array[rdptr] : 9'bZZZZZZZZZ;
  end
endmodule

