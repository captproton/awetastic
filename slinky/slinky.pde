import processing.video.*;
Capture video;
color trackColor;
int wrX, wrY;
boolean acquireColor;
boolean testColor;
boolean sneekPeek;
int slinky = 25;

void setup() {
  size(800,600);
  // background(255);
  video = new Capture(this,width,height,15);
  trackColor = color(128,128,128);
  smooth();
}

void draw() {

  if (video.available()) {
    video.read();
  }
  video.loadPixels();
  
//pushMatrix();
//scale(-1.0, 1.0);
//image(video, -video.width,0);
//popMatrix();

  //////SGH
// background(0);
  // Before we begin searching, the "world record" for closest color is set to a high number that is easy for the first pixel to beat.
  float worldRecord = 1500;

  // XY coordinate of closest color
  int closestX = 0;
  int closestY = 0;

  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      int loc = (video.width - x - 1) + y *video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      // Using euclidean distance to compare colors
      float d = dist(r1,g1,b1,r2,g2,b2); // We are using the dist( ) function to compare the current color with the color we are tracking.

      // If current color is more similar to tracked color than
      // closest color, save current location and current difference
      if (d < worldRecord) {
        worldRecord = d;
        closestX = x;
        closestY = y;
      }
    }
  }

  // We only consider the color found if its color distance is less than 10. 
  // This threshold of 10 is arbitrary and you can adjust this number depending on how accurate you require the tracking to be.
  // if (worldRecord < 10) { 
  // // Draw a circle at the tracked pixel
  // fill(trackColor);
  // strokeWeight(4.0);
  // stroke(0);
  // ellipse(closestX,closestY,16,16);
  // }
  if (worldRecord < 10) { 
    // Draw a circle at the tracked pixel
    //fill(trackColor);
    //strokeWeight(4.0);
    //stroke(0);
    wrX = closestX;
    wrY = closestY;

    fill(trackColor);
    stroke(trackColor);
    ellipse(video.width-closestX,wrY,48,48);

    //training color mode
  }
  ///////SGH
  if(acquireColor) {
    fill(trackColor);
    ellipse(closestX,closestY,16,16);
    // int loc = x + y*video.width;
    //int loc = (video.width - mouseX - 1) + mouseY*video.width;
    int loc = mouseX + mouseY*video.width;
    
    
    trackColor = video.pixels[loc];
    textSize( 16 );
    fill(128);
    text( "Acqire an object by moving the mouse over it and pres 'a'", 10, 250 );
  }
  if(testColor) {
    fill(trackColor);
    ellipse(closestX,closestY,42,42);
    text( "confirm read 'c' when done", 10, 240 );
  }
  if(sneekPeek) {
//    pushMatrix();
//    scale(-1.0, 1.0);
    image(video, 0,0);
//    popMatrix();
    text( "press p to return DO NOT ACQUIRE IN SNEEK MODE", 10, 240 );
  }
  slinkys(closestX,closestY, pmouseX, pmouseY);
}

//switch

//SGH Target Mode
public void keyPressed() {
  switch (key) {
  case 'a': 
    acquireColor = !acquireColor; 
    break;
  case 't': 
    testColor = !testColor; 
    break;
  case 'p': 
    sneekPeek = !sneekPeek; 
    break;
  }
}

void slinkys(int x, int y, int px, int py) {
  if (mousePressed == true)
  {
    fill(0);
    fill(255); 
    if(keyPressed) 
      if (key == 'r' || key == 'r')
        fill(255,0,0);
    if (key == 'c' || key == 'c')
      fill(455);
      if (key == 'g' || key == 'g')
        fill(0,255,0);
      if (key == 'b' || key == 'b')
        fill(0,0,255);
    if(mousePressed) {
      ellipse(mouseX, mouseY, slinky, slinky);

      if(key == '*' || key == '*') {
        slinky = slinky+1;
      }
      else {
        
        slinky = 25;
      }
    }
  }

  ellipse(x,y,45,45);
}

