class Slice {
  int yini;
  int ySize;
  PImage img;
  PImage imgSlice;      
  float vel;
  float xVel;
  float xPos;
  float yPos;
  float sign; 
  float seed;
  float iter = 0;
  float t = 100;
     
  Slice(int yiniTemp, int ySizeTemp, PImage imgTemp) {
    yini = yiniTemp;
    ySize = ySizeTemp;
    img = imgTemp;
    imgSlice = createImage(img.width,ySize,ARGB);
//    vel = 0;
//    xVel = 0;
// 
    sign = random(-1,1);
    sign = sign/abs(sign);
    seed = random(0,100);
    yPos = yini;
   // yPos = 1.5*(height-img.height) + yini;
 
    int p = 0;
    for (int i = 0; i < img.height; i++) {
       if((i >= yini) & (i < yini + ySize)){
      for (int j = 0; j < img.width; j++) {
       // if((j >= yini) & (j < yini + ySize)){
          imgSlice.pixels[p] = img.pixels[j+i*img.width];
          p +=1;        
        }
      }
    }
  }
   
  void update() {
//    xVel+=vel;
//    if(t > 50){
//      //iter+=0.0001;
//    }
//    xPos = 0.5*(width-img.width) + xini + xVel + sign*noise(seed + iter)*img.width/3;
//    vel*=0.95;
//    t+=1;
  }
     
  void paint(int state, float positionX) {
    
    float drawAtX;
    if (state == 0) {
      println("eyes are in the box, let's draw at: " + width/2 + " minus " +imgSlice.width/2);
      drawAtX = width/2;
    } else {
      drawAtX = positionX;
    };
      
    
    //compensate for center of image
    drawAtX = drawAtX - imgSlice.width/2;
    println("drawing at " +yPos);
    image(imgSlice,drawAtX,yPos);
  }
   
  void checkMove() {
//    if(t > 50){
//      float diff = (xPos + 0.5*xSize) - mouseX;
//      if((diff >= 0) & (diff < 0.5*xSize))
//      {
//        vel = 5;
//        t = 0;
//      }
//      if((diff < 0) & (-diff < 0.5*xSize))
//      {
//        vel = -5;
//        t = 0;
//      }
//    }
  }
 
}

