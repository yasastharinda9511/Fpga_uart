module tb(clk,tx_data,hex,recieve_over,transmit_active,transmit_begin);
	input clk;
	wire s_tick;
	input [7:0]tx_data;
	input transmit_begin;
	wire [7:0] out_data;
	wire tx_rx,transmit_over;
	output recieve_over,transmit_active;
	output [6:0] hex;
	
	clk_generator clk_gen (.clk(clk),.s_tick(s_tick));
	
	rx reciver(.rx(tx_rx),.s_tick(s_tick),.out_data(out_data),.recieve_over(recieve_over));
	tx transmit(.tx_data(tx_data),.s_tick(s_tick),.transmit_over(transmit_over),.tx(tx_rx),.transmit_begin(transmit_begin),.transmit_active(transmit_active));
	
	bcd_decorder0 bcd0 (.binary(out_data),.hex(hex));
	
endmodule 