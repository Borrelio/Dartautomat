import processing.video.*;
import gab.opencv.*;
import blobscanner.*;

Detector DCAM1, DCAM2, DCAM3;
OpenCV   CVCAM1,CVCAM2,CVCAM3;
Capture  CAM1,  CAM2,  CAM3;
PImage   REF1;

PImage CAM1Statisch;

String[] cameras = Capture.list();
  
//###############EINSTELLUNGEN#####################
//Abschrankung in Y Richtung
int yAbschrankung1=506;
int yScheibe1     =536;
int yAbschrankung2=530;
int yScheibe2     =560;
int yAbschrankung3=440;
int yScheibe3     =470;
//#################################################

//***************************************************************************************************************
void setup(){
//size(700,1080);
fullScreen();


 // Zuodnung zu den Cameras fehlt noch...............................

    CAM1Statisch = loadImage("Schraeg5.jpg");
    CAM1 = new Capture( this,1920,1080,  cameras[2]);//1=3
    CAM1.start();
    CAM1.read();
    println("Kamera Breite: "+CAM1.width);
    println(displayHeight,displayWidth);
    CVCAM1 = new OpenCV(this, CAM1.width, CAM1.height);  
    DCAM1 = new Detector( this, 255 );
    
    REF1 = new Capture(this, 1920, 1080);
    REF1=CAM1.copy();
    
    //noLoop();
}
//****************************************************************************************************************
void draw(){
  CAM1.read();
  CameraToSchnittpunkt(CVCAM1, CAM1 , DCAM1 , yAbschrankung1, yScheibe1);

  
}

void mousePressed() {
  
  {
    CAM1.read();
    REF1=CAM1.copy();    
    image(REF1, 0, 0,displayWidth,displayHeight);
    println("Abschrankungen"+mouseY+"***********************************************************************************");
    
  }
}
  
