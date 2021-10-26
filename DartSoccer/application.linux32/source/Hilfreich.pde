
boolean VergleichStringArray(String[] x,String[] y)
// return true bei Gleichheit der StringArrays
{
  if(x.length == y.length)
  {
    boolean gleich=false;
    boolean ungleich=false;
    
    for(int i=0; i<x.length;i++)
    {
      if(x[i].equals(y[i]) == true)
        gleich = true;
      else
        ungleich = true;
    }
    if(gleich==true && ungleich==false)
      return true;
    else
      return false;
    
  }
  else
  {
  //println("VerleichStringArray: Definierte Größe nicht gleich!");
  return false;
  }
}


//Funktion String aus txt T20 return int 60
int PunkteStringToInt(String x)
{
  int y=0;
  switch (x)
  {
    case "1":
      y = 1;
      break;
    case "2":
      y = 2;
      break;
    case "3":
      y = 3;
      break;
    case "4":
      y = 4;
      break;
    case "5":
      y = 5;
      break;
    case "6":
      y = 6;
      break;
    case "7":
      y = 7;
      break;
    case "8":
      y = 8;
      break;
    case "9":
      y = 9;
      break;
    case "10":
      y = 10;
      break;
    case "11":
      y = 11;
      break;
    case "12":
      y = 12;
      break;
    case "13":
      y = 13;
      break;
    case "14":
      y = 14;
      break;
    case "15":
      y = 15;
      break;
    case "16":
      y = 16;
      break;
    case "17":
      y = 17;
      break;
    case "18":
      y = 18;
      break;
    case "19":
      y = 19;
      break;
    case "20":
      y = 20;
      break;

    case "D1":
      y = 2;
      break;
    case "D2":
      y = 4;
      break;
    case "D3":
      y = 6;
      break;
    case "D4":
      y = 8;
      break;
    case "D5":
      y = 10;
      break;
    case "D6":
      y = 12;
      break;
    case "D7":
      y = 14;
      break;
    case "D8":
      y = 16;
      break;
    case "D9":
      y = 18;
      break;
    case "D10":
      y = 20;
      break;
    case "D11":
      y = 22;
      break;
    case "D12":
      y = 24;
      break;
    case "D13":
      y = 26;
      break;
    case "D14":
      y = 28;
      break;
    case "D15":
      y = 30;
      break;
    case "D16":
      y = 32;
      break;
    case "D17":
      y = 34;
      break;
    case "D18":
      y = 36;
      break;
    case "D19":
      y = 38;
      break;
    case "D20":
      y = 40;
      break;

      
    case "T1":
      y = 3;
      break;
    case "T2":
      y = 6;
      break;
    case "T3":
      y = 9;
      break;
    case "T4":
      y = 12;
      break;
    case "T5":
      y = 15;
      break;
    case "T6":
      y = 18;
      break;
    case "T7":
      y = 21;
      break;
    case "T8":
      y = 24;
      break;
    case "T9":
      y = 27;
      break;
    case "T10":
      y = 30;
      break;
    case "T11":
      y = 33;
      break;
    case "T12":
      y = 36;
      break;
    case "T13":
      y = 39;
      break;
    case "T14":
      y = 42;
      break;
    case "T15":
      y = 45;
      break;
    case "T16":
      y = 48;
      break;
    case "T17":
      y = 51;
      break;
    case "T18":
      y = 54;
      break;
    case "T19":
      y = 57;
      break;
    case "T20":
      y = 60;
      break;
    
    
    case "25":
      y = 25;
      break;
    case "50":
      y = 50;
      break;
      
      
    case "":
      y = -1; //Dokument leer prüfen!
      break;
  }
  return y;
}

//Globale Bildvariablen
PImage img_pfeil; 
PImage img_header;
PImage[] img_header1 = new PImage[13] ;

void BilderLaden()
{
   for(int i = 0; i<12 ; i++)
   {
     img_header1[i] = loadImage("Bilder/Header"+(i+1)+".jpg");
   }
   img_header = img_header1[int(random(0,12))];
   img_pfeil = loadImage("Bilder/Pfeil.png");
}
