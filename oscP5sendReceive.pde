/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;
import java.awt.Rectangle; 

OscP5 oscP5;
NetAddress myRemoteLocation;
float positionX;
float positionY;
PImage img;
int n = 233;
float howManySecondsPerCheck = .1;
int timer = 0;
int maxSlices = 256;
int currentSlice = 0;
Slice[] slice = new Slice[maxSlices];
//head coordinates
Rectangle head; 
int headTopCornerX = 150;
int headTopCornerY = 0; 
int headWidth = 200;
int headHeight = 200; 
int state; 
//this is where you would throw in the pupil data from dan's code
//int pupilX, pupilY;
boolean enabled; 

void setup() {

  img = loadImage("test.jpg");
  size(img.width*2, img.height+ 2*img.height/3);
  background(0);
  println(img.height);
  frameRate(25);
  for (int i = 0; i < n; i++) {
    slice[i] = new Slice(int(i*img.height/n), int(img.height/n), img);
  }
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 8338);
  myRemoteLocation = new NetAddress("localhost", 8338);
  headTopCornerX = width/2 - headWidth/2;
  headTopCornerY = width/2 + headWidth/2;
  head = new Rectangle (headTopCornerX, 0, headWidth, headHeight);
}

void draw() {

  positionX = mouseX; 
  positionY = mouseY; 
  fill(255); 
  //rectMode(CENTER);
  //rect (head.x, head.y, head.width, head.height); 

  //only do all this stuff if someone is ready to go
  if (enabled) {

    fill (255, 0, 50); 
    ellipse (positionX, positionY, 10, 10); 

    //println ("state: " + state); 
    rect (head.x, head.y, head.width, head.height); 
    //do stuff here depending on state
    switch (state) {    
    case 0: 
      fill(100, 0, 50); 
      //rectMode(CENTER);
      rect (head.x, head.y, head.width, head.height); 
      // println ("enabled, eye is in zone"); 
      //draw the face
      break; 

    case 1: 
      //  println("enabled, eye is left of zone"); 
      //glitch to the left
      break; 

    case 2:
      //     println ("enabled, eye is right of zone"); 
      //glitch to the right
      break;
    }
  } 
  else {
    println ("DISABLED");
  }

  //use mousepressed as on/off button
  if (mousePressed) {
    enabled = false;
  } 
  else {
    enabled = true;
  }

  //if the pupil is in the head box .. 
  if (head.contains(positionX, positionY)) {
    state = 0; 

    //if the pupil is left of the head
  } 
  else if (positionX < head.x) {
    state = 1; 

    //if the pupil is right of the head
  } 
  else if (positionX > head.x + head.width) {
    state = 2;
  }

  //  for (int i = 0; i < n; i++) {
  //    //slice[i].update();
  //    //slice[i].checkMove();
  //    slice[i].paint();
  //  }

  timer++;
  if (timer > howManySecondsPerCheck*25) {
    if (currentSlice < n) {
      slice[currentSlice].paint(state, positionX);  


      currentSlice++;

      timer =0;
    }
  }
}


void mousePressed() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/test");

  myMessage.add(123); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  println(" values: "+theOscMessage.typetag());
  if (theOscMessage.checkTypetag("ff")) {
    float OSCvalueX = theOscMessage.get(0).floatValue(); // get the second osc argument
    float OSCvalueY = theOscMessage.get(1).floatValue();
    println(" values: "+OSCvalueX);
    println(" values: "+OSCvalueY);
    positionX = OSCvalueX;
    positionY = OSCvalueY;
    return;
  }
}

