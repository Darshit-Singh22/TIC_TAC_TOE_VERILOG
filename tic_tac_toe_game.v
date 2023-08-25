module tic_tac_toe_game(
     input clock, 
     input reset,  
     input play,  
     input pc,  
     input [3:0]  com_position,player_pos, 
     
     output wire [1:0] p1,p2,p3,
     p4,p5,p6,p7,p8,p9,
     
     output wire[1:0]winner
     
     );
 wire [15:0] PS;
 wire [15:0] PLS; 
 wire illegal_TRIAL; 
 wire win; 
 wire computer_play;  
 wire player_poslay; 
 wire no_space; 
 
  pition_registers pition_reg_unit(
      clock,  
      reset, 
      illegal_TRIAL, 
      PS[8:0], 
      PLS[8:0], 
      p1,p2,p3,p4,p5,p6,p7,p8,p9
      );
 
 winner_detector win_detect_unit(p1,p2,p3,p4,p5,p6,p7,p8,p9,win,winner);
  
 pition_decoder pd1( com_position,computer_play,PS);
  
 pition_decoder pd2(player_pos,player_poslay,PLS); 

  illegal_TRIAL_detector imd_MOD(
   p1,p2,p3,p4,p5,p6,p7,p8,p9, 
   PS[8:0], PLS[8:0], 
   illegal_TRIAL
   );
 
 nospace_detector nsd_MOD(
   p1,p2,p3,p4,p5,p6,p7,p8,p9, 
   no_space
    ); 
    
 fsm_controller tic_tac_toe_controller(
     clock,reset,play,pc,illegal_TRIAL, 
     no_space,win,computer_play, player_poslay 
     );    
endmodule 

