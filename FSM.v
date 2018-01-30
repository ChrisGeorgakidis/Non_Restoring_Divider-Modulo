module FSM (clk, reset, valid_in, mode, divisor, dividend, busy, valid_out, result);
input wire clk, reset;
input wire valid_in, mode;
input wire [15:0]divisor;
input wire [31:0]dividend;
output reg busy, valid_out;
output wire [31:0]result;

parameter IDLE		= 3'd0;
parameter DATA		= 3'd1;
parameter SHIFT		= 3'd2;
parameter ADD_SUB	= 3'd3;
parameter LSB		= 3'd4;
parameter RESULT	= 3'd5;

wire [2:0]state;
reg [2:0]nxt_state;

wire [5:0]n;
reg [5:0]numOfBits;

reg [15:0]M;	//divider
reg [31:0]Q;	//quotient
reg [31:0]A;	//remainder

assign result = (mode == 1'b0) ? Q : A ;
assign n = numOfBits;
assign state = nxt_state;

always @ (posedge clk or posedge reset) begin
	if (reset == 1'b1) begin
		nxt_state <= IDLE;
	end
	else begin
		case (state)
		IDLE: begin
			nxt_state <= DATA;
		end
		DATA: begin
			if (valid_in == 1'b1) begin
				nxt_state <= SHIFT;
			end
			else begin
				nxt_state <= DATA;
			end
		end
		SHIFT: begin
			nxt_state <= ADD_SUB;
		end
		ADD_SUB: begin
			nxt_state <= LSB;
		end
		LSB: begin
			if (n == 0) begin
				nxt_state <= RESULT;
			end
			else begin
				nxt_state <= SHIFT;
			end
		end
		RESULT: begin
			nxt_state <= DATA;
		end
		default: begin
			nxt_state <= IDLE;
		end
		endcase
	end
end

always @ (posedge clk or posedge reset) begin
	if (reset == 1'b1) begin
		numOfBits	<= 6'd32;
		busy		<= 1'b0;
		valid_out	<= 1'b0;
		A			<= 32'b0;
		Q			<= 32'b0;
		M			<= 32'b0;
	end
	else begin
		case (state)
		IDLE: begin
			numOfBits	<= 6'd32;
			busy		<= 1'b0;
			valid_out	<= 1'b0;
			A			<= 32'b0;
			Q			<= 32'b0;
			M			<= 32'b0;
		end
		DATA: begin
			numOfBits	<= 6'd32;
			if (valid_in == 1'b1) begin
				busy <= 1'b1;
			end
			else begin
				busy <= 1'b0;
			end
			numOfBits	<= n;
			valid_out	<= 1'b0;
			A			<= 32'b0;
			Q			<= dividend;
			M			<= divisor;
		end
		SHIFT: begin
			numOfBits	<= n;
			busy		<= 1'b1;
			valid_out	<= 1'b0;
			A			<= {A[30:0], Q[15]};
			Q			<= {Q[14:0], 1'b0};
		end
		ADD_SUB: begin
			numOfBits	<= n;
			busy		<= 1'b1;
			valid_out	<= 1'b0;
			if (A[31] == 1'b1) begin
				A		<= A + M;
			end
			else begin
				A		<= A - M;
			end
		end
		LSB: begin
			numOfBits	<= n - 6'd1;
			busy		<= 1'b0;
			valid_out	<= 1'b0;
			Q		<= {Q[15:1], ~A[31]};
		end
		RESULT: begin
			numOfBits	<= n;
			busy		<= 1'b0;
			valid_out	<= 1'b1;
			if (A[31] == 1'b1) begin
				A		<= A + M;
			end
		end
		default: begin
			numOfBits	<= 6'd32;
			busy		<= 1'b0;
			valid_out	<= 1'b0;
			A			<= 32'b0;
			Q			<= 32'b0;
			M			<= 32'b0;
		end
		endcase
	end
end

endmodule // FSM
