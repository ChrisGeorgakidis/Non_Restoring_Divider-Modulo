module Divider_Modulo (clk , reset, mode, valid_in, divisor, dividend, result, valid_out);
input wire clk, reset, mode,valid_in;
input wire [31:0]dividend;
input wire [15:0]divisor;
output reg valid_out;
output wire [31:0]result;

reg [4:0] counter;

reg [0:0]v_out[3:0];

reg [31:0]reg_dividend[4:0];
reg [15:0]reg_divisor[4:0];

wire [15:0]temp_remainder[11:0];

wire [15:0]reg_remainder_w[3:0];
reg  [15:0]reg_remainder[3:0];
reg  [0:0]reg_mode[4:0];

wire [16:0]quotient_out_w;
reg  [16:0]reg_quotient_out[3:0];
//reg  [16:0]reg_quotient_out[3:0];
reg  [16:0]quotient_out;

wire [15:0]remainder_w;
wire [15:0]remainder_out;
reg  [15:0]remainder;

wire [31:0]Q_out;

assign Q_out = {reg_quotient_out[3][16:1], quotient_out_w[0]};
assign remainder_out = (remainder_w[15] == 1) ? reg_divisor[4] + remainder_w : remainder_w;
assign result = (reg_mode[4] == 0) ? {reg_quotient_out[3][16:1], quotient_out_w[0]} : remainder_out;

