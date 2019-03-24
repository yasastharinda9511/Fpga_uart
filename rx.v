module rx(rx,s_tick,out_data,recieve_over);
	input s_tick,rx;
	output reg [7:0] out_data;
	reg [3:0] tick_count=4'b0000;
	parameter IDLE=3'b00,start =2'b01, data_bits=2'b10,end_bit=2'b11;
	reg [2:0] state = IDLE;
	reg [2:0]data_index=3'b111;
	output reg recieve_over=1'b0;
	
	always@(posedge s_tick)
		begin
			case(state)
				start: 
					begin
						if (tick_count==4'b0111) 
							begin
								state= data_bits;
								tick_count=4'b0000;
								data_index=3'b111;
							end	
						else tick_count= tick_count+1;
					end
				data_bits:
					begin
					if (tick_count==4'b1111)
						begin
							out_data[data_index]=rx;
							tick_count=4'b0000;
							if(data_index==3'b000) 
								begin
									state= end_bit;
									tick_count=4'b0000;
								end
							else data_index=data_index-1;
						end
					else tick_count=tick_count+1'b1;
					end
				end_bit:
					begin
						if (tick_count==4'b1111)
							begin
								state =IDLE;
								recieve_over=rx;
							end
						else tick_count=tick_count+1'b1; 
					end
				default:
					begin
						state=IDLE;
						tick_count=4'b0000;
						data_index=3'b111;
						recieve_over=1'b0;
						if(rx==1'b0) state=start;
					end
			endcase
				
		end
endmodule
