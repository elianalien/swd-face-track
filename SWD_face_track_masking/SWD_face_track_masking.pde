import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
PImage darth, ackbar;

void setup() {
  size(640, 480);
  
  darth = loadImage("Darth.png");
  ackbar = loadImage("Ackbar.png");
  
  video = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();
}

void draw() {
  
  video.loadPixels();
    scale(-1,1);
    translate(-width,0);
  video.updatePixels();
  
  image(video, 0, 0);
  opencv.loadImage(video);    
  
  Rectangle[] faces = opencv.detect();
  println(faces.length);
  
  for (int i = 0; i < faces.length; i++) {
    println("x: " + faces[i].x + " , " + "y: "+ faces[i].y);
    if (faces[i].x < 200){
      float scaling = 1.5;
      float shiftedX = faces[i].x - ((faces[i].width)*(scaling -1)/2);
      float shiftedY = faces[i].y - ((faces[i].height)*(scaling -1)/2);
      
      image(darth,shiftedX, shiftedY, faces[i].width*scaling, faces[i].height*scaling);
    }
    else {
      float scaling = 1.5;
      float shiftedX = faces[i].x - ((faces[i].width)*(scaling -1)/2);
      float shiftedY = faces[i].y - ((faces[i].height)*(scaling -1)/2);
      
      image(ackbar,shiftedX, shiftedY, faces[i].width*scaling, faces[i].height*scaling);
    }
  }
}

void captureEvent(Capture c) {
  c.read();
}