module Divider_tb ();

reg clk, reset, valid_in, mode;
reg [15:0]divisor;
reg [31:0]dividend;
wire valid_out;
wire [31:0]result;

Divider_Modulo Divider_Modulo(
    .clk        (clk),
    .reset      (reset),
	.mode       (mode),
    .valid_in   (valid_in),
    .divisor    (divisor),
    .dividend   (dividend),
	.result     (result),
	.valid_out  (valid_out)//
);



initial begin
    clk         <= 1'b1;
    reset       <= 1'b1;
    mode        <= 1'b0;
	valid_in	<= 1'b0;
    divisor     <= 16'b0110_0011_0000_0011;
    dividend    <= 32'b0010_0000_0000_0100_0000_0000_1100_0000;
	#5valid_in  <= 1'b1;
    #50 reset   <= 1'b0;
	#10valid_in	<= 1'b0;
end

always begin
    #5clk <= ~clk;
end

endmodule
