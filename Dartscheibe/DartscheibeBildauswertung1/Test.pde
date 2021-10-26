/*
Berechnung des Schnittpunktes des Pfeiles mit Dartscheibe.

TODO: 

    --> Schnittpunkt mit gerade für Spielboard fläche errechnen
*/

float CameraToSchnittpunkt(OpenCV opencv,     //OpenCV Objekt
                          PImage img,        //Bild zur Analyse
                          Detector bd,
                          int yAbschrankung, //Zur Ermittlung des Schnittpunktes über der scheibe
                          int yScheibe)     //Scheibenhöhe

{
  //Filter mit OpenCV
  opencv.loadImage(renderDifference(img,REF1,130));
  opencv.blur(30); //Rauschen reduzieren
  opencv.threshold(4); 
  
  image(opencv.getSnapshot(), 0, 0,displayWidth,displayHeight);
  //BlobDetection
  bd.imageFindBlobs(opencv.getSnapshot());
    bd.loadBlobsFeatures();
    bd.findCentroids();
    //Schnittpunktberechnung
    SchnittpunktAbschrankung(yAbschrankung);
    stroke(255, 0, 255); 
    return GeradenGleichung(yAbschrankung,SchnittpunktAbschrankung(yAbschrankung), bd , yScheibe);

}


/*
Berechnung des Schnittpunktes mit Abschrankung
Eingang: Begrenzungen y1,y2,y3 (global)
Ausgang: Schnittpunkt des Pfeiles mit der Abschrankung

TODO: 

*/


float SchnittpunktAbschrankung(int yAbschrankung)
{
  float SchnittX = 0;
  int Wert = 0;
  int zaehler = 0;
  
  //Schnittpunkte ermitteln mit Abschrankungsachse
  for(int i=1; i<displayWidth;i++)
  {    
    //println(get(i,yAbschrankung+1));
    if((get(i,yAbschrankung+1))==color(255))
    {
      zaehler ++;
      Wert = Wert+i;
    }    
  }
  if(zaehler>0)
  {//Schnittpunkt erkannt
    SchnittX = Wert/zaehler;
    stroke(20, 255, 25); 
    line(SchnittX,yAbschrankung+1,SchnittX,0);   
  }
  fill(0);
  text("Schnittpunkt "+SchnittX ,100,100);
  return SchnittX;
  
}



float GeradenGleichung(int yAbschrankung, float SchnittX, Detector bd, int yScheibe)
{
  float Steigung      = 0;//deltaY/deltaX
  int   BlobImBereich = 0;
  
  //For each blob in the image..
  for(int i = 0; i < bd.getBlobsNumber(); i++) {  
    stroke(255, 0, 255); 
    strokeWeight(5);  
    line(0,yAbschrankung,displayWidth,yAbschrankung); 
    if(bd.getCentroidY(i)<yAbschrankung)
    {
      fill(0, 0, 255);
      stroke(0, 0, 255);
      strokeWeight(20);      
      //...and draws a point to their location. 
      point(bd.getCentroidX(i), bd.getCentroidY(i));
      println(bd.getCentroidX(i), bd.getCentroidY(i));
      Steigung = Steigung + (yAbschrankung-bd.getCentroidY(i))/(bd.getCentroidX(i)-SchnittX);
      BlobImBereich++;
    }
  }
  
  println(BlobImBereich,Steigung);
  float SteigMittel = 0;
  SteigMittel = Steigung/BlobImBereich;
  println(SteigMittel);
  
  //Linie durch Pfeil zeichnen
  
  stroke(100, 0, 255);
  strokeWeight(8);
  //if(SteigMittel>0)
  stroke(255,0,0);
  line(SchnittX,yAbschrankung, SchnittX+((yAbschrankung-10)/SteigMittel) , 10);
  //if(SteigMittel<=0)
  //line(SchnittX,yAbschrankung, SchnittX-500 , 500*SteigMittel );
  stroke(0, 255, 255);
  line(0,yScheibe,displayWidth,yScheibe);
  
  //Geradengleichung
  //y=mx+n  --> n=y-mx
  float n =  -yAbschrankung - SteigMittel*SchnittX;
  println("f(x)= "+SteigMittel+" x + "+n);
  float ScheibeX = - ((-yScheibe-n)/-SteigMittel);
  text("Schnittpunkt Scheibe "+ScheibeX ,100,200);
  return ScheibeX;
}


PImage renderDifference(PImage A,PImage B, int sens)
{
        PImage DIFF = null;
        int width1 = A.width; 
        int width2 = B.width; 
        int height1 = A.height; 
        int height2 = B.height; 
  
        if ((width1 != width2) || (height1 != height2)) 
            System.out.println("Error: Images dimensions"+ " mismatch"); 
        else
        { 
            DIFF = new PImage(A.width,A.height);
            long difference = 0; 
            long differenceBefore = 0;
            DIFF.loadPixels();
            for (int y = 0; y < height1; y++) 
            { 
                for (int x = 0; x < width1; x++) 
                { 
                    color rgbA = A.get(x, y); 
                    int rgbB = B.get(x, y); 
                    //int redA = (rgbA >> 16) & 0xff; 
                    int redA = int(red(rgbA)); 
                    //int greenA = (rgbA >> 8) & 0xff; 
                    int greenA = int(green(rgbA));
                    //int blueA = (rgbA) & 0xff; 
                    int blueA = int(blue(rgbA));
                    //int redB = (rgbB >> 16) & 0xff; 
                    int redB = int(red(rgbB));
                    //int greenB = (rgbB >> 8) & 0xff; 
                    int greenB = int(green(rgbB));
                    //int blueB = (rgbB) & 0xff; 
                    int blueB = int(blue(rgbB));
                    
                    differenceBefore = difference;
                    difference += abs(redA - redB); 
                    difference += abs(greenA - greenB); 
                    difference += abs(blueA - blueB); 
                    
                    //println(difference);
                    if(abs(difference-differenceBefore)>sens)
                      DIFF.set(x, y, color(255)); 
                    else
                      DIFF.set(x, y, color(0));
                } 
            } 
            DIFF.updatePixels();
  
            // Total number of red pixels = width * height 
            // Total number of blue pixels = width * height 
            // Total number of green pixels = width * height 
            // So total number of pixels = width * height * 3 
            double total_pixels = width1 * height1 * 3; 
            println("total Pixels: "+total_pixels);
            // Normalizing the value of different pixels 
            // for accuracy(average pixels per color 
            // component) 
            double avg_different_pixels = difference / total_pixels; 
            println("AVG : "+avg_different_pixels);
            // There are 255 values of pixels in total 
            double percentage = (avg_different_pixels / 255) * 100; 
  
            System.out.println("Difference Percentage-->" + percentage); 
            
            
        }
        return DIFF;
}
 
