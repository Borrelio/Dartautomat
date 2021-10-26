/**
TODO:


-Anordnung der Kameras beim start
-Kalibrierung vor Beginn
  dazu Verbesserung der BlobDetection --> Pfeillage erkennen und Schnittpunkt auf Scheibe berechnen

 */

int radius = 700;

String[] Punktezahl;
boolean Test = false; //Slider für PunkteErkennung aktiv



//********************************************************************SETUP***************************************************************************************
void setup() 
{
  clear();
  background(100);
  //size(displayWidth, displayHeight); 
  fullScreen();
  if(Test==true)
  SliderInit(); //<>//
  else
  CameraInit();
  Punktezahl = new String[2];
}

//********************************************************************DRAW****************************************************************************************
void draw() {
  
  //Lösche Dartscheibe
  fill(100); 
  noStroke();
  rect(800,0,displayWidth,displayHeight); //<>//
  stroke(0); //<>//
   //<>//
  //Zeichne Dartscheibe und Cams //<>//
  fill(255,250,230);
  KreuzungInit(displayWidth/2+400,displayHeight/2+100);
  DartscheibeInit(displayWidth/2+400,displayHeight/2+100,radius); //<>//
   //<>//
   //<>//
  fill(255,250,230);
  textSize(200);
  
  //Test Schreiben in Datei
  Punktezahl[0]="Test";
  Punktezahl[1] = PunktezahlAusPosition(Schnittpunkte.PfeilX,Schnittpunkte.PfeilY);
  text(Punktezahl[1],1500,300); //<>//
  println(Schnittpunkte.PfeilX,Schnittpunkte.PfeilY);  //<>//
  //Test Schreiben in Datei

  
  fill(255,250,230);
  //INPUT für Kamera oder Slider im Testmodus
  if(Test==true)
  {//Slider Aktiv
    BerechneKreuzung(cam1.getValueF(),cam2.getValueF(),cam3.getValueF(),displayWidth/2+200,displayHeight/2+100);
  }
  else
  {//Kameras Aktiv
    DrawCameras();
    CamFindDiff();
    BerechneKreuzung((1.23*X1mw-400),(1.23*X2mw-400),(1.23*X3mw-400),displayWidth/2+200,displayHeight/2+100);
  }
  
  
  
  
  //*****Button Impro*****
  fill(0);
  rect(80,1000,100,50);
  
  //**********************
  
  delay(50); //Setzt Rechenleistung herrunter
}

void mousePressed() {
  if ((mouseX > 80) && (mouseX<180) && (mouseY > 1000) && (mouseY<1050))
  {
    CamSetReferenz();
    fill(255);
    rect(80,1000,100,50);
  }
}