Divider_row Divider_row_16 (
	.divisor	(reg_divisor[0]),
	.dividend	(reg_dividend[0][31:16]),
	.quotient	(1'b1),
	.q_out		(quotient_out_w[16]),
	.remainder	(temp_remainder[11])
);

Divider_row Divider_row_15 (
	.divisor	(reg_divisor[0]),
	.dividend	({temp_remainder[11][14:0], reg_dividend[0][15]}),
	.quotient	(~temp_remainder[11][15]),
	.q_out		(quotient_out_w[15]),
	.remainder	(temp_remainder[10])
);

Divider_row Divider_row_14 (
	.divisor	(reg_divisor[0]),
	.dividend	({temp_remainder[10][14:0], reg_dividend[0][14]}),
	.quotient	(~temp_remainder[10][15]),
	.q_out		(quotient_out_w[14]),
	.remainder	(temp_remainder[9])
);

Divider_row Divider_row_13 (
	.divisor	(reg_divisor[0]),
	.dividend	({temp_remainder[9][14:0], reg_dividend[0][13]}),
	.quotient	(~temp_remainder[9][15]),
	.q_out		(quotient_out_w[13]),
	.remainder	(reg_remainder_w[3])
);
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
Divider_row Divider_row_12 (
	.divisor	(reg_divisor[1]),
	.dividend	({reg_remainder[3][14:0], reg_dividend[1][12]}),
	.quotient	(~reg_remainder[3][15]),
	.q_out		(quotient_out_w[12]),
	.remainder	(temp_remainder[8])
);

Divider_row Divider_row_11 (
	.divisor	(reg_divisor[1]),
	.dividend	({temp_remainder[8][14:0], reg_dividend[1][11]}),
	.quotient	(~temp_remainder[8][15]),
	.q_out		(quotient_out_w[11]),
	.remainder	(temp_remainder[7])
);

Divider_row Divider_row_10 (
	.divisor	(reg_divisor[1]),
	.dividend	({temp_remainder[7][14:0], reg_dividend[1][10]}),
	.quotient	(~temp_remainder[7][15]),
	.q_out		(quotient_out_w[10]),
	.remainder	(temp_remainder[6])
);

Divider_row Divider_row_9 (
	.divisor	(reg_divisor[1]),
	.dividend	({temp_remainder[6][14:0], reg_dividend[1][9]}),
	.quotient	(~temp_remainder[6][15]),
	.q_out		(quotient_out_w[9]),
	.remainder	(reg_remainder_w[2])
);
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
Divider_row Divider_row_8 (
	.divisor	(reg_divisor[2]),
	.dividend	({reg_remainder[2][14:0], reg_dividend[2][8]}),
	.quotient	(~reg_remainder[2][15]),
	.q_out		(quotient_out_w[8]),
	.remainder	(temp_remainder[5])
);

Divider_row Divider_row_7 (
	.divisor	(reg_divisor[2]),
	.dividend	({temp_remainder[5][14:0], reg_dividend[2][7]}),
	.quotient	(~temp_remainder[5][15]),
	.q_out		(quotient_out_w[7]),
	.remainder	(temp_remainder[4])
);

Divider_row Divider_row_6 (
	.divisor	(reg_divisor[2]),
	.dividend	({temp_remainder[4][14:0], reg_dividend[2][6]}),
	.quotient	(~temp_remainder[4][15]),
	.q_out		(quotient_out_w[6]),
	.remainder	(temp_remainder[3])
);

Divider_row Divider_row_5 (
	.divisor	(reg_divisor[2]),
	.dividend	({temp_remainder[3][14:0], reg_dividend[2][5]}),
	.quotient	(~temp_remainder[3][15]),
	.q_out		(quotient_out_w[5]),
	.remainder	(reg_remainder_w[1])
);
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
Divider_row Divider_row_4 (
	.divisor	(reg_divisor[3]),
	.dividend	({reg_remainder[1][14:0], reg_dividend[3][4]}),
	.quotient	(~reg_remainder[1][15]),
	.q_out		(quotient_out_w[4]),
	.remainder	(temp_remainder[2])
);

Divider_row Divider_row_3 (
	.divisor	(reg_divisor[3]),
	.dividend	({temp_remainder[2][14:0], reg_dividend[3][3]}),
	.quotient	(~temp_remainder[2][15]),
	.q_out		(quotient_out_w[3]),
	.remainder	(temp_remainder[1])
);

Divider_row Divider_row_2 (
	.divisor	(reg_divisor[3]),
	.dividend	({temp_remainder[1][14:0], reg_dividend[3][2]}),
	.quotient	(~temp_remainder[1][15]),
	.q_out		(quotient_out_w[2]),
	.remainder	(temp_remainder[0])
);

Divider_row Divider_row_1 (
	.divisor	(reg_divisor[3]),
	.dividend	({temp_remainder[0][14:0], reg_dividend[3][1]}),
	.quotient	(~temp_remainder[0][15]),
	.q_out		(quotient_out_w[1]),
	.remainder	(reg_remainder_w[0])
);
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
Divider_row Divider_row_0 (
	.divisor	(reg_divisor[4]),
	.dividend	({reg_remainder[0][14:0], reg_dividend[4][0]}),
	.quotient	(~reg_remainder[0][15]),
	.q_out		(quotient_out_w[0]),
	.remainder	(remainder_w)
);

always @ ( posedge clk or posedge reset ) begin
	if (reset == 1'b1) begin
		counter <= 5'b0;

		v_out[0]				<= 1'b0;
		v_out[1]				<= 1'b0;
		v_out[2]				<= 1'b0;
		v_out[3]				<= 1'b0;
		valid_out				<= 1'b0;
		reg_dividend[0]			<= 32'b0;
		reg_dividend[1]			<= 32'b0;
		reg_dividend[2]			<= 32'b0;
		reg_dividend[3]			<= 32'b0;
		reg_dividend[4]			<= 32'b0;
		reg_divisor[0]			<= 16'b0;
		reg_divisor[1]			<= 16'b0;
		reg_divisor[2]			<= 16'b0;
		reg_divisor[3]			<= 16'b0;
		reg_divisor[4]			<= 16'b0;
		reg_remainder[0]		<= 16'b0;
		reg_remainder[1]		<= 16'b0;
		reg_remainder[2]		<= 16'b0;
		reg_remainder[3]		<= 16'b0;
		reg_mode[0]				<= 1'b0;
		reg_mode[1]				<= 1'b0;
		reg_mode[2]				<= 1'b0;
		reg_mode[3]				<= 1'b0;
		reg_quotient_out[0]		<= 17'b0;
		reg_quotient_out[1]		<= 17'b0;
		reg_quotient_out[2]		<= 17'b0;
		reg_quotient_out[3]		<= 17'b0;
		//quotient_out			<= 17'b0;		
		remainder				<= 16'b0;
	end
	else begin
		counter <= counter + 5'd1;

		v_out[0]				<= valid_in;
		v_out[1]				<= v_out[0];
		v_out[2]				<= v_out[1];
		v_out[3]				<= v_out[2];
		reg_dividend[0]			<= dividend;
		reg_dividend[1]			<= reg_dividend[0];
		reg_dividend[2]			<= reg_dividend[1];
		reg_dividend[3]			<= reg_dividend[2];
		reg_dividend[4]			<= reg_dividend[3];
		reg_divisor[0]			<= divisor;
		reg_divisor[1]			<= reg_divisor[0];
		reg_divisor[2]			<= reg_divisor[1];
		reg_divisor[3]			<= reg_divisor[2];
		reg_divisor[4]			<= reg_divisor[3];
		reg_mode[0]				<= mode;
		reg_mode[1]				<= reg_mode[0];
		reg_mode[2]				<= reg_mode[1];
		reg_mode[3]				<= reg_mode[2];
		reg_mode[4]				<= reg_mode[3];
		valid_out				<= v_out[3];
		reg_remainder[0]		<= reg_remainder_w[0];
		reg_remainder[1]		<= reg_remainder_w[1];
		reg_remainder[2]		<= reg_remainder_w[2];
		reg_remainder[3]		<= reg_remainder_w[3];
		//quotient_out		<= quotient_out_w;
		reg_quotient_out[0][16:13]		<=quotient_out_w[16:13];
		reg_quotient_out[1][16:9]	<= {reg_quotient_out[0][16:13], quotient_out_w[12:9]};
		reg_quotient_out[2][16:5]	<= {reg_quotient_out[1][16:9], quotient_out_w[8:5]};
		reg_quotient_out[3][16:1]	<= {reg_quotient_out[2][16:5], quotient_out_w[4:1]};
		// reg_quotient_out[2]		<= reg_quotient_out[1];
		// reg_quotient_out[3]		<= reg_quotient_out[2];
		// quotient_out			<= reg_quotient_out[3];
		remainder				<= remainder_w;
	end
end


endmodule
