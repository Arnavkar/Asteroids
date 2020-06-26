//Name: Arnav Shirodkar
//Email: as9086@bad.edu
//Date: 18/12/19
//Collaboration Statement: I worked on this largely alone, consulting Michael Ventoso once regarding movement and going online to find exmaples while problem solving


NightSky background; 
SpaceshipV1 player1;
SpaceshipV1 player2;
GameScreens bob; //Just for fun!

ArrayList<Bullet> bullets; // I used Arraylist so that my array length was entirely dynamic
ArrayList<Asteroid> asteroids;
int intAsteroidNum,bulletIndex;
boolean startScreen, onePlayer, twoPlayer;

void setup(){
  size(800,800); 
  background = new NightSky(); // initialize nightsky
  player1 = new SpaceshipV1(width/2-200,height/2,0,3); // initialize both ships
  player2 = new SpaceshipV1(width/2+200,height/2,PI,3);

  bulletIndex=0;
  bullets = new ArrayList<Bullet>(); // creates dynamic array for the bullets
    for (int i = 0; i <20; i++){
      bullets.add(new Bullet());  // creates 20 bullets -> these are recycled by BOTH ships
    }  
    
  intAsteroidNum=8; // initial number of Asteroids 
  PVector astStart = new PVector(0,0);
  asteroids = new ArrayList<Asteroid>();
    for(int i =0; i<intAsteroidNum;i++){
      asteroids.add(new Asteroid(astStart,1)); // sets asteroidType to 1
  
  bob = new GameScreens();
  startScreen=true; // begins with start Screen
  onePlayer=false;
  twoPlayer=false;
  }
}

void draw(){
 if(startScreen){ // startScreen shows nightsky and Asteroids as an interactive start Screen
   background.createStars();
   for(int i = 0; i<asteroids.size();i++){
    asteroids.get(i).moveAsteroid();
    asteroids.get(i).drawAsteroid();
  }
    bob.startScreen();
 }
 
if(onePlayer){ // if one player Mode is started
  background.createStars();
  player1.drawShip(255); // draw only 1 ship
  player1.updateShip();
  
  if(player1.shipInvul()==true){ // if invul is true, do invul function to draw arc
    player1.invul();
  }else if(player1.shipInvul()==false){ // in invul is false, enable collision functions
     BulletAsteroidCollision();
     ship1AsteroidCollision();
  }
  
  for (int i = 0; i < bullets.size(); i++){
    bullets.get(i).drawBullet();
    }
  for(int i = 0; i<asteroids.size();i++){
    asteroids.get(i).moveAsteroid();
    asteroids.get(i).drawAsteroid();
    }
  bob.counter1(); // draw onePlayer Counter
 }
 
if(twoPlayer){ // if twoPlayer mode is started
  background.createStars();
  player1.drawShip(255); // draw both ships
  player1.updateShip();
  player2.drawShip(0);
  player2.updateShip();
  
  if(player1.shipInvul()==true){ // handle invul functions for both ships
    player1.invul();
  }else if(player1.shipInvul()==false){
    ship1AsteroidCollision();
    BulletAsteroidCollision(); 
    shipShipCollision();
  }

   if(player2.shipInvul()==true){
    player2.invul();
  }else if(player2.shipInvul()==false){
    ship2AsteroidCollision();
    BulletAsteroidCollision(); // I run two instances of Bullet asteriod and shipship collision for situations where either ship is in invul state
    shipShipCollision();
  }
 
  for (int i = 0; i < bullets.size(); i++){
    bullets.get(i).drawBullet();
    }
  for(int i = 0; i<asteroids.size();i++){
    asteroids.get(i).moveAsteroid();
    asteroids.get(i).drawAsteroid();
    }
  bob.counter2();
 }


  if(bob.returnScore() > (intAsteroidNum*10*3)-1){
    bob.winScreen(); // if max score is reached, show OnePlayer win Screen!
  }else if(onePlayer==true && player1.returnLives() <= 0){ // use <= 0 because sometimes glitches causes lives to go to -1 before 0
    onePlayer=false;
    bob.endScreen1();  //if all lives lost, show onePlayer endScreen
  }else if(twoPlayer==true && player1.returnLives() <= 0 ){
    twoPlayer=false;
    bob.player2win(); // if player1 loses all lives, show Player2 winscreen
  }else if(twoPlayer==true && player2.returnLives()<=0){
    twoPlayer=false;
    bob.player1win(); //if player2 loses all lives, show Player1 winscreen
 }
}

void keyPressed(){ // ALL MOVEMENT BOOLEANS ARE SET USING KEY PRESSED AND KEY RELEASED
     if(key==CODED)
      if (keyCode == UP){
        player1.setMoveForward(true);
      }if (keyCode == LEFT){
        player1.setMoveLeft(true);
      }if (keyCode == RIGHT){
        player1.setMoveRight(true);
      }if(keyCode == DOWN){
       player1.setShoot(true);
      }if(keyCode == ENTER){
       player1.setRam(true);
      
   } else {
     if(key=='w'){
       player2.setMoveForward(true);
     }if(key=='a'){
       player2.setMoveLeft(true);
     }if(key=='d'){
       player2.setMoveRight(true);
     }if(key=='s'){
       player2.setShoot(true);
     }if(key=='r'){
       player2.setRam(true);
   }
  }
   
  
  if(key == '1'){ // sets the keys used to start one player or two player modes
    startScreen=false;
    onePlayer=true;
  }else if (key =='2'){
    startScreen=false;
    twoPlayer=true;
  }
}
  
  
   
