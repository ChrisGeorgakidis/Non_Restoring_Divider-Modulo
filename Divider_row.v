module Divider_row(divisor, dividend, quotient, q_out, remainder);
input [15:0]divisor;
input [15:0]dividend;
input quotient;
output [15:0]remainder;
output q_out;
wire [15:0]cout;

assign q_out = ~remainder[15];

cas cas_15 (
	.divisor	(divisor[15]),
	.dividend	(dividend[15]),
	.quotient	(quotient),
	.cin		(cout[14]),
	.cout		(cout[15]),
	.remainder  (remainder[15])
);

cas cas_14 (
	.divisor	(divisor[14]),
	.dividend	(dividend[14]),
	.quotient	(quotient),
	.cin		(cout[13]),
	.cout		(cout[14]),
	.remainder  (remainder[14])
);

cas cas_13 (
	.divisor	(divisor[13]),
	.dividend	(dividend[13]),
	.quotient	(quotient),
	.cin		(cout[12]),
	.cout		(cout[13]),
	.remainder  (remainder[13])
);

cas cas_12 (
	.divisor	(divisor[12]),
	.dividend	(dividend[12]),
	.quotient	(quotient),
	.cin		(cout[11]),
	.cout		(cout[12]),
	.remainder  (remainder[12])
);

cas cas_11 (
	.divisor	(divisor[11]),
	.dividend	(dividend[11]),
	.quotient	(quotient),
	.cin		(cout[10]),
	.cout		(cout[11]),
	.remainder  (remainder[11])
);

cas cas_10 (
	.divisor	(divisor[10]),
	.dividend	(dividend[10]),
	.quotient	(quotient),
	.cin		(cout[9]),
	.cout		(cout[10]),
	.remainder  (remainder[10])
);

cas cas_9 (
	.divisor	(divisor[9]),
	.dividend	(dividend[9]),
	.quotient	(quotient),
	.cin		(cout[8]),
	.cout		(cout[9]),
	.remainder  (remainder[9])
);

cas cas_8 (
	.divisor	(divisor[8]),
	.dividend	(dividend[8]),
	.quotient	(quotient),
	.cin		(cout[7]),
	.cout		(cout[8]),
	.remainder  (remainder[8])
);

cas cas_7 (
	.divisor	(divisor[7]),
	.dividend	(dividend[7]),
	.quotient	(quotient),
	.cin		(cout[6]),
	.cout		(cout[7]),
	.remainder  (remainder[7])
);

cas cas_6 (
	.divisor	(divisor[6]),
	.dividend	(dividend[6]),
	.quotient	(quotient),
	.cin		(cout[5]),
	.cout		(cout[6]),
	.remainder  (remainder[6])
);

cas cas_5 (
	.divisor	(divisor[5]),
	.dividend	(dividend[5]),
	.quotient	(quotient),
	.cin		(cout[4]),
	.cout		(cout[5]),
	.remainder  (remainder[5])
);

cas cas_4 (
	.divisor	(divisor[4]),
	.dividend	(dividend[4]),
	.quotient	(quotient),
	.cin		(cout[3]),
	.cout		(cout[4]),
	.remainder  (remainder[4])
);

cas cas_3 (
	.divisor	(divisor[3]),
	.dividend	(dividend[3]),
	.quotient	(quotient),
	.cin		(cout[2]),
	.cout		(cout[3]),
	.remainder  (remainder[3])
);

cas cas_2 (
	.divisor	(divisor[2]),
	.dividend	(dividend[2]),
	.quotient	(quotient),
	.cin		(cout[1]),
	.cout		(cout[2]),
	.remainder  (remainder[2])
);

cas cas_1 (
	.divisor	(divisor[1]),
	.dividend	(dividend[1]),
	.quotient	(quotient),
	.cin		(cout[0]),
	.cout		(cout[1]),
	.remainder  (remainder[1])
);

cas cas_0 (
	.divisor	(divisor[0]),
	.dividend	(dividend[0]),
	.quotient	(quotient),
	.cin		(quotient),
	.cout		(cout[0]),
	.remainder  (remainder[0])
);
endmodule
