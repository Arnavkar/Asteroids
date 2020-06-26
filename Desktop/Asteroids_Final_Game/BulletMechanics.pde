class Bullet{
  PVector bulletLocation,bulletVelocity;
  float bulletSpeed;
  int bulletSize;
 
 Bullet(){
   bulletLocation = new PVector(-100,100); //sets the bullet's starting location far out of the window
   bulletVelocity = new PVector();
   bulletSpeed = 7;
   bulletSize=8;
  }
 
 void drawBullet(){ // function responsible for drawing Bullet
   updateBullet();
   push();
    fill(255,140,0);
    noStroke();
    ellipseMode(CENTER);
    ellipse(bulletLocation.x,bulletLocation.y,bulletSize,bulletSize);
   pop();
  }
 
 
  void updateBullet(){ // function for moving bullet
     bulletLocation.add(bulletVelocity);
    }
    
 PVector returnLocation(){ // function returning bullets Location
   return bulletLocation;
 }
  
 void getValues(PVector position, PVector velocity, float orientation){ // this function is used with fireBullet() to apply ship Values to the bullet when it is fired
   bulletLocation = new PVector(position.x,position.y);
   bulletVelocity.x = (bulletSpeed * cos(orientation)) + velocity.x;
   bulletVelocity.y = (bulletSpeed * sin(orientation)) + velocity.y;   
   }
   
 int returnBulletRadius(){ // returns bullet Radius for collision testing
  return (bulletSize/2);
 }  

}

    
   
    
   
