//`timescale 1ns / 1ps
module dg_counter #(parameter addr_size=4)(
    input clk,
    output [addr_size:0] gray_count_st,//Msb for cycle detction 
    output [addr_size-1:0] gray_count_nd,
    input reset_n,
    input en
    );
    
    reg [addr_size:0] Q_reg,Q_next ;
    wire _2nd_msb ;
    always @(posedge clk, negedge reset_n)
        begin
           if (~reset_n)
               Q_reg <= 'b0;
           else if(en)
               Q_reg <= Q_next;
           else Q_reg <= Q_reg ;
       end
       
       // Next state logic
       always @(Q_reg)
       begin
           Q_next <= Q_reg + 1;
       end
       
       //Output logic for gray convertion
       //n-bit gray output generation
    assign gray_count_st = Q_reg ^ (Q_reg >> 1);
    
        //logic for n-1 bit 
    assign _2nd_msb = gray_count_st[addr_size] ^gray_count_st[addr_size-1];
    assign gray_count_nd ={_2nd_msb,gray_count_st[addr_size-2:0]};
endmodule
