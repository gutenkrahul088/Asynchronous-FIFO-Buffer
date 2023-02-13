`include "fifo_cu.v"
`include "mem.v"
//`timescale 1ns / 1ps
module asyn_fifo_main #(parameter addr_size=3, word_width=8)(
    input r_clk, w_clk, rd,wr, reset_n,
    input [word_width-1:0] data_in,
    output [word_width-1:0] data_out,
    output full,empty);
        
    //Declaration
    wire [addr_size-1:0] addr_r,addr_w ;
    wire we_enable, rd_enable ;
    wire [addr_size:0] ptr_r;
    wire [addr_size:0] ptr_w;
    
      
    //Initialization of control unit   
    fifo_cu #(.addr_size(addr_size)) fifo_cu_i1
    (.reset_n(reset_n),.w_clk(w_clk), .r_clk(r_clk),.rd(rd),.wr(wr),.addr_r(addr_r), .addr_w(addr_w),
   .full(full),.empty(empty), .we_enable(we_enable),.rd_enable(rd_enable));
        
        
        
    //Initialize memory register 
    mem #(addr_size,word_width) mem_i1 (.we_s(we_enable), .clk(w_clk),.addr_r(addr_r),
          .addr_w(addr_w),.data_w(data_in),.data_r(data_out));
endmodule
