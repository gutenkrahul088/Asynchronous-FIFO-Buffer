`include "asyn_fifo_main.v"
//`timescale 1ns / 1ps
module asyn_fifo_main_tb();
parameter addr_size=3,word_width=8;
reg r_clk;
reg w_clk;
// read and write command
reg rd;
reg wr;
reg reset_n;
reg [word_width-1:0] data_in;
wire [word_width-1:0] data_out;
wire full; //full declared
wire empty ; //empty declared
   
asyn_fifo_main #(.addr_size(addr_size), .word_width(word_width)) asyn_fifo_main_i1( 
.r_clk(r_clk),
.w_clk(w_clk),
.rd(rd),
.wr(wr),
.reset_n(reset_n),.data_in(data_in),.data_out(data_out),.full(full),.empty(empty));
//initialisation of signals
initial
begin
 r_clk= 1'b0 ;
 w_clk =1'b0;
 rd =1'b0;
 wr =1'b0;
 data_in= 'd104;
end
//Generation of read and write clocks
always #8 r_clk = ~r_clk ;
always #3 w_clk = ~w_clk ; // writing clock frequency is higher than reading clock frequency.
//Initialisation of reset signals
initial
begin
reset_n =1'b1;
#1 reset_n =1'b0; 
#1 reset_n =1'b1;
end
initial
begin //Writing the data into FIFO untill it's full.
$dumpfile("fifo output.vcd");
$dumpvars(0,asyn_fifo_main_tb);
#2.5 if(full!=1 )begin data_in= 'd104; wr=1'b1;end
#3.5 if(full==0)begin data_in= 'd100; wr=1'b0;end
#6 if(full==0)begin wr=1'b1;data_in= 'd105;end
#6 if(full==0) data_in= 'd95;
#6 if(full==0) data_in= 'd116;
#6 if(full==0) data_in= 'd104;
#6 if(full==0) data_in= 'd101;
#6 if(full==0) data_in= 'd114;
#6 if(full==0) data_in= 'd101;
wait(full);
wr=1'b0;
// Write signal become low the reading will start after 2 clocks to synchronise. 
#2 rd=1'b1 ; //Reading will occur untill FIFO gets empty.
wait(empty);
#6 if(full==0) begin data_in= 'd79; wr=1'b1; end 
#6 if(full==0) data_in= 'd114;
#6 if(full==0) data_in= 'd105;
#6 if(full==0) data_in= 'd103;
#6 if(full==0) data_in= 'd105;
#6 if(full==0) data_in= 'd110;
#6 if(full==0) data_in= 'd97;
#6 if(full==0) data_in= 'd108;
#6 if(full==0) data_in= 'd95;
#6 if(full==0) data_in= 'd70;
#6 if(full==0) data_in= 'd73;
#6 if(full==0) data_in= 'd70;
#6 if(full==0) data_in= 'd73;
#6 if(full==0) data_in= 'd73;
#2 wr =1'b0;
wait(empty); 
#5 $finish ;
end 
endmodule
