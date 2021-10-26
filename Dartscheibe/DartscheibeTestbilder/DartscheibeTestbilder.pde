/**
 * Getting Started with Capture.
 * 
 * Reading and displaying an image from an attached Capture device. 
 */

import processing.video.*;

Capture cam;
int i=0;

void setup() {
  size(1920, 1080);

  String[] cameras = Capture.list();

  if (cameras == null) {
    println("Failed to retrieve the list of available cameras, will try the default...");
    cam = new Capture(this, 1920, 1080);
  } else if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    printArray(cameras);

    // The camera can be initialized directly using an element
    // from the array returned by list():
    cam = new Capture(this, 1920, 1080, cameras[1]);
    // Or, the settings can be defined based on the text in the list
    //cam = new Capture(this, 640, 480, "Built-in iSight", 30);
    
    // Start capturing the images from the camera
    cam.start();
  }
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0, width, height);
 
}

void mousePressed() {
  if ((mouseX > 80) && (mouseX<180) && (mouseY > 1000) && (mouseY<1050))
  {
    i++;
    String Bildbeschriftung= "Bildbeschriftung"+i;
    cam.save(Bildbeschriftung);
    fill(255);
    rect(80,1000,100,50);
  }
}
