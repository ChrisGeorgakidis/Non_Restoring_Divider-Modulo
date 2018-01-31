module Divider_Modulo (clk , reset, mode, valid_in, divisor, dividend, result, valid_out);
input wire clk, reset, mode,valid_in;
input wire [31:0]dividend;
input wire [15:0]divisor;
output reg valid_out;
output wire [31:0]result;

wire [15:0]temp_remainder[2:0];
wire [15:0]reg_remainder_w;
wire [15:0]remainder_w;
reg [15:0]reg_remainder;

wire [31:0]quotient_out_w;

reg [31:0]quotient_out;
reg [31:0]remainder;

assign result = (mode) ? quotient_out : remainder;

Divider_row Divider_row_16 (
	.divisor	(divisor),
	.dividend	(dividend[31:16]),
	.quotient	(1'b1),
	.q_out		(quotient_out_w[16]),
	.remainder	(temp_remainder[2])
);

Divider_row Divider_row_15 (
	.divisor	(divisor),
	.dividend	({temp_remainder[2][14:0], dividend[15]}),
	.quotient	(~temp_remainder[2][15]),
	.q_out		(quotient_out_w[15]),
	.remainder	(temp_remainder[1])
);

Divider_row Divider_row_14 (
	.divisor	(divisor),
	.dividend	({temp_remainder[1][14:0], dividend[14]}),
	.quotient	(~temp_remainder[1][15]),
	.q_out		(quotient_out_w[14]),
	.remainder	(temp_remainder[0])
);

Divider_row Divider_row_13 (
	.divisor	(divisor),
	.dividend	({temp_remainder[0][14:0], dividend[13]}),
	.quotient	(~temp_remainder[0][15]),
	.q_out		(quotient_out_w[13]),
	.remainder	(reg_remainder_w)
);

Divider_row Divider_row_12 (
	.divisor	(divisor),
	.dividend	({reg_remainder[14:0], dividend[12]}),
	.quotient	(~reg_remainder[15]),
	.q_out		(quotient_out_w[12]),
	.remainder	(temp_remainder[2])
);

Divider_row Divider_row_11 (
	.divisor	(divisor),
	.dividend	({temp_remainder[2][14:0], dividend[11]}),
	.quotient	(~temp_remainder[2][15]),
	.q_out		(quotient_out_w[11]),
	.remainder	(temp_remainder[1])
);

Divider_row Divider_row_10 (
	.divisor	(divisor),
	.dividend	({temp_remainder[1][14:0], dividend[10]}),
	.quotient	(~temp_remainder[1][15]),
	.q_out		(quotient_out_w[10]),
	.remainder	(temp_remainder[0])
);

Divider_row Divider_row_9 (
	.divisor	(divisor),
	.dividend	({temp_remainder[0][14:0], dividend[9]}),
	.quotient	(~temp_remainder[0][15]),
	.q_out		(quotient_out_w[9]),
	.remainder	(reg_remainder_w)
);

Divider_row Divider_row_8 (
	.divisor	(divisor),
	.dividend	({reg_remainder[14:0], dividend[8]}),
	.quotient	(~reg_remainder[15]),
	.q_out		(quotient_out_w[8]),
	.remainder	(temp_remainder[2])
);

Divider_row Divider_row_7 (
	.divisor	(divisor),
	.dividend	({temp_remainder[2][14:0], dividend[7]}),
	.quotient	(~temp_remainder[2][15]),
	.q_out		(quotient_out_w[7]),
	.remainder	(temp_remainder[1])
);

Divider_row Divider_row_6 (
	.divisor	(divisor),
	.dividend	({temp_remainder[1][14:0], dividend[6]}),
	.q_out		(quotient_out_w[6]),
	.quotient	(~temp_remainder[1][15]),
	.remainder	(temp_remainder[0])
);

Divider_row Divider_row_5 (
	.divisor	(divisor),
	.dividend	({temp_remainder[0][14:0], dividend[5]}),
	.quotient	(~temp_remainder[0][15]),
	.q_out		(quotient_out_w[5]),
	.remainder	(reg_remainder_w)
);

Divider_row Divider_row_4 (
	.divisor	(divisor),
	.dividend	({reg_remainder[14:0], dividend[4]}),
	.quotient	(~reg_remainder[15]),
	.q_out		(quotient_out_w[4]),
	.remainder	(temp_remainder[2])
);

Divider_row Divider_row_3 (
	.divisor	(divisor),
	.dividend	({temp_remainder[2][14:0], dividend[3]}),
	.quotient	(~temp_remainder[2][15]),
	.q_out		(quotient_out_w[3]),
	.remainder	(temp_remainder[1])
);

Divider_row Divider_row_2 (
	.divisor	(divisor),
	.dividend	({temp_remainder[1][14:0], dividend[2]}),
	.quotient	(~temp_remainder[1][15]),
	.q_out		(quotient_out_w[2]),
	.remainder	(temp_remainder[0])
);

Divider_row Divider_row_1 (
	.divisor	(divisor),
	.dividend	({temp_remainder[0][14:0], dividend[1]}),
	.quotient	(~temp_remainder[0][15]),
	.q_out		(quotient_out_w[1]),
	.remainder	(reg_remainder_w)
);

Divider_row Divider_row_0 (
	.divisor	(divisor),
	.dividend	({reg_remainder[14:0], dividend[0]}),
	.quotient	(~reg_remainder[15]),
	.q_out		(quotient_out_w[0]),
	.remainder	(remainder_w)
);

always @ ( posedge clk or posedge reset ) begin
	if (reset == 1'b1) begin
		reg_remainder <= 0;
		quotient_out <= 0;
		remainder <= 0;
	end
	else begin
		reg_remainder <= reg_remainder_w;
		quotient_out <= quotient_out_w;
		remainder <= remainder_w;
	end
end


endmodule
