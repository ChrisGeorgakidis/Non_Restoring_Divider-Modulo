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
    valid_in    <= 1'b0;
    #55 reset   <= 1'b0;

    // //Data 1
    mode        <= 1'b0;
	valid_in	<= 1'b1;
    divisor     <= 16'b0110_0011_0000_0011; //25347
    dividend    <= 32'b0010_0000_0000_0100_0000_0000_1100_0000; //537133248
    //quotient  = 21191 (0_0101_0010_1100_0111)
    //remainder = 4971  (0_0001_0011_0110_1011)

	#10 mode     <= 1'b1;
	valid_in	<= 1'b1;
    divisor     <= 16'b0110_0011_0110_0011; //25443
    dividend    <= 32'b0010_1001_0010_0100_1100_0100_1100_0011; //690275523
    //quotient  = 27130 (0_0110_1001_1111_1010)
    //remainder = 6933  (0_0001_1011_0001_0101)

	#100mode     <= 1'b1;
	valid_in	<= 1'b1;
    divisor     <= 16'd5;
    dividend    <= 32'd21;
    //quotient  = 4
    //remainder = 1

    #100 $finish;
end

always begin
    #5clk <= ~clk;
end

endmodule
