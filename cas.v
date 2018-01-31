module cas (divisor, dividend, quotient, cin, cout, remainder);
input wire divisor, dividend, quotient, cin;
output wire cout, remainder;

assign remainder = (quotient ^ divisor) ^ dividend ^ cin;
//checks if two of the elements are 1 at the same time, so it produces a cout
assign cout = ((quotient ^ divisor)&dividend) | ((quotient ^ divisor)&cin) | (cin&dividend);

endmodule
