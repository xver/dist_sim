/* verilator lint_off UNUSED */
module  top_sim (input reg clk_i);
   
   //logic clk_i;
   
   logic reset_n;
   logic [31:0] clk_cnt=0;
   time       start_time=0;
   longint    event_cnt=0;
   reg 	      benchmark_event;
      
   initial   begin 
      start_time = $time;
      event_cnt  = 0;
   end
   
   always @(posedge benchmark_event) begin
      if ( dut.Frng_if.who_iam() == `MY_TOP_NAME) begin 
	 event_cnt <=event_cnt+1;
      end
   end
   
   
   
   always @(posedge clk_i) begin
      if ( dut.Frng_if.who_iam() == `MY_TOP_NAME) begin
	 //$display("%s --------clk_cnt(%0d) @(%0t) event_cnt(%0d)", dut.Frng_if.who_iam(),dut.Frng_if.get_time(),$time,event_cnt);
	 if ($time > 200_000 ) begin
	    $display("%s Sim END event_cnt(%0d) clk_cnt(%0d) @%0t", dut.Frng_if.who_iam(),event_cnt,dut.Frng_if.get_time(),$time);
	    $display("%s $finish", dut.Frng_if.who_iam());
	    $finish;  
	 end // if ($time > 200_000 )
      end // if ( dut.Frng_if.who_iam() == `MY_TOP_NAME)
   end // always @ (posedge clk_i)

   
   
   always @(posedge clk_i) begin
      clk_cnt  <=  clk_cnt +1;
      if (clk_cnt > 10) reset_n <= 1;
      else  reset_n <= 0;
   end // always @ (posedge clk_i)   

   top_rtl  dut(.i_clk(clk_i),.reset_n(reset_n),.benchmark_event(benchmark_event));
   
endmodule: top_sim
/* verilator lint_on UNUSED */
