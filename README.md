# mastermind_ruby
The game of mastermind, with a player competing against the computer. Written in Ruby.

GamePlay:
  NOTE: Duplicate colors are allowed!

  The user is greeted by a message asking his name to personalize the experience. Then, he is asked whether he would lick to create a code. 
  If he selects Y, then the user will play a game of MasterMind, with the user creating the code and the computer attempting to guess this code. The computer will guess a four-color guess of the same color through all of the acceptable colors, or until the code array is filled. This array is then checked against the user's code. If it does not match, I implemented Array.shuffle on the array. This allows the user some chance of winning. After 12 rounds, the user will either be met with victory or defeat!
  If, instead, he selects N, then the computer will randomly generate a code with four colors from acceptable colors. Next, the program prompts the user for a four-color guess. Depending on the guess, the computer will print the correct number of black dots -correct color and position- and white dots -color is in code, but not in that position. At any point, if the user's code equals the computer's, the game ends. This code loops for 12 times. After, the user will meet victory or defeat! 


Before Starting:
  This project will be very challenging. My approach will be to chop the program up into micro-programs. I will attempt to follow Sandi Metz rules for programming, and I will try to use many small objects instead of fewer large ones. This program will allow me to grow not only in Ruby, but also OOP in general.


After Finishing:
  This project forced me to utilize all of the tools I have learned through TheOdinProject. From Googling issues to Project Management, this project forced me to the next level of programming. I learned many key aspects from MasterMind that I will start my next project with. I first created the game solely with functions and some variables. But then I noticed how wet my code was. To DRY it out, I created classes for each of the main aspects of the game. I started with what seemed easiest: the User. Then I tackled the Computer, and finished with the Game class. Through this, I learned the beauty and conciseness of OOP, and this is how I will start my next projects, instead of functions. This project also enhanced by problem-chunking ability. From note-taking and pseudocode, I had a clearer picture of how I wanted to approach the project. I broke the problems into smaller, easier-to-solve problems, and built them backwards until the whole problem was solved. Finally, I started MasterMind with the correct skeleton for Project Management (from TOP), keeping the whole project in a cleaner and easier-to-manage workspace.