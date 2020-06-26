class GameScreens{ // object that handles all game Screens
  PFont arcade;
  int score;
  
  GameScreens(){
      score=0;
      arcade = createFont("arcade.ttf",32);
      textFont(arcade);
  }
  
  
  void startScreen(){ // function for start Screen
    textAlign(CENTER);
    textSize(100);
    fill(20,255,20);
    text("Asteroids",width/2,(height/2)-250); // Header
    textSize(35);
    text("Press 1 for Single-Player Mode \n Press 2 for Multiplayer Mode",width/2,height/2); //text for Mode Selection
    fill(255);
    textSize(15);
    text("(Don't hit the asteroids and \n Ram each other for a quick win!)",width/2,height/2 + 80);
    textSize(15);
    fill(255,20,20);
    text("Player 1 \n Forward - UpArrowKey \n Left - LeftArrowKey \n Right - RightArrowKey \n shoot - DownArrowKey \n  Charge Ram - Hold ENTER", (width/2)-250,(height/2)+200);
    fill(20,20,255);
    text("Player 2 \n Forward - 'w' \n Left - 'a' \n Right - 'd' \n shoot - 's' \n Charge Ram - Hold 'r'", (width/2)+250,(height/2)+200);
  }
  
  void counter1(){ // function for the counter in onePlayer mode
    textAlign(CENTER);
    textSize(15);
    fill(255,20,20);
    text("Score:" + score + "\n Lives:" + player1.returnLives(),(width/2)-300,(height/2)-300);
  }

  void counter2(){ // function for Counter in twoPlayer mode (no score included)
    textAlign(CENTER);
    textSize(15);
    fill(20,20,255);
    text("\n Lives:" + player2.returnLives(),(width/2)+300,(height/2)-300);
    fill(255,20,20);
    text("\n Lives:" + player1.returnLives(),(width/2)-300,(height/2)-300);
  }
  
  void endScreen1(){ // function for onePlayer endScreen
    textAlign(CENTER);
    textSize(40);
    fill(255);
    text("Your Score:" + score + "\n Hit SpaceBar to play again", (width/2),(height/2));
  }
  
  void winScreen(){ // function for onePlayer endScreen if player wins
    textAlign(CENTER);
    textSize(40);
    fill(255);
    text("You Won! \n Your Score:" + score + "\n Hit SpaceBar to play again", (width/2),(height/2));
  } 
  
  
  void player1win(){// function for twoPlayer Endscreen where player 1 wins
   push();
     rectMode(CENTER);
     textAlign(CENTER);
     textSize(32);
      fill(255,20,20);
      rect(width/4,height/2,width/2,height);
      fill(20,20,255);
      rect(3*width/4,height/2,width/2,height);
      fill(255);
      text("Player 2 Loses", (3*width/4),(height/2));
      text("Player 1 Wins", (width/4),(height/2));
      text("Hit SpaceBar to play again", (width/2),(height/2)+200);
    pop(); 
  }
  
  void player2win(){// function for twoPlayer Endscreen where player 2 wins
    push();
     rectMode(CENTER);
     textAlign(CENTER);
     textSize(32);
      fill(255,20,20);
      rect(width/4,height/2,width/2,height);
      fill(20,20,255);
      rect(3*width/4,height/2,width/2,height);
      fill(255);
      text("Player 2 Wins!", (3*width/4),(height/2));
      text("Player 1 Loses", (width/4),(height/2));
      text("Hit SpaceBar to play again", (width/2),(height/2)+200);
    pop(); 
   }
   
  void addScore(){// add to score function, 10 points for each asteroid shot
    score+=10;
  }
  
  int returnScore(){ //function that returns the score
    return score;
  }
}
  
