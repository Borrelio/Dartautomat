/*
Berechnung des Schnittpunktes 
Eingang: Cam1 X, Cam2 X, Cam3 X
Ausgang: SchnittpunktXY


TODO: Rückgabewert int --> float

*/
//###############EINSTELLUNGEN#####################
//Toleranzband bei gleichen Steigungen
float Toleranz = 0.5;
//Entfernung der Kameras (Fehler Durchmesser/Radius?)
int radius_cam = int(0.5*radius * 1.1);
//#################################################



public class  Schnittpunkt
{
          float X12;
          float Y12;
          float X13;
          float Y13;
          float X23;
          float Y23;
          
          int PfeilX;
          int PfeilY;
}
Schnittpunkt Schnittpunkte = new Schnittpunkt();

public class  CamMittelpunkt
{
          public float x;
          public float y;
}

CamMittelpunkt CamMittelpunkt1 = new CamMittelpunkt();
CamMittelpunkt CamMittelpunkt2 = new CamMittelpunkt();
CamMittelpunkt CamMittelpunkt3 = new CamMittelpunkt();


void KreuzungInit(int MittelpunktX, int MittelpunktY)
{
  //Darstellung der Cam
  int KreisRadius = 50;
  
  for(int i=0;i<3;i++)
  {
    if(i==0) 
      {
      CamMittelpunkt1.x = MittelpunktX+cos(radians(0))*radius_cam;
      CamMittelpunkt1.y = MittelpunktY-sin(radians(0))*radius_cam;
      circle(CamMittelpunkt1.x,CamMittelpunkt1.y, KreisRadius);
      textSize(25);
      fill(255);
      text("CAM1",CamMittelpunkt1.x+KreisRadius,CamMittelpunkt1.y);
      }
    if(i==1) 
      {
      CamMittelpunkt2.x = MittelpunktX+cos(radians(120))*radius_cam;
      CamMittelpunkt2.y = MittelpunktY-sin(radians(120))*radius_cam;
      circle(CamMittelpunkt2.x,CamMittelpunkt2.y, KreisRadius);
      textSize(25);
      fill(255);
      text("CAM2",CamMittelpunkt2.x,CamMittelpunkt2.y+KreisRadius);
      }      
     if(i==2) 
      {
      CamMittelpunkt3.x = MittelpunktX+cos(radians(240))*radius_cam;
      CamMittelpunkt3.y = MittelpunktY-sin(radians(240))*radius_cam;
      circle(CamMittelpunkt3.x,CamMittelpunkt3.y, KreisRadius);
      textSize(25);
      fill(255);
      text("CAM3",CamMittelpunkt3.x,CamMittelpunkt3.y+KreisRadius);
      }     
  }
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++HILSFUNKTIONEN+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
void lineAngle(float x, float y, float angle, float length)
{
  line(x, y, x+cos(angle)*length, y-sin(angle)*length);
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Schnittpunkt BerechneKreuzung( float XwertCam1 , float XwertCam2 , float XwertCam3 , int MittelpunktX ,int MittelpunktY  )
{
  float Winkel1 = -0.1125*XwertCam1;
  float Winkel2 = -0.1125*XwertCam2+120;
  float Winkel3 = -0.1125*XwertCam3+240;
  lineAngle(CamMittelpunkt1.x, CamMittelpunkt1.y, radians(180+Winkel1), 900.0);
  lineAngle(CamMittelpunkt2.x, CamMittelpunkt2.y, radians(180+Winkel2), 900.0);
  lineAngle(CamMittelpunkt3.x, CamMittelpunkt3.y, radians(180+Winkel3), 900.0);
  
  // Y = m X + n
  //Anstieg berechen m=dy/dX
  //dazu Startpunkt berechnen
  float X2Start = CamMittelpunkt2.x-MittelpunktX;
  float Y2Start = -(CamMittelpunkt2.y-MittelpunktY);
  //Ermittlung aus Winkel
  
  float m2 = (Y2Start / ( tan(radians(90-Winkel2)) * Y2Start)) ;
  
  float X3Start = CamMittelpunkt3.x-MittelpunktX;
  float Y3Start = -(CamMittelpunkt3.y-MittelpunktY);
  float m3 = -(Y3Start/ ( tan(radians(Winkel3-90)) * Y3Start)) ;
  
  float X1Start = CamMittelpunkt1.x-MittelpunktX;
  float Y1Start = -(CamMittelpunkt1.y-MittelpunktY);

  //float m1 = Y1Start/ ( tan(radians(90-Winkel1)) * Y1Start) ; //steigung so nicht mehr berechenbar nach drehung
  float m1 =  ( tan(radians(Winkel1)) * X1Start)/  X1Start ; 
  
  //Abhängigkeit: Gerade geht immer surch punkt XStart YStart
  float n1 = Y1Start - (( m1) * X1Start );
  float n2 = Y2Start - (( m2) * X2Start );
  float n3 = Y3Start - (( m3) * X3Start );
  
  println("f1(x)=y="+m1+" x+"+n1);
  println("f2(x)=y="+m2+" x+"+n2);
  println("f3(x)=y="+m3+" x+"+n3);
  
  //Schnittpunkte: Y = Y -->  auflösen nach  x
  //Gerade1 mir Gerade2
  Schnittpunkte.X12 = ((n1-n2)/(m2-m1));
  Schnittpunkte.Y12 = -(m1 * Schnittpunkte.X12 + n1);
  fill(100,100,100,100);
  circle(Schnittpunkte.X12+MittelpunktX,Schnittpunkte.Y12+MittelpunktY,10);
  //Gerade1 mir Gerade3
  Schnittpunkte.X13 = ((n1-n3)/(m3-m1));
  Schnittpunkte.Y13 = -(m1 * Schnittpunkte.X13 + n1);
  circle(Schnittpunkte.X13+MittelpunktX,Schnittpunkte.Y13+MittelpunktY,10);
  //Gerade2 mir Gerade3
  Schnittpunkte.X23 = ((n2-n3)/(m3-m2));
  Schnittpunkte.Y23 = -(m2 * Schnittpunkte.X23 + n2);
  circle(Schnittpunkte.X23+MittelpunktX,Schnittpunkte.Y23+MittelpunktY,10);

  //Mittelpunkt der Schnittpunkte
  Schnittpunkte.PfeilX = int(((Schnittpunkte.X12 + Schnittpunkte.X13 + Schnittpunkte.X23)/3)+MittelpunktX);
  Schnittpunkte.PfeilY = int(((Schnittpunkte.Y12 + Schnittpunkte.Y13 + Schnittpunkte.Y23)/3)+MittelpunktY);
  fill(#EDE600);
  //*********************************************************************************************************Auswertung erweitern
  //z.b Algorithmus Genauigkeit, annäherend gleiche Steigungungen bedeuten hohe abweichungen, weil Schnittpunkt zu weit weg liegt
  //..macht noch Probleme bei m2/m3

  if(((m1/m2)-1) < Toleranz && ((m1/m2)-1) > -Toleranz) //Toleranzband
  {
      Schnittpunkte.PfeilX = int(((Schnittpunkte.X13 + Schnittpunkte.X23)/2)+MittelpunktX);
      Schnittpunkte.PfeilY = int(((Schnittpunkte.Y13 + Schnittpunkte.Y23)/2)+MittelpunktY);
  }
  if(((m3/m2)-1) < Toleranz && ((m3/m2)-1) > -Toleranz) //Toleranzband
  {
      Schnittpunkte.PfeilX = int(((Schnittpunkte.X13 + Schnittpunkte.X12)/2)+MittelpunktX);
      Schnittpunkte.PfeilY = int(((Schnittpunkte.Y13 + Schnittpunkte.Y12)/2)+MittelpunktY);
  }
  if(((m1/m3)-1) < Toleranz && ((m1/m3)-1) > -Toleranz) //Toleranzband
  {
      Schnittpunkte.PfeilX = int(((Schnittpunkte.X12 + Schnittpunkte.X23)/2)+MittelpunktX);
      Schnittpunkte.PfeilY = int(((Schnittpunkte.Y12 + Schnittpunkte.Y23)/2)+MittelpunktY);
  }
  

  
  circle(Schnittpunkte.PfeilX,Schnittpunkte.PfeilY,20);
  
  return Schnittpunkte;
}