void keyReleased(){
     if(key == CODED)
      if (keyCode == UP){
        player1.setMoveForward(false);
      }if (keyCode == LEFT){
        player1.setMoveLeft(false);
      }if (keyCode == RIGHT){
        player1.setMoveRight(false);
      }if (keyCode == DOWN){
        player1.setShoot(false);
      }if (keyCode == ENTER){
        player1.setRam(false);
   } else {
    
     if(key=='w'){
       player2.setMoveForward(false);
     }if(key=='a'){
       player2.setMoveLeft(false);
     }if(key=='d'){
       player2.setMoveRight(false);
     }if(key=='s'){
       player2.setShoot(false);
     }if(key=='r'){
       player2.setRam(false);
     
    }
   }
    
  if(key == ' '){ // restarts the entire game, going back to startScreen
    setup();
  }
  
}

void fireBullet(PVector position, PVector velocity, float direction) { 
  bullets.get(bulletIndex).getValues(position, velocity, direction);  // attaches ship values to the bullet according to the bullet index value
  bulletIndex++;  //update index, calls the next bullet
  bulletIndex %= bullets.size();  //keeps index in range of the the length of the array
  }   


void BulletAsteroidCollision(){ // collision function for bullets and asteroids
  for(int i=0; i<asteroids.size();i++){
    for(int j=0; j<bullets.size();j++){
     try{ 
      PVector distanceVect = PVector.sub(asteroids.get(i).returnLocation(),bullets.get(j).returnLocation());
      float distanceVectMag = distanceVect.mag();
      float collisionRadius = (asteroids.get(i).returnAsteroidRadius()) - (bullets.get(i).returnBulletRadius());

      if(distanceVectMag<collisionRadius){
         bob.addScore(); // if successful, add score
        if(asteroids.get(i).returnType()<2){ // if asteroid type is 1, 
          asteroids.get(i).makeSecondary(); // make next asteroid type 2
          // create 2 new asteroids of smaller size
          asteroids.add(new Asteroid(asteroids.get(i).returnLocation(),asteroids.get(i).returnType()));
          asteroids.add(new Asteroid(asteroids.get(i).returnLocation(),asteroids.get(i).returnType()));
          // delete original asteroid
          asteroids.remove(i);
        }else{ // if asteroid type is already 2, just delete the asteroid
          asteroids.remove(i);
        }
        // delete the bullet, and add a new one to the array to ensure bullets dont run out
        bullets.remove(j);
        bullets.add(new Bullet());
       }
     } catch (IndexOutOfBoundsException e){} // catch Out of Bounds Exception
   }
 }
}

void ship1AsteroidCollision(){ // player1 and asteroid collision function
  for(int i=0;i<asteroids.size();i++){
      PVector distanceVect1 = PVector.sub(asteroids.get(i).returnLocation(),player1.returnLocation());
      float distanceVect1Mag = distanceVect1.mag();
      float collisionRadius = (asteroids.get(i).returnAsteroidRadius()) + 15; // used 15 arbitrarily based on trial and error
      if(distanceVect1Mag < collisionRadius){
        player1.loseALife(); // if successful, lose 1 life
        player1 = new SpaceshipV1(width/2-200,height/2,0, player1.returnLives()); // respawn player 1
        
        } 
       }
      }
    
void ship2AsteroidCollision(){// player2 and asteroid collision function
  for(int i=0;i<asteroids.size();i++){
    PVector distanceVect2 = PVector.sub(asteroids.get(i).returnLocation(),player2.returnLocation());
      float distanceVect2Mag = distanceVect2.mag();
      float collisionRadius = (asteroids.get(i).returnAsteroidRadius()) + 15;
       if(distanceVect2Mag<collisionRadius){
        player2.loseALife();// if succesful, lose 1 life
        player2 = new SpaceshipV1(width/2+200,height/2,PI,player2.returnLives()); // respawn player 2
        
      }
     }
    }
  
void shipShipCollision(){ // function for ships bumping
      PVector distanceVect = PVector.sub(player2.returnLocation(),player1.returnLocation());
      float distanceVectMag = distanceVect.mag();
      float collisionRadius = 40; // based on trial and error
      if(distanceVectMag < collisionRadius && player2.returnVelocity().mag()>player1.returnVelocity().mag() && player2.returnVelocity().mag()>12){
        player1.loseAllLives(); // if player 2 rams player 1 at high enough speed, player 1 is destroyed
        }else if(distanceVectMag < collisionRadius && player1.returnVelocity().mag()>player2.returnVelocity().mag() && player1.returnVelocity().mag()>15){
        player2.loseAllLives();// if player 1 rams player 1 at high enough speed, player 2 is destroyed
        }else if(distanceVectMag < collisionRadius && player1.returnVelocity().mag()<15 && player2.returnVelocity().mag()<10 ){
         player1.bounceBack(); // if the ships touch with insufficient velocity, execute the bounce back function
         player2.bounceBack(); // this can be used to knock players into asteroids
        }
}
     
    
  


  

   
