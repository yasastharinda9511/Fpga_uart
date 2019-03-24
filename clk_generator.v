module clk_generator(clk, s_tick);
	input clk;
	output s_tick;
	parameter clk_devide_count=9'd325;
	reg [8:0]count =9'd0;
	
	always@(posedge clk)
		begin
			if(clk_devide_count==count) count =9'd0;
			else count=count + 1'b1;
		end
	
	assign s_tick =(count == clk_devide_count) ? 1'b1:1'b0;
endmodule
