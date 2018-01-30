module Divider_tb ();

reg clk, reset, valid_in, mode;
reg [15:0]divisor;
reg [31:0]dividend;
wire busy, valid_out;
wire [31:0]result;

FSM FSM(
    .clk        (clk),
    .reset      (reset),
    .valid_in   (valid_in),
    .mode       (mode),
    .divisor    (divisor),
    .dividend   (dividend),
    .busy       (busy),
    .valid_out  (valid_out),
    .result     (result)
);



initial begin
    clk         <= 1'b1;
    reset       <= 1'b1;
    valid_in    <= 1'b1;
    mode        <= 0;
    divisor     <= 16'd5;
    dividend    <= 32'd17;
    #50 reset   <= 1'b0;
end

always begin
    #5clk <= ~clk;
end

endmodule
