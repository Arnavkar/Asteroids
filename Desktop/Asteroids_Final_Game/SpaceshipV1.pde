class SpaceshipV1{

PVector shipLocation,shipAcceleration,shipVelocity;
float rotationSpeed,speed,RamSpeed,multiplier;
float direction,k,y,alpha; // k and y are used for arc generation - see later
int LastFire,FireDelayTime;
int g=20; // used in colour of the ship
int lives;
boolean justSpawned; // used to determine ship invulnerability when spawning
boolean moveForward, moveLeft, moveRight, shoot,Ram; // booleans for movement

  SpaceshipV1(float startX, float startY, float startAngle, int startLives){
    shipLocation = new PVector(startX, startY);
    shipVelocity = new PVector();
    shipAcceleration = new PVector();
    direction=startAngle;
    lives=startLives;
    speed = 0.95;
    RamSpeed=20;
    rotationSpeed=0.05;
    FireDelayTime=300;
    k=0;
    alpha=255;
    multiplier=0.3;
    justSpawned=true;

  }  

void drawShip(int colour) { // function to draw ship
 
  push(); 
  translate(shipLocation.x,shipLocation.y);
  rotate(direction);
  beginShape();
    
    if(Ram){ // when initiating Ram, ship colour changes. when Ram ends, reverts to original colour
      g=g+10;
    } else {
      g=g-10;
      g=constrain(g,20,255);
    }  
  fill(colour,g,255-colour);
  strokeWeight(1);
  stroke(255);
  vertex(20, 0);
  vertex(-20, 10);
  vertex(-10, 0);
  vertex(-20, -10);
  endShape(CLOSE);
  
pop();  
}

void updateShip(){ // function for ship movement
  shipAcceleration.x=0;
  shipAcceleration.y=0;
  
    if(moveForward){
      shipAcceleration.x = multiplier*cos(direction); 
      shipAcceleration.y = multiplier*sin(direction); // allows for movement wherever ship points
     }
 
    if(moveLeft){
    direction+= -rotationSpeed;
    }

    if(moveRight){
    direction+= rotationSpeed;
    }
    
    if(shoot){ //sets 500ms as the time between each bullet fired
      if(millis() - LastFire > FireDelayTime){
        LastFire = millis();  // sets a timer so that bullets are fired at specific intervals
        fireBullet(shipLocation,shipVelocity,direction); // this function captures the ship Values to be applied to the bullet
      }
     
    }
    
    if(Ram){

       push();
        stroke(20,g,20,alpha);
        strokeWeight(5);
        noFill();
        arc(shipLocation.x,shipLocation.y,60,60,0,k);
        k+=(2*PI)/60; //draw an arc representing the charge , arc takes 2 seconds to complete
       pop();       
         if(k>2*PI){ // k as my timer since k increases as a fraction of PI and starts at 0 everytime the Ram function restarts
           moveLeft=false;
           moveRight=false;
           shoot=false;
           alpha=0; // used for the arc'stransparency so it disappears when the ship fires
           shipVelocity=PVector.fromAngle(direction).mult(RamSpeed);
           if(k>3*PI){ // after 1 second of firing forward, ship stops moving and Ram reverts to false
             shipVelocity = new PVector(0,0);
             Ram=false;
             }    
           }
         
    }else if(!Ram){
    k=0; // resets k to 0
    alpha=255;
  }

    shipVelocity.add(shipAcceleration); // adding relevant vectors for ship movement
    shipLocation.add(shipVelocity);
    shipVelocity.mult(speed); // speed is less than 0.95. When continuously run, causes ship to slow to a halt
 
 //ship reappears when leaving boundary
    
   if(shipLocation.x > width+20 ){
      shipLocation.x = -20;
   }else if(shipLocation.x < -20){
       shipLocation.x = width+20;
   }
   
   if(shipLocation.y > height+20){
     shipLocation.y = -20;
   }else if(shipLocation.y <-20){
     shipLocation.y = height+20;
   }
}

PVector returnLocation(){ // function to return ship Location
  return shipLocation;
  }
PVector returnVelocity(){ // function to return shipVelocity
  return shipVelocity;
}
void bounceBack(){ // function for bounce back when ships collide
 shipVelocity=PVector.fromAngle(direction+PI).mult(10);
}  

void invul(){  //This function determines invul - when the white arc is present, the ship is invulnerable, to prevent it from being hit by asteroids the moment it spawns
       push();
        stroke(255,alpha);
        strokeWeight(5);
        noFill();
        arc(shipLocation.x,shipLocation.y,60,60,0,y);
        y+=(2*PI)/60;
       pop();       
          if(y>2*PI){ // k as my timer since k increases as a fraction of PI and starts at 0 everytime the Ram function restarts
           justSpawned=false; //after 2 seconds, arc disappears and invulnerability is turned off
           alpha=0;
           y=0;
         }
        }
        
 boolean shipInvul(){ // function to return ship invulnerability
  return justSpawned;
 }
 void loseALife(){ // function to lose 1 life
  lives-=1;
 }
 void loseAllLives(){ // function to lose all lives when Rammed
  lives=0;
 }
 int returnLives(){ // function that returns number of lives
  return lives;
 }
 
 //Movement functions to set Booleans to true or false in keypressed/keyreleased
 void setMoveForward(boolean input){ 
   moveForward=input;
 }
 void setMoveRight(boolean input){
   moveRight=input;
 }
 void setMoveLeft(boolean input){
   moveLeft=input;
 }
 void setShoot(boolean input){
   shoot=input;
 }
 void setRam(boolean input){
   Ram=input;
 }
 
 
}

 
