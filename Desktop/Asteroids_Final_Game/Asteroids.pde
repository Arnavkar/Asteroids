class Asteroid{
 
  PVector asteroidLocation,asteroidVelocity;
  PImage bigAsteroid,smallAsteroid;
  int asteroidSize, asteroidType;
  
  
  Asteroid(PVector location, int version){
    asteroidLocation = new PVector();
    asteroidVelocity = new PVector();
    asteroidType=version; // type 1 asteroid is large, type 2 asteroid is half the size
    imageMode(CENTER);
    bigAsteroid = loadImage("asteroid.png");
    smallAsteroid = loadImage("asteroid.png");
    bigAsteroid.resize(120,120);
    smallAsteroid.resize(60,60); // Use two different asteroid images so that a resizing problem does not occur where the same image has two resize functions
    asteroidSize = 80; // set Asteroid Size
     
     if(location.x == 0 && location.y ==0){ // give asteroids random starting positions
      asteroidLocation.x = random(width);
      asteroidLocation.y = random(height);
    } else {
      asteroidLocation.x = location.x;
      asteroidLocation.y = location.y;
    }
    
    asteroidVelocity.x = random(-4,4);
    asteroidVelocity.y = random(-4,4);        
  }
  
  void drawAsteroid(){ // function for drawing the an underlying ellipse which is used for collision detection and drawing the asteroid image on top
     ellipseMode(CENTER);
      noStroke();
      fill(200);
      ellipse(asteroidLocation.x,asteroidLocation.y,asteroidSize/asteroidType,asteroidSize/asteroidType); // this is a grey circle that will be used for collision detections;
   
     if(asteroidType==1){
      image(bigAsteroid,asteroidLocation.x,asteroidLocation.y);
     }else{
       image(smallAsteroid,asteroidLocation.x,asteroidLocation.y);
     }
    
      
    
  }
 void moveAsteroid(){ // function responsible for asteroid movement
   
   asteroidLocation.add(asteroidVelocity);
   
    if(asteroidLocation.x > width+40 ){
      asteroidLocation.x = -40;
   }else if(asteroidLocation.x < -40){
       asteroidLocation.x = width+40;
   }
   if(asteroidLocation.y > height+40){
     asteroidLocation.y =-40;
   }else if(asteroidLocation.y <-40){
     asteroidLocation.y = height+40;
   }
}

  
 PVector returnLocation(){ // returns Asteroids current location
  return asteroidLocation;
 }
 void makeSecondary(){ // changes Asteroid type - used for bullet-Asteroid Collision
  asteroidType+=1;
 }
  
 int returnType(){ // return Asteroid Type
  return asteroidType;
 }
 int returnAsteroidRadius(){ // return Asteroid Radius to find Collision Radius
  return ((asteroidSize/2)/asteroidType);
 }
}
 