module pition_registers(
      input clock,  
      input reset, 
      input illegal_TRIAL,  
      input [8:0] PS, 
      input [8:0] PLS,  
      output reg[1:0] p1,p2,p3,p4,p5,p6,p7,p8,p9
      );

 always @(posedge clock or posedge reset)
 begin
  if(reset) 
   p1 <= 2'b00;
  else begin
   if(illegal_TRIAL==1'b1)
    p1 <= p1;
   else if(PS[0]==1'b1)
    p1 <= 2'b10; 
   else if (PLS[0]==1'b1)
    p1 <= 2'b01;
   else 
    p1 <= p1;
  end 
 end 
 
 always @(posedge clock or posedge reset)
 begin
  if(reset) 
   p2 <= 2'b00;
  else begin
   if(illegal_TRIAL==1'b1)
    p2 <= p2;
   else if(PS[1]==1'b1)
    p2 <= 2'b10; 
   else if (PLS[1]==1'b1)
    p2 <= 2'b01;
   else 
    p2 <= p2;
  end 
 end 

 always @(posedge clock or posedge reset)
 begin
  if(reset) 
   p3 <= 2'b00;
  else begin
   if(illegal_TRIAL==1'b1)
    p3 <= p3;
   else if(PS[2]==1'b1)
    p3 <= 2'b10; 
   else if (PLS[2]==1'b1)
    p3 <= 2'b01;
   else 
    p3 <= p3;
  end 
 end  
 
 
 always @(posedge clock or posedge reset)
 begin
  if(reset) 
   p4 <= 2'b00;
  else begin
   if(illegal_TRIAL==1'b1)
    p4 <= p4;
   else if(PS[3]==1'b1)
    p4 <= 2'b10; 
   else if (PLS[3]==1'b1)
    p4 <= 2'b01;
   else 
    p4 <= p4;
  end 
 end 
 
 always @(posedge clock or posedge reset)
 begin
  if(reset) 
   p5 <= 2'b00;
  else begin
   if(illegal_TRIAL==1'b1)
    p5 <= p5;
   else if(PS[4]==1'b1)
    p5 <= 2'b10; 
   else if (PLS[4]==1'b1)
    p5 <= 2'b01;
   else 
    p5 <= p5;
  end 
 end 

 always @(posedge clock or posedge reset)
 begin
  if(reset) 
   p6 <= 2'b00;
  else begin
   if(illegal_TRIAL==1'b1)
    p6 <= p6;
   else if(PS[5]==1'b1)
    p6 <= 2'b10; 
   else if (PLS[5]==1'b1)
    p6 <= 2'b01;
   else 
    p6 <= p6;
  end 
 end 
 // pition 7 
 always @(posedge clock or posedge reset)
 begin
  if(reset) 
   p7 <= 2'b00;
  else begin
   if(illegal_TRIAL==1'b1)
    p7 <= p7;
   else if(PS[6]==1'b1)
    p7 <= 2'b10; 
   else if (PLS[6]==1'b1)
    p7 <= 2'b01;
   else 
    p7 <= p7;
  end 
 end 


 always @(posedge clock or posedge reset)
 begin
  if(reset) 
   p8 <= 2'b00;
  else begin
   if(illegal_TRIAL==1'b1)
    p8 <= p8;
   else if(PS[7]==1'b1)
    p8 <= 2'b10; 
   else if (PLS[7]==1'b1)
    p8 <= 2'b01;
   else 
    p8 <= p8;
  end 
 end 

 always @(posedge clock or posedge reset)
 begin
  if(reset) 
   p9 <= 2'b00;
  else begin
   if(illegal_TRIAL==1'b1)
    p9 <= p9;
   else if(PS[8]==1'b1)
    p9 <= 2'b10;  
   else if (PLS[8]==1'b1)
    p9 <= 2'b01; 
   else 
    p9 <= p9;
  end 
 end  
endmodule 


module fsm_controller(
     input clock,
     input reset,
     play, 
     pc,
     illegal_TRIAL,
     no_space, 
     win, 
     output reg computer_play,  
     player_poslay 
     );


parameter IDLE=2'b00;
parameter PLAYER=2'b01;
parameter COMPUTER=2'b10;
parameter GAME_DONE=2'b11;
reg[1:0] current_state, next_state;

always @(posedge clock or posedge reset) 
begin 
 if(reset)
  current_state <= IDLE;
 else 
  current_state <= next_state;
end 
 
always @(*)
 begin
 case(current_state)
 IDLE: begin 
  if(reset==1'b0 && play == 1'b1)
   next_state <= PLAYER; 
  else 
   next_state <= IDLE;
  player_poslay <= 1'b0;
  computer_play <= 1'b0;
 end 
 PLAYER:begin 
  player_poslay <= 1'b1;
  computer_play <= 1'b0;
  if(illegal_TRIAL==1'b0)
   next_state <= COMPUTER; 
  else 
   next_state <= IDLE;
 end 
 COMPUTER:begin 
  player_poslay <= 1'b0;
  if(pc==1'b0) begin 
   next_state <= COMPUTER;
   computer_play <= 1'b0;
  end
  else if(win==1'b0 && no_space == 1'b0)
  begin 
   next_state <= IDLE;
   computer_play <= 1'b1;
  end 
  else if(no_space == 1 || win ==1'b1)
  begin 
   next_state <= GAME_DONE;
   computer_play <= 1'b1;
  end  
 end 
 GAME_DONE:begin 
  player_poslay <= 1'b0;
  computer_play <= 1'b0; 
  if(reset==1'b1) 
   next_state <= IDLE;
  else 
   next_state <= GAME_DONE;  
 end 
 default: next_state <= IDLE; 
 endcase
 end
endmodule 

module nospace_detector(
   input [1:0] p1,p2,p3,p4,p5,p6,p7,p8,p9, 
   output wire no_space
    );
wire t1,t2,t3,t4,t5,t6,t7,t8,t9;
    
assign t1 = p1[1] | p1[0];
assign t2 = p2[1] | p2[0];
assign t3 = p3[1] | p3[0];
assign t4 = p4[1] | p4[0];
assign t5 = p5[1] | p5[0];
assign t6 = p6[1] | p6[0];
assign t7 = p7[1] | p7[0];
assign t8 = p8[1] | p8[0];
assign t9 = p9[1] | p9[0];

assign no_space =((((((((t1 & t2) & t3) & t4) & t5) & t6) & t7) & t8) & t9);
endmodule 


module illegal_TRIAL_detector(
   input [1:0] p1,p2,p3,p4,p5,p6,p7,p8,p9, 
   input [8:0] PS, PLS, 
   output wire illegal_TRIAL
   );
wire t1,t2,t3,t4,t5,t6,t7,t8,t9;
wire t11,t12,t13,t14,t15,t16,t17,t18,t19;
wire t21,t22;

 
assign t1 = (p1[1] | p1[0]) & PLS[0];
assign t2 = (p2[1] | p2[0]) & PLS[1];
assign t3 = (p3[1] | p3[0]) & PLS[2];
assign t4 = (p4[1] | p4[0]) & PLS[3];
assign t5 = (p5[1] | p5[0]) & PLS[4];
assign t6 = (p6[1] | p6[0]) & PLS[5];
assign t7 = (p7[1] | p7[0]) & PLS[6];
assign t8 = (p8[1] | p8[0]) & PLS[7];
assign t9 = (p9[1] | p9[0]) & PLS[8];

assign t11 = (p1[1] | p1[0]) & PS[0];
assign t12 = (p2[1] | p2[0]) & PS[1];
assign t13 = (p3[1] | p3[0]) & PS[2];
assign t14 = (p4[1] | p4[0]) & PS[3];
assign t15 = (p5[1] | p5[0]) & PS[4];
assign t16 = (p6[1] | p6[0]) & PS[5];
assign t17 = (p7[1] | p7[0]) & PS[6];
assign t18 = (p8[1] | p8[0]) & PS[7];
assign t19 = (p9[1] | p9[0]) & PS[8];

assign t21 =((((((((t1 | t2) | t3) | t4) | t5) | t6) | t7) | t8) | t9);
assign t22 =((((((((t11 | t12) | t13) | t14) | t15) | t16) | t17) | t18) | t19);

assign illegal_TRIAL = t21 | t22 ;
endmodule 

module pition_decoder(input[3:0] in, input enable, output wire [15:0] out_en);
 reg[15:0] t1;
 assign out_en = (enable==1'b1)?t1:16'd0;
 always @(*)
 begin
 case(in)
 4'd0: t1 <= 16'b0000000000000001;
 4'd1: t1 <= 16'b0000000000000010; 
 4'd2: t1 <= 16'b0000000000000100;
 4'd3: t1 <= 16'b0000000000001000;
 4'd4: t1 <= 16'b0000000000010000;
 4'd5: t1 <= 16'b0000000000100000;
 4'd6: t1 <= 16'b0000000001000000;
 4'd7: t1 <= 16'b0000000010000000;
 4'd8: t1 <= 16'b0000000100000000;
 4'd9: t1 <= 16'b0000001000000000;
 4'd10: t1 <= 16'b0000010000000000;
 4'd11: t1 <= 16'b0000100000000000;
 4'd12: t1 <= 16'b0001000000000000;
 4'd13: t1 <= 16'b0010000000000000;
 4'd14: t1 <= 16'b0100000000000000;
 4'd15: t1 <= 16'b1000000000000000;
 default: t1 <= 16'b0000000000000001; 
 endcase 
end 
endmodule 

module winner_detector(input [1:0] p1,p2,p3,p4,p5,p6,p7,p8,p9, output wire winnerr, output wire [1:0]winner);
wire win1,win2,win3,win4,win5,win6,win7,win8;
wire [1:0] winner1,winner2,winner3,winner4,winner5,winner6,winner7,winner8;
winner_detect_3 u1(p1,p2,p3,win1,winner1);
winner_detect_3 u2(p4,p5,p6,win2,winner2);
winner_detect_3 u3(p7,p8,p9,win3,winner3);
winner_detect_3 u4(p1,p4,p7,win4,winner4);
winner_detect_3 u5(p2,p5,p8,win5,winner5);
winner_detect_3 u6(p3,p6,p9,win6,winner6);
winner_detect_3 u7(p1,p5,p9,win7,winner7);
winner_detect_3 u8(p3,p5,p6,win8,winner8);
assign winnerr = (((((((win1 | win2) | win3) | win4) | win5) | win6) | win7) | win8);
assign winner = (((((((winner1 | winner2) | winner3) | winner4) | winner5) | winner6) | winner7) | winner8);
endmodule 

module winner_detect_3(input [1:0] p0,p1,p2, output wire winnerr, output wire [1:0]winner);
wire [1:0] t0,t1,t2;
wire t3;
assign t0[1] = !(p0[1]^p1[1]);
assign t0[0] = !(p0[0]^p1[0]);
assign t1[1] = !(p2[1]^p1[1]);
assign t1[0] = !(p2[0]^p1[0]);
assign t2[1] = t0[1] & t1[1];
assign t2[0] = t0[0] & t1[0];
assign t3 = p0[1] | p0[0];

assign winnerr = t3 & t2[1] & t2[0];

assign winner[1] = winnerr & p0[1];
assign winner[0] = winnerr & p0[0];
endmodule
