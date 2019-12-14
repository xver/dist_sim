/* verilator lint_off UNDRIVEN */
/* verilator lint_off UNUSED */
/* verilator lint_off UNOPTFLAT */
module top_rtl(input reg i_clk,input reg reset_n,output reg benchmark_event);
  
   reg        wen    [`N_LINK:0];
   reg [31:0] token  [`N_LINK:0];
   reg [31:0] clk_cnt[`N_LINK:0];
   reg [31:0] id     [`N_LINK:0];

   // 
   initial Frng_if.frng_success = Frng_if.set_iam(`MY_TOP_NAME);
   shunt_fringe_if Frng_if (i_clk);
   //
   
   assign wen    [0] = wen      [`N_LINK];
   assign token  [0] = token    [`N_LINK];
   assign clk_cnt[0] = clk_cnt  [`N_LINK];
   assign id     [0] = id       [`N_LINK];
   
   assign  benchmark_event =  wen[`N_LINK];
   
      
   generate
      for(genvar i=0;i<`N_LINK;i++)
        begin: chain
           link_i #(.ID(i))link(
		       .i_clk     (i_clk),		 
		       .i_rstn    (reset_n),
                       //
		       .i_wen     (wen    [i]),
		       .i_token   (token  [i]),
		       .i_clk_cnt (clk_cnt[i]),
		       .i_id      (id     [i]),
                       //
		       .o_wen     (wen    [i+1]),
		       .o_token   (token  [i+1]),
		       .o_clk_cnt (clk_cnt[i+1]),
		       .o_id      (id     [i+1])
		       );  
        end // block: link
   endgenerate

endmodule // top_rtl

/* verilator lint_on UNDRIVEN */
/* verilator lint_on UNUSED */
/* verilator lint_on UNOPTFLAT */
