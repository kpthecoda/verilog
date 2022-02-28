`timescale 1ns / 1ps 
 
module seq_detector(clk, rst, bit_in, detected, bit_sequence); 
 
	parameter bits = 5; 
	parameter count_bits = 4; 
	parameter pattern = 5'b10101; 
 
	input clk; 
	input rst; 
	input bit_in; 
	 
	output detected; 
	 
	output bit_sequence; 
	 
	wire clk; 
	wire rst; 
	wire bit_in; 
	 
	wire detected; 
	 
	reg [bits - 1:0] bit_sequence; 
	 
	reg [count_bits - 1:0] count; 
	 
	reg valid; 
	 
	always @(posedge clk or posedge rst) 
	begin 
		if (rst) 
		begin 
			bit_sequence <= 0; 
			count <= 0; 
			valid <= 0; 
		end 
		else 
		begin 
			if (count < 5) 
			begin 
				count <= count + 1; 
				valid <= 0; 
				bit_sequence <= (bit_sequence << 1) | bit_in; 
			end 
			else 
			begin 
			    valid <= 1; 
				bit_sequence <= (bit_sequence << 1) | bit_in; 
			end 
		end 
	end 
	 
	assign detected = ((bit_sequence == pattern) ? 1 : 0) & valid; 
 
endmodule 