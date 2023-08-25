`timescale 1ns / 1ps


module tb_tic_tac_toe;

 
 reg clock;
 reg reset;
 reg play;
 reg pc;
 reg [3:0] com_position;
 reg [3:0]player_pos;

 // Outputs
 wire [1:0] POL1;
 wire [1:0] POL2;
 wire [1:0] POL3;
 wire [1:0] POL4;
 wire [1:0] POL5;
 wire [1:0] POL6;
 wire [1:0] POL7;
 wire [1:0] POL8;
 wire [1:0] POL9;
 wire [1:0] winner;


 tic_tac_toe_game uut (
  .clock(clock), 
  .reset(reset), 
  .play(play), 
  .pc(pc), 
  .com_position(com_position), 
  .player_pos(player_pos), 
  .p1(POL1), 
  .p2(POL2), 
  .p3(POL3), 
  .p4(POL4), 
  .p5(POL5), 
  .p6(POL6), 
  .p7(POL7), 
  .p8(POL8), 
  .p9(POL9), 
  .winner(winner)
 );
 // clock
 initial begin
 $dumpfile("tb_tic_tac_toe");
	$dumpvars(0,tb_tic_tac_toe);
 clock = 0;
 forever #5 clock = ~clock;
 end
 initial begin
  // Initialize Inputs
  play = 0;
  reset = 1;
  com_position = 0;
 player_pos = 0;
  pc = 0;
  #100;
  reset = 0;
  #100;
  play = 1;
  pc = 0;
  com_position = 4;
 player_pos = 0;
  #50;
  pc = 1;
  play = 0;
  #100;
  reset = 0;
  play = 1;
  pc = 0;
  com_position = 8;
 player_pos = 1;
  #50;
  pc = 1;
  play = 0;  
  #100;
  reset = 0;
  play = 1;
  pc = 0;
  com_position = 6;
 player_pos = 2;
  #50;
  pc = 1;
  play = 0; 
  #50
  pc = 0;
  play = 0;  
  $finish; 
  end
      
endmodule
