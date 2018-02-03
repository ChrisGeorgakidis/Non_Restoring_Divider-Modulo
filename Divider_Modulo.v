module Divider_Modulo (clk , reset, mode, valid_in, divisor, dividend, result, valid_out);
input wire clk, reset, mode,valid_in;
input wire [31:0]dividend;
input wire [15:0]divisor;
output reg valid_out;
output wire [31:0]result;

reg [4:0]clk_counter;
reg [0:0]v_out_p[3:0];
reg [0:0]mode_p[4:0];

reg [31:0]dividend_p[4:0];	//pipelined dividend
reg [15:0]divisor_p[4:0];	//pipelined divisor

wire [15:0]temp_remainder[11:0];	//remainder between rows

reg  [15:0]remainder_p[3:0];	//pipelined remainder between 4 rows
wire [15:0]remainder_p_w[3:0];	//wire to assign to remainder_p

wire [15:0]remainder_final;		//remainder of last line
wire [15:0]remainder_out;		//remainder going to output

reg  [16:0]quotient_p[3:0];	//pipelined quotient
wire [16:0]quotient_w;			//wire to assign to quotient_p
wire [16:0]quotient_out;		//quotient going to output


assign quotient_out = {quotient_p[3][16:1], quotient_w[0]};

assign remainder_out = (remainder_final[15] == 1) ? divisor_p[4] + remainder_final : remainder_final;

assign result = (mode_p[4] == 0) ?  quotient_out : remainder_out;

