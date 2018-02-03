module Divider_automatic_tb ();

//inputs
reg clk, reset, valid_in, mode;
reg [15:0]divisor;
reg [31:0]dividend;
wire valid_out;
wire [31:0]result;

//variables for automatic testbench
integer i, counter, errors;
reg [31:0]Dividend[2:0];
reg [15:0]Divisor[2:0];
reg [0:0]ValidIn[2:0];
reg [0:0]Mode[2:0];
reg [31:0]Expected_Result[2:0];
reg [0:0]Expected_ValidOut[2:0];

Divider_Modulo Divider_Modulo(
    .clk        (clk),
    .reset      (reset),
	.mode       (mode),
    .valid_in   (valid_in),
    .divisor    (divisor),
    .dividend   (dividend),
	.result     (result),
	.valid_out  (valid_out)
);


initial begin
	clk			= 1'b1;
	counter		= 0;
	errors		= 0;
	reset		= 1'b1;
	mode		= 1'b0;
	valid_in	= 1'b0;
	#50 reset	= 1'b0;

	for (i = 0; i < 3; i = i + 1) begin
		ValidIn[i]				=	1'b1; //$random%1;
		Mode[i]					=	1'b1; //$random%1;
		Divisor[i]				=	$random % 2147483647;
		Dividend[i]				=	$random % 32767;
		if (Mode[i] == 1'b0) begin
			Expected_Result[i]	=	Dividend[i]/Divisor[i];
		end
		else begin
			Expected_Result[i]	=	Dividend[i]%Divisor[i];
		end
		Expected_ValidOut[i]	=	ValidIn[i];
	end

	for (i = 0; i < 3; i = i + 1) begin
		#10	valid_in	=	ValidIn[i];
			mode		=	Mode[i];
			divisor		=	Divisor[i];
			dividend	=	Dividend[i];
	end

	$display("Errors = %d", errors);
	#70 $finish;
end

always begin
    #5clk <= ~clk;
	if (clk == 1'b1) begin
		counter = counter + 1;
	end
end

always @ (negedge clk) begin
	case (counter)
		11: begin
			if (result == Expected_Result[0] && valid_out == Expected_ValidOut[0]) begin
				$display("Success: valid_in = %b, mode = %b, dividend = %d, divisor = %d	=>	result = %d, valid_out = %b", ValidIn[0], Mode[0], Dividend[0], Divisor[0], Expected_Result[0], Expected_ValidOut[0]);
			end
			else begin
				$display("Error: valid_in = %b, mode = %b, dividend = %d, divisor = %d	=>	result = %d, valid_out = %b", ValidIn[0], Mode[0], Dividend[0], Divisor[0], Expected_Result[0], Expected_ValidOut[0]);
				errors = errors + 1;
			end
		end
		12: begin
			if (result == Expected_Result[1] && valid_out == Expected_ValidOut[1]) begin
				$display("Success: valid_in = %b, mode = %b, dividend = %d, divisor = %d	=>	result = %d, valid_out = %b", ValidIn[1], Mode[1], Dividend[1], Divisor[1], Expected_Result[1], Expected_ValidOut[1]);
			end
			else begin
				$display("Error: valid_in = %b, mode = %b, dividend = %d, divisor = %d	=>	result = %d, valid_out = %b", ValidIn[1], Mode[1], Dividend[1], Divisor[1], Expected_Result[1], Expected_ValidOut[1]);
				errors = errors + 1;
			end
		end
		13: begin
			if (result == Expected_Result[2] && valid_out == Expected_ValidOut[2]) begin
				$display("Success: valid_in = %b, mode = %b, dividend = %d, divisor = %d	=>	result = %d, valid_out = %b", ValidIn[2], Mode[2], Dividend[2], Divisor[2], Expected_Result[2], Expected_ValidOut[2]);
			end
			else begin
				$display("Error: valid_in = %b, mode = %b, dividend = %d, divisor = %d	=>	result = %d, valid_out = %b", ValidIn[2], Mode[2], Dividend[2], Divisor[2], Expected_Result[2], Expected_ValidOut[2]);
				errors = errors + 1;
			end
		end
		default:;
	endcase
end

endmodule
