# TIC_TAC_TOE_VERILOG
The Tic Tac Toe game is designed and implemented in Logisim. However, let's define the rules for the game at first. In this game, a player plays the Tic Tac Toe game with a computer. When the player OR computer plays the game, a 2-bit value is stored into one of the nine positions in the 3x3 grid like Xs/ Os in the real paper-and-pencil version. 2'b00 is stored into a position when neither the player or computer played in that position. Similarly, 2'b01 (X) is the value to be stored when the player played in the position and 2'b10 (O) is the value to be saved when the computer played in the position. The player/ computer plays the game by pressing their corresponding button. Red/ Green LED is lit in a position when the position is played by the player/ computer respectively.

1. IDLE(00): when waiting for the player/ computer to play or when resetting the circuit, the FSM is at the IDLE state.

2. PLAYER(01): The player turns to play and “01” to be stored into the decoded position.

3. COMPUTER(10): 
The computer turns to play and “01” to be stored into the decoded position.

4. Game_over(11): The game is finished when there is a winner or no more space to play.

Inputs of the controller of the Tic Tac Toe game:

a. Reset :

Reset = 1: Reset the game when in the Game_Over state.

Reset = 0: The game begins.

b. Play: 

Play = 1: When in the IDLE state, play = 1 is to switch the controller to the PLAYER state and the player plays.

Play =0: Stay in the IDLE state.

c. PC 

PC = 1: When in COMPUTER state, PC = 1 is to switch to the IDLE state and the computer plays. 

PC =0 : stay in COMPUTER state.

d. Illegal_move 

Illegal_move = 0: When in PLAYER state, Illegal_move = 0 is to switch to COMPUTER state and let computer plays when PC = 1.

Illegal_move = 1: Illegal moving from the player/ computer and switch to the IDLE state.
e. No_space 
No_space = 0: still have space to play, continue the game.
No_space = 1: no more space to play, game over, and need to reset the game before playing again.
f. Win
Win = 0: Still waiting for the winner
Win = 1: There is a winner, finish the game, and need to reset the game before playing again.