Divider_row Divider_row_16 (
	.divisor	(divisor_p[0]),
	.dividend	(dividend_p[0][31:16]),
	.quotient	(1'b1),
	.q_out		(quotient_w[16]),
	.remainder	(temp_remainder[11])
);

Divider_row Divider_row_15 (
	.divisor	(divisor_p[0]),
	.dividend	({temp_remainder[11][14:0], dividend_p[0][15]}),
	.quotient	(~temp_remainder[11][15]),
	.q_out		(quotient_w[15]),
	.remainder	(temp_remainder[10])
);

Divider_row Divider_row_14 (
	.divisor	(divisor_p[0]),
	.dividend	({temp_remainder[10][14:0], dividend_p[0][14]}),
	.quotient	(~temp_remainder[10][15]),
	.q_out		(quotient_w[14]),
	.remainder	(temp_remainder[9])
);

Divider_row Divider_row_13 (
	.divisor	(divisor_p[0]),
	.dividend	({temp_remainder[9][14:0], dividend_p[0][13]}),
	.quotient	(~temp_remainder[9][15]),
	.q_out		(quotient_w[13]),
	.remainder	(remainder_p_w[3])
);
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
Divider_row Divider_row_12 (
	.divisor	(divisor_p[1]),
	.dividend	({remainder_p[3][14:0], dividend_p[1][12]}),
	.quotient	(~remainder_p[3][15]),
	.q_out		(quotient_w[12]),
	.remainder	(temp_remainder[8])
);

Divider_row Divider_row_11 (
	.divisor	(divisor_p[1]),
	.dividend	({temp_remainder[8][14:0], dividend_p[1][11]}),
	.quotient	(~temp_remainder[8][15]),
	.q_out		(quotient_w[11]),
	.remainder	(temp_remainder[7])
);

Divider_row Divider_row_10 (
	.divisor	(divisor_p[1]),
	.dividend	({temp_remainder[7][14:0], dividend_p[1][10]}),
	.quotient	(~temp_remainder[7][15]),
	.q_out		(quotient_w[10]),
	.remainder	(temp_remainder[6])
);

Divider_row Divider_row_9 (
	.divisor	(divisor_p[1]),
	.dividend	({temp_remainder[6][14:0], dividend_p[1][9]}),
	.quotient	(~temp_remainder[6][15]),
	.q_out		(quotient_w[9]),
	.remainder	(remainder_p_w[2])
);
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
Divider_row Divider_row_8 (
	.divisor	(divisor_p[2]),
	.dividend	({remainder_p[2][14:0], dividend_p[2][8]}),
	.quotient	(~remainder_p[2][15]),
	.q_out		(quotient_w[8]),
	.remainder	(temp_remainder[5])
);

Divider_row Divider_row_7 (
	.divisor	(divisor_p[2]),
	.dividend	({temp_remainder[5][14:0], dividend_p[2][7]}),
	.quotient	(~temp_remainder[5][15]),
	.q_out		(quotient_w[7]),
	.remainder	(temp_remainder[4])
);

Divider_row Divider_row_6 (
	.divisor	(divisor_p[2]),
	.dividend	({temp_remainder[4][14:0], dividend_p[2][6]}),
	.quotient	(~temp_remainder[4][15]),
	.q_out		(quotient_w[6]),
	.remainder	(temp_remainder[3])
);

Divider_row Divider_row_5 (
	.divisor	(divisor_p[2]),
	.dividend	({temp_remainder[3][14:0], dividend_p[2][5]}),
	.quotient	(~temp_remainder[3][15]),
	.q_out		(quotient_w[5]),
	.remainder	(remainder_p_w[1])
);
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
Divider_row Divider_row_4 (
	.divisor	(divisor_p[3]),
	.dividend	({remainder_p[1][14:0], dividend_p[3][4]}),
	.quotient	(~remainder_p[1][15]),
	.q_out		(quotient_w[4]),
	.remainder	(temp_remainder[2])
);

Divider_row Divider_row_3 (
	.divisor	(divisor_p[3]),
	.dividend	({temp_remainder[2][14:0], dividend_p[3][3]}),
	.quotient	(~temp_remainder[2][15]),
	.q_out		(quotient_w[3]),
	.remainder	(temp_remainder[1])
);

Divider_row Divider_row_2 (
	.divisor	(divisor_p[3]),
	.dividend	({temp_remainder[1][14:0], dividend_p[3][2]}),
	.quotient	(~temp_remainder[1][15]),
	.q_out		(quotient_w[2]),
	.remainder	(temp_remainder[0])
);

Divider_row Divider_row_1 (
	.divisor	(divisor_p[3]),
	.dividend	({temp_remainder[0][14:0], dividend_p[3][1]}),
	.quotient	(~temp_remainder[0][15]),
	.q_out		(quotient_w[1]),
	.remainder	(remainder_p_w[0])
);
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
Divider_row Divider_row_0 (
	.divisor	(divisor_p[4]),
	.dividend	({remainder_p[0][14:0], dividend_p[4][0]}),
	.quotient	(~remainder_p[0][15]),
	.q_out		(quotient_w[0]),
	.remainder	(remainder_final)
);

always @ ( posedge clk or posedge reset ) begin
	if (reset == 1'b1) begin
		clk_counter <= 5'b0;

		v_out_p[0]				<= 1'b0;
		v_out_p[1]				<= 1'b0;
		v_out_p[2]				<= 1'b0;
		v_out_p[3]				<= 1'b0;
		valid_out				<= 1'b0;
		dividend_p[0]			<= 32'b0;
		dividend_p[1]			<= 32'b0;
		dividend_p[2]			<= 32'b0;
		dividend_p[3]			<= 32'b0;
		dividend_p[4]			<= 32'b0;
		divisor_p[0]			<= 16'b0;
		divisor_p[1]			<= 16'b0;
		divisor_p[2]			<= 16'b0;
		divisor_p[3]			<= 16'b0;
		divisor_p[4]			<= 16'b0;
		remainder_p[0]			<= 16'b0;
		remainder_p[1]			<= 16'b0;
		remainder_p[2]			<= 16'b0;
		remainder_p[3]			<= 16'b0;
		mode_p[0]				<= 1'b0;
		mode_p[1]				<= 1'b0;
		mode_p[2]				<= 1'b0;
		mode_p[3]				<= 1'b0;
		quotient_p[0]			<= 17'b0;
		quotient_p[1]			<= 17'b0;
		quotient_p[2]			<= 17'b0;
		quotient_p[3]			<= 17'b0;
	end
	else begin
		clk_counter <= clk_counter + 5'd1;

		v_out_p[0]				<= valid_in;
		v_out_p[1]				<= v_out_p[0];
		v_out_p[2]				<= v_out_p[1];
		v_out_p[3]				<= v_out_p[2];
		valid_out				<= v_out_p[3];

		mode_p[0]				<= mode;
		mode_p[1]				<= mode_p[0];
		mode_p[2]				<= mode_p[1];
		mode_p[3]				<= mode_p[2];
		mode_p[4]				<= mode_p[3];

		dividend_p[0]			<= dividend;
		dividend_p[1]			<= dividend_p[0];
		dividend_p[2]			<= dividend_p[1];
		dividend_p[3]			<= dividend_p[2];
		dividend_p[4]			<= dividend_p[3];

		divisor_p[0]			<= divisor;
		divisor_p[1]			<= divisor_p[0];
		divisor_p[2]			<= divisor_p[1];
		divisor_p[3]			<= divisor_p[2];
		divisor_p[4]			<= divisor_p[3];

		remainder_p[0]			<= remainder_p_w[0];
		remainder_p[1]			<= remainder_p_w[1];
		remainder_p[2]			<= remainder_p_w[2];
		remainder_p[3]			<= remainder_p_w[3];

		quotient_p[0][16:13]	<= quotient_w[16:13];
		quotient_p[1][16:9]		<= {quotient_p[0][16:13], quotient_w[12:9]};
		quotient_p[2][16:5]		<= {quotient_p[1][16:9], quotient_w[8:5]};
		quotient_p[3][16:1]		<= {quotient_p[2][16:5], quotient_w[4:1]};
	end
end


endmodule
