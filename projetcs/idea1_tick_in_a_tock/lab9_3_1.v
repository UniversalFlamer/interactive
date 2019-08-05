`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/23 01:22:41
// Design Name: 
// Module Name: lab9_3_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module main(
input clk,
input reset,
input enable,
output [7:0]an,
output [6:0]seg,
output dp
);
wire clk5M;
clk_wiz_0 clock(.clk_in1(clk),.clk_out1(clk5M));
timer count(clk5M,reset,enable,an,seg,dp);
endmodule

module timer(
input clk5M,
input reset,
input enable,
output reg [7:0]an,
output  [6:0]seg,
output reg dp
);

reg [3:0]min;
reg [3:0]sec_10;
reg [3:0]sec;
reg [3:0]msec;
reg [18:0]count;
initial
begin
min =4'b0000 ;
sec_10 = 4'b0000;
sec = 4'b0000;
msec = 4'b0000;
count = 19'd0;
end

always @(posedge clk5M)
begin
if(reset)
    begin
    min =4'b0000 ;
    sec_10 = 4'b0000;
    sec = 4'b0000;
    msec = 4'b0000;
    count = 19'b0;
    end
else
    begin
    if(enable)
        begin
        count = count+19'b1;
        if(count==19'd500000)
            begin
            count = 19'b0;
            msec = msec+4'b1;
            end
        if(msec==4'b1010)
            begin
            msec = 4'b0000;
            sec = sec+4'b1;
            end
        if(sec ==4'b1010)
            begin
            sec = 4'b0000;
            sec_10 = sec_10+4'b1;
            end
        if(sec_10==4'b0110)
            begin
            sec_10 = 4'b0000;
            min = min+4'b1;
            end
        
        end
    
    end    
end

//ÏÔÊ¾Ä£¿é
reg [14:0]disp_count;
reg [3:0]disp;
initial
    begin
    disp_count=15'b0;
    an=8'b11111110;
    disp=msec;
    dp=0;
    end
always@(posedge clk5M)
begin
disp_count=disp_count+9'b1;
if(disp_count>=15'd0 && disp_count<15'd1250)
    begin
    an=8'b11111110;
    disp = msec;
    dp=1;
    end
else if(disp_count>=15'd1250 && disp_count<15'd2500)
    begin
    an=8'b11111101;
    disp=sec;
    dp=0;
    end
else if(disp_count>=15'd2500 && disp_count<15'd3750)
    begin
    an=8'b11111011;
    disp=sec_10;
    dp=1;
    end
else if(disp_count>=15'd3750 && disp_count<15'd5000)
    begin
    an=8'b11110111;
    disp=min;
    dp=0;
    end
else
    disp_count=15'd0;
end
bcdto7segment_dataflow display(.x(disp),.an(),.seg(seg));
endmodule





module bcdto7segment_dataflow(
    input [3:0] x,
    output [7:0] an,
    output  [6:0] seg

 
    );
      assign an[0]=0;
      assign an[1]=1;
      assign an[2]=1;
      assign an[3]=1;
      assign an[4]=1;
      assign an[5]=1;
      assign an[6]=1;
      assign an[7]=1;
      assign seg[0]=(x[0]&~x[1]&~x[2]&~x[3])|(~x[0]&~x[1]&x[2]&~x[3]);
      assign seg[1]=(x[0]&~x[1]&x[2]&~x[3])|(~x[0]&x[1]&x[2]&~x[3]);
      assign seg[2]=(~x[0]&x[1]&~x[2]&~x[3]);
      assign seg[3]=(x[0]&~x[1]&~x[2]&~x[3])|(~x[0]&~x[1]&x[2]&~x[3])|(x[0]&x[1]&x[2]&~x[3]);
      assign seg[4]=(x[0]&~x[1]&~x[2]&~x[3])|(x[0]&x[1]&~x[2]&~x[3])|(~x[0]&~x[1]&x[2]&~x[3])|(x[0]&~x[1]&x[2]&~x[3])|(x[0]&x[1]&x[2]&~x[3])|(x[0]&~x[1]&~x[2]&x[3]);
      assign seg[5]=(x[0]&~x[1]&~x[2]&~x[3])|(~x[0]&x[1]&~x[2]&~x[3])|(x[0]&x[1]&~x[2]&~x[3])|(x[0]&x[1]&x[2]&~x[3]);
      assign seg[6]=(~x[0]&~x[1]&~x[2]&~x[3])|(x[0]&~x[1]&~x[2]&~x[3])|(x[0]&x[1]&x[2]&~x[3]);
endmodule