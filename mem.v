//`timescale 1ns / 1ps
module mem #(parameter addr_size=4, word_width=8)(
    input we_s, clk,//write enable signal 
    input [addr_size-1:0] addr_r,//read address
    input [addr_size-1:0] addr_w,//write address
    input [word_width-1:0] data_w,//data to be written
   output [word_width-1:0] data_r //data to be read
   );
    
    
    //Declaraing memory
   reg [word_width-1:0] reg_mem [0: 2**addr_size -1];
   
   //Write operation 
   always@(posedge clk) 
   begin
   if(we_s)
   reg_mem[addr_w] <= data_w;
   end
   
   //Asynchronous read
    assign data_r = reg_mem[addr_r];
endmodule
