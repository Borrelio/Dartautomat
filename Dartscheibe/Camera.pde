import processing.video.*;
import gab.opencv.*;
import blobscanner.*;

Detector bd1,bd2,bd3;

OpenCV   DIFF1,DIFF2,DIFF3;
Capture  CAM1,CAM2,CAM3;
PImage   REF1,REF2,REF3;
PImage   RESULT1,RESULT2,RESULT3;

float X1mw,X2mw,X3mw,Y1mw,Y2mw,Y3mw;

void CameraInit()
{
  String[] cameras = Capture.list();
  if (cameras == null) 
  {
    println("Fehler beim Aufbau einer Kameraverbindung");
    CAM1 = new Capture(this, 640, 480);
  } 
  else if (cameras.length == 0) 
  {
    println("Es stehen keine Kameras zur Verfügung.");
    exit();
  } 
  else 
  {//Verbindungsaufbau erfolgreich!
    println("Verfügbare Kameras:");
    printArray(cameras);
    
    CAM1 = new Capture(this, cameras[0]);
    REF1 = new Capture(this, 640, 480);
    CAM1.start();
    DIFF1 = new OpenCV(this, CAM1);  
    
    
    CAM2 = new Capture(this, cameras[3]);
    REF2 = new Capture(this, 640, 480);
    CAM2.start();
    DIFF2 = new OpenCV(this, CAM2);  
    
    CAM3 = new Capture(this, cameras[2]);
    REF3 = new Capture(this, 640, 480);
    CAM3.start();
    DIFF3 = new OpenCV(this, CAM3);  
        
  }
}

void DrawCameras()
{
  CAM1.read();
  CAM2.read();
  CAM3.read();
  image(CAM1, 150, 100, 600, 100);
  image(CAM2, 150, 400, 600, 100);
  image(CAM3, 150, 700, 600, 100);
  textSize(25);
  fill(255);
  text("CAM1",40,125);
  fill(255);
  text("CAM2",40,425);
  fill(255);
  text("CAM3",40,725);
  
}

void CamSetReferenz()
{
  CAM1.read();
  CAM2.read();
  CAM3.read();
  REF1=CAM1.copy();
  REF2=CAM2.copy();
  REF3=CAM3.copy();
  image(REF1, 150, 200, 600, 100);
  image(REF2, 150, 500, 600, 100);
  image(REF3, 150, 800, 600, 100);
  textSize(18);
  fill(255);
  text("REF1",40,225);
  fill(255);
  text("REF2",40,525);
  fill(255);
  text("REF3",40,825);
}

void CamFindDiff()
{ //CAM1***********************************************************************************************************************************
  CAM1.read();
  DIFF1 = new OpenCV(this, CAM1); 
  DIFF1.diff(REF1);
  DIFF1.threshold(80);
  RESULT1 = DIFF1.getSnapshot();
  image(RESULT1, 150, 300,600,100);
  textSize(18);
  fill(255);
  text("DIFF1",40,325);
  //BlobDetection
  bd1 = new Detector( this, 255 );
  RESULT1.filter(BLUR);
  RESULT1.filter(THRESHOLD);
  bd1.imageFindBlobs(RESULT1);
  bd1.loadBlobsFeatures();
  //Computes the blob center of mass.
  bd1.findCentroids();
  //For each blob in the image..
  X1mw =0;
  Y1mw =0;
  for(int i = 0; i < bd1.getBlobsNumber(); i++) 
  {
    X1mw =  (bd1.getCentroidX(i) + X1mw);
    Y1mw =  (bd1.getCentroidY(i) + Y1mw);
  }
  X1mw =  X1mw/bd1.getBlobsNumber();
  Y1mw =  Y1mw/bd1.getBlobsNumber();
  //...and draws a point to their location. 
  point(X1mw, Y1mw);
  //...computes and prints the centroid coordinates x y to the console...
  println("CENTROID X COORDINATE IS " + X1mw);
  println("CENTROID Y COORDINATE IS " + Y1mw);
  stroke(20);
  stroke(204, 102, 0);
  fill(255,0,0);
  line(150+X1mw ,300,150+X1mw ,400);
  text("X:"+int(X1mw),840,250);
  
  //CAM2***********************************************************************************************************************************
  CAM2.read();
  DIFF2 = new OpenCV(this, CAM2); 
  DIFF2.diff(REF2);
  DIFF2.threshold(80);
  RESULT2 = DIFF2.getSnapshot();
  image(RESULT2, 150, 600,600,100);
  textSize(18);
  fill(255);
  text("DIFF2",40,625);
  //BlobDetection
  bd2 = new Detector( this, 255 );
  RESULT2.filter(BLUR);
  RESULT2.filter(THRESHOLD);
  bd2.imageFindBlobs(RESULT2);
  bd2.loadBlobsFeatures();
  //Computes the blob center of mass.
  bd2.findCentroids();
  //For each blob in the image..
  X2mw =0;
  Y2mw =0;
  for(int i = 0; i < bd2.getBlobsNumber(); i++) 
  {
    X2mw =  (bd2.getCentroidX(i) + X2mw);
    Y2mw =  (bd2.getCentroidY(i) + Y2mw);
  }
  X2mw =  X2mw/bd2.getBlobsNumber();
  Y2mw =  Y2mw/bd2.getBlobsNumber();
  //...and draws a point to their location. 
  point(X2mw, Y2mw);
  //...computes and prints the centroid coordinates x y to the console...
  println("CENTROID X COORDINATE IS " + X2mw);
  println("CENTROID Y COORDINATE IS " + Y2mw);
  stroke(20);
  stroke(204, 102, 0);
  fill(255,0,0);
  line(150+X2mw ,600,150+X2mw ,700);
  text("X:"+int(X2mw),840,550);
  //CAM3***********************************************************************************************************************************
  CAM3.read();
  DIFF3 = new OpenCV(this, CAM3); 
  DIFF3.diff(REF3);
  DIFF3.threshold(80);
  RESULT3 = DIFF3.getSnapshot();
  image(RESULT3, 150, 900,600,100);
  textSize(18);
  fill(255);
  text("DIFF3",40,925);
  //BlobDetection
  bd3 = new Detector( this, 255 );
  RESULT3.filter(BLUR);
  RESULT3.filter(THRESHOLD);
  bd3.imageFindBlobs(RESULT3);
  bd3.loadBlobsFeatures();
  //Computes the blob center of mass.
  bd3.findCentroids();
  //For each blob in the image..
  X3mw =0;
  Y3mw =0;
  for(int i = 0; i < bd3.getBlobsNumber(); i++) 
  {
    X3mw =  (bd3.getCentroidX(i) + X3mw);
    Y3mw =  (bd3.getCentroidY(i) + Y3mw);
  }
  X3mw =  X3mw/bd3.getBlobsNumber();
  Y3mw =  Y3mw/bd3.getBlobsNumber();
  //...and draws a point to their location. 
  point(X3mw, Y3mw);
  //...computes and prints the centroid coordinates x y to the console...
  println("CENTROID X COORDINATE IS " + X3mw);
  println("CENTROID Y COORDINATE IS " + Y3mw);
  stroke(20);
  stroke(204, 102, 0);
  fill(255,0,0);
  line(150+X3mw ,900,150+X3mw ,1000);
  text("X:"+int(X3mw),840,850);
}
