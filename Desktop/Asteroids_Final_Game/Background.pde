class NightSky{ // object that create a starry background
  float[]x = new float [400];
  float[]y = new float [400];
  float[]r = new float[400];
  float speedx,speedy;
  
  NightSky(){
    background(0);
    for(int i=0;i<x.length;i++){
      x[i] = random(0,width);
      y[i] = random(0,height);
      r[i] = random(2,4); // stars vary slightly in size
    }
  }
    
    void createStars(){
      background(0);
      for(int i=0;i<x.length;i++){
        fill(255);
        ellipseMode(CENTER);
        ellipse(x[i],y[i],r[i],r[i]);
        speedx = random(-0.2,0.2);
        speedy = random(-0.2,0.2);// stars move slightly to make the background look non-static
        x[i]=x[i]+speedx;
        y[i]=y[i]+speedy;
  }
 }
}
