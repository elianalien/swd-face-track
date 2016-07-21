import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
PImage darth, ackbar;

void setup() {
  size(960, 540);
  //size(1280,720);
  surface.setResizable(true);
  smooth();
  //fullScreen();
  
  darth = loadImage("Darth.png");
  ackbar = loadImage("Ackbar.png");
  
  //String[] cameras = Capture.list();
  //if (cameras.length != 0){
  //  for (int i = 0; i < cameras.length; i++) {
  //    println(cameras[i]);
  //  }
  //}
  
  //video = new Capture(this, 640, 480);
  video = new Capture(this, 960,540);
  opencv = new OpenCV(this, 960,540);
  //opencv = new OpenCV(this,1280,720);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();
}

void draw() {
  if (video.width > 0 && video.height > 0){
    video.loadPixels();
      scale(-1,1);
      translate(-video.width,0);
    video.updatePixels();
    
    image(video, 0, 0);
    opencv.loadImage(video);    
    
    Rectangle[] faces = opencv.detect();
    //println(faces.length);
    
    for (int i = 0; i < faces.length; i++) {
      //println("x: " + faces[i].x + " , " + "y: "+ faces[i].y);
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
  
}

void captureEvent(Capture c) {
  c.read();
}