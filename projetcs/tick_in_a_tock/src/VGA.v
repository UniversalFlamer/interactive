module vga
(
    input                   clk50M   , 
    input                   rst , 
    output                  hs    , 
    output                  vs   ,
    output  flag                ,
    output [11:0]h_addr                   ,
    output [11:0]v_addr   
);

parameter       C_H_SYNC_PULSE      =   120  , 
                C_H_BACK_PORCH      =   64  ,
                C_H_ACTIVE_TIME     =   800 ,
                C_H_FRONT_PORCH     =   56  ,
                C_H_LINE_PERIOD     =   1040 ;
          
parameter       C_V_SYNC_PULSE      =   6   , 
                C_V_BACK_PORCH      =   23  ,
                C_V_ACTIVE_TIME     =   600 ,
                C_V_FRONT_PORCH     =   37  ,
                C_V_FRAME_PERIOD    =   666 ;
                

reg [11:0]      R_h_cnt         ; // 行时序计数器
reg [11:0]      R_v_cnt         ; // 列时序计数器
initial R_h_cnt = 0;
initial R_v_cnt = 0;
always @(posedge clk50M or posedge rst)
begin
    if(rst)
        R_h_cnt <=  12'd0   ;
    else if(R_h_cnt == C_H_LINE_PERIOD - 1'b1)
        R_h_cnt <=  12'd0   ;
    else
        R_h_cnt <=  R_h_cnt + 1'b1  ;                
end                

assign hs =   (R_h_cnt < C_H_SYNC_PULSE) ? 1'b0 : 1'b1    ; 



always @(posedge clk50M or posedge rst)
begin
    if(rst)
        R_v_cnt <=  12'd0   ;
    else if(R_v_cnt == C_V_FRAME_PERIOD - 1'b1)
        R_v_cnt <=  12'd0   ;
    else if(R_h_cnt == C_H_LINE_PERIOD - 1'b1)
        R_v_cnt <=  R_v_cnt + 1'b1  ;
    else
        R_v_cnt <=  R_v_cnt ;                        
end                

assign vs =   (R_v_cnt < C_V_SYNC_PULSE) ? 1'b0 : 1'b1    ; 

assign flag =  (R_h_cnt >= (C_H_SYNC_PULSE + C_H_BACK_PORCH                  ))  &&
                        (R_h_cnt <= (C_H_SYNC_PULSE + C_H_BACK_PORCH + C_H_ACTIVE_TIME))  && 
                        (R_v_cnt >= (C_V_SYNC_PULSE + C_V_BACK_PORCH                  ))  &&
                        (R_v_cnt <= (C_V_SYNC_PULSE + C_V_BACK_PORCH + C_V_ACTIVE_TIME))  ;                     
assign h_addr = R_h_cnt - C_H_SYNC_PULSE - C_H_BACK_PORCH;
assign v_addr = R_v_cnt - C_V_SYNC_PULSE - C_V_BACK_PORCH;

endmodule
 