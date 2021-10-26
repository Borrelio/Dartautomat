import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.io.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class DartSoccer extends PApplet {

PFont   headerFont;
PFont   pageFont;


boolean Windows = false;
boolean Linux   = false;

int Aktualisierung = 0;
boolean Pfeileingabe = false;

float StartZeit_s;

//§§§§§§§§§§§DATEI PFADE$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
String[] Pfade = new String[50];

String StandardPfad;
String Pfad_Punkte     = "";
String Pfad_Spielmodi  = "";
String Pfad_Status     = "";
String Pfad_Teilnehmer = "";
String Pfad_Player     = "";

int Betriebssystem; //(1 Linux32/2 Linux64/3 Raspi/4 Windows32/5 Windows64)
boolean EXE     = false; //Ermittlung ob Programm von IDE oder EXE gestartet für Dateipfade

public void settings()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
{
 //Test zur relativen Pfadangabe
  //übergeordneten Ordner ermittteln um relativen Pfad festzulegen
  //unterschiede bei Übersetzter datei
  //#################funktioniert nur mit trennzeichen unter Windows!!!!! Noch abändern für Linux
  //Analyse auf Trennzeichen ob Linux oder Windows
  println("Der Dateipfad des Sketches ist: " + sketchPath());
  String Pfad = sketchPath();
  String sketch = getClass().getName(); // Name des Sketches zum Vergleich im Pfad
  println("Der Sketch hat den Namen: "+ sketch);
  
  //Betriebssystem ermitteln
  String os = System.getProperty("os.name");
  if (os.contains("Windows")) {
    // os-specific setup and config here
    println("Als Betriebssystem wird Windows erkannt");
    Windows = true;

  } else if (os.contains("Linux")) {
    println("Als Betriebssystem wird Linux erkannt");
    Linux= true;
  } else {
    println("Fehler! Betriebssystem kann nicht erkannt werden. (Linux/Windows)");
  }
  String[] PfadAttribute = {}; 
  if(Windows == true)
    PfadAttribute = split(Pfad,'\\');
  else if(Linux == true)
    PfadAttribute = split(Pfad,'/');
    
    String AbsolutPfad = "" ;
    //relativen Pfad angeben, je nach Ausführung des Programmes
    if( PfadAttribute[PfadAttribute.length-1].equals(sketch) == true ) 
    {
      
      println("Programm wird von der Processing IDE ausgeführt!");
      for(int i=0; i<PfadAttribute.length-1 ; i++)
      {
        AbsolutPfad = AbsolutPfad + PfadAttribute[i];
        AbsolutPfad = AbsolutPfad +"/";
      }
      println("Absolute Pfadangabe Projektordner: "+AbsolutPfad);      
      StandardPfad = AbsolutPfad+"DartsINOUT/";
      EXE = false;
    }
    else
    {
      println("Programm wird kompiliert als EXE ausgeführt!");
      for(int i=0; i<PfadAttribute.length-2 ; i++)
      {
        AbsolutPfad = AbsolutPfad + PfadAttribute[i];
        AbsolutPfad = AbsolutPfad +"/";
      }
      println("Absolute Pfadangabe Projektordner: "+AbsolutPfad);      
      StandardPfad = AbsolutPfad+"DartsINOUT/";
      EXE = true;
    }
  
  
  Pfade = loadStrings( StandardPfad+"Einstellungen.OUT" );
  
  //Dateipfade laden
          Pfad_Punkte     = StandardPfad+Pfade[4];
          Pfad_Spielmodi  = StandardPfad+Pfade[6];
          Pfad_Status     = StandardPfad+Pfade[8];
          Pfad_Teilnehmer = StandardPfad+Pfade[10];
          Pfad_Player     = StandardPfad+Pfade[22];
  //Einstellungen laden
          int screen_setting = PApplet.parseInt(Pfade[29]);
               Betriebssystem = PApplet.parseInt(Pfade[35]);

  //size(1200,displayHeight);
  println(sketch+" wird im Bildschirm "+screen_setting+ " ausgeführt!");

  switch(screen_setting)
  {
    case 1: fullScreen(1); break;
    case 2: fullScreen(2); break;
    case 3: fullScreen(3); break;
  }  
    
}

public void setup()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{

  BilderLaden();
  //if(Betriebssystem==3)//Raspberry Hardware für Licht
    LichtKonfiguration();
  headerFont = createFont("EraserDust.ttf", 70);
  pageFont   = createFont("Eraser.ttf", 80); 
  frameRate(1);
}


public void draw()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{

  //Aktualisierung von DartScorer als Event
  String[] AktualisierungString = loadStrings( Pfad_Status );

  if ( AktualisierungString!= null)
  {
    try
    {
      if(PApplet.parseInt(AktualisierungString[3]) == 1 ) //Fehler Array out of Bounds Exception 3
      {                                     //...gleichzeitiges lesen und schreiben
        Aktualisierung = 0;
        AktualisierungString[3]= "0";
        saveStrings( Pfad_Status, AktualisierungString);      
      }
      if(PApplet.parseInt(AktualisierungString[5]) == 1 )                        
        Pfeileingabe = true;    
      else
        Pfeileingabe = false;  
      if(PApplet.parseInt(AktualisierungString[7]) == 1) //Programm beenden wenn zum Hauptmenu gewechselt wird
        exit();
    }
    catch (Exception e)
    {
      Aktualisierung = 1;
      println("####Abfangen des Fehlers gleichzeitig lesen/schreiben bei Aktualisierung!####");
    }
  }
  else
    println("Problem: Keine Angaben zum Status vorhanden");
    
    
    
    
    
    header();
    //Zeitbalken
    
    int ZeitProzent = PApplet.parseInt( ((millis()*0.001f-StartZeit_s)   / (Spielmodus.Zeit*60 )) *100);
    fill(255,100);
    rect(displayWidth*0.8f,displayHeight*0.13f,displayWidth*0.16f,displayHeight*0.78f);
    fill(255);   
    if(ZeitProzent > 60)
      fill(0xffFAF24C);
    if(ZeitProzent > 85)
      fill(0xffFF2946);   
    rect(displayWidth*0.8f,displayHeight*0.13f, displayWidth*0.16f, (ZeitProzent*displayHeight*0.78f)/100);
    fill(255,10,10);
    println(millis()*0.001f-StartZeit_s);
    println(Spielmodus.Zeit*60);
    println(   ((millis()*0.001f-StartZeit_s)   / (Spielmodus.Zeit*60 )) *100 );
  
  //Nur wenn Eingabe über DartMenu erfolgt, wird Programmschleife abgearbeitet!
  if(Aktualisierung < (180))
  {
    //println("Hauptprogrammschleife Dartscorer x mal ausführen.");
    Aktualisierung++;
    
    
    Spielmodus.Aktualisieren();    
    SpielerNeuAnlegen();
    
    

      
    for(int i = 1; i<=AnzahlTeilnehmer;i++)
    {

        //println(i);
        Player[i].card(); 

    }


    GewinnerHintergrund();
  }
}


public void mousePressed() //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{
  //Test

  StartZeit_s = millis()*0.001f;
}


public void header()
{
  //Zeichnet Header und Hintergrundbild
  textSize(70);
  image(img_header, 0, 0, displayWidth,displayHeight );
  fill(0);
  noStroke();
  rect(0,0,displayWidth,displayHeight*0.1f);
  for(int i=0;i<200;i++)
  { 
    fill(255,100-(i*0.5f));
    rect(0,(displayHeight*0.1f)+i,displayWidth,3);
  }
  fill(255);


  textFont(headerFont);
  textAlign(LEFT);
  text("SOCCER  | "+Spielmodus.Zeit+" MIN ",displayWidth*0.035f,80);
  textAlign(LEFT);
  textFont(pageFont);
}

public void GewinnerHintergrund()
{
 
  for(int i = 1; i<=AnzahlTeilnehmer;i++)
  {
 
    if(Player[i].Gewonnen == true )
    {
      //println("Gewinner Background");
      fill(0);
      rect(0,0,displayWidth,displayHeight);
      textAlign(CENTER);
      textSize(100);
      fill(255);
      text(Player[i].Name +" gewinnt das Spiel!",displayWidth/2,displayHeight/2);
      img_header = img_header1[PApplet.parseInt(random(0,12))];
    }

  }
}

public boolean VergleichStringArray(String[] x,String[] y)
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
public int PunkteStringToInt(String x)
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

public void BilderLaden()
{
   for(int i = 0; i<12 ; i++)
   {
     img_header1[i] = loadImage("Bilder/Header"+(i+1)+".jpg");
   }
   img_header = img_header1[PApplet.parseInt(random(0,12))];
   img_pfeil = loadImage("Bilder/Pfeil.png");
}



  SPI spi;
  int value ;
  int value_left;
  int value_right;
  int config ;
  byte[] DAC_OUT = {0,0} ;
  
  boolean FehlerLicht = false;
  
  //PINOUT
  int RGB1R = 2;
  int RGB1G = 3;
  int RGB1B = 4;
  int RGB2R = 17;
  int RGB2G = 27;
  int RGB2B = 22;
  int RGB3R = 18;
  int RGB3G = 23;
  int RGB3B = 24;
  
//**********************************************************  
public void LichtKonfiguration()
{
  if (null == (spi = new SPI(SPI.list()[1])) || Windows == true)
    FehlerLicht = true;
  if (FehlerLicht == false)
  {
    spi.settings(500000, SPI.MSBFIRST, SPI.MODE0);
    //für CS SPI Pin
    GPIO.pinMode(5, GPIO.OUTPUT);
    GPIO.pinMode(6, GPIO.OUTPUT);
    //für einfache Ansteurung des Mosfet
    GPIO.pinMode(RGB2R, GPIO.OUTPUT);
    GPIO.pinMode(RGB2G, GPIO.OUTPUT);
    GPIO.pinMode(RGB2B, GPIO.OUTPUT);
    GPIO.pinMode(RGB1R, GPIO.OUTPUT);
    GPIO.pinMode(RGB1G, GPIO.OUTPUT);
    GPIO.pinMode(RGB1B, GPIO.OUTPUT);
    GPIO.pinMode(RGB3R, GPIO.OUTPUT);
    GPIO.pinMode(RGB3G, GPIO.OUTPUT);
    GPIO.pinMode(RGB3B, GPIO.OUTPUT);
    
    
    GPIO.digitalWrite(5,GPIO.HIGH);
    GPIO.digitalWrite(6,GPIO.HIGH);
    
  }
  else
    println("Lichtansteuerung wird nich ausgeführt!");
}

//**********************************************************
public void AussenLicht (int Rot, int Gruen, int Blau)
{
  //Integer Werte nur von 0-255 akzeptabel
  if (FehlerLicht == false)
  {
      //R______________________________________
      //KanalB DAC2
      GPIO.digitalWrite(5,GPIO.LOW);
      value = Rot;
      value_left = value >> 4;
      value_right = ((value << 4) & 0xf0);
      config = 0x90;
      value_left = config | value_left;
      DAC_OUT[0] = PApplet.parseByte(value_left);
      DAC_OUT[1] = PApplet.parseByte(value_right);
      spi.transfer(DAC_OUT);
      GPIO.digitalWrite(5,GPIO.HIGH);
      //ENDE___________________________________
      
      //G______________________________________
      //KanalB DAC1
      GPIO.digitalWrite(6,GPIO.LOW);
      value = Gruen;
      value_left = value >> 4;
      value_right = ((value << 4) & 0xf0);
      config = 0x90;
      value_left = config | value_left;
      DAC_OUT[0] = PApplet.parseByte(value_left);
      DAC_OUT[1] = PApplet.parseByte(value_right);
      spi.transfer(DAC_OUT);
      GPIO.digitalWrite(6,GPIO.HIGH);
      //ENDE___________________________________
      
      //B______________________________________
      //KanalA DAC2
      GPIO.digitalWrite(5,GPIO.LOW);
      value = Blau;
      value_left = value >> 4;
      value_right = ((value << 4) & 0xf0);
      config = 0x10;
      value_left = config | value_left;
      DAC_OUT[0] = PApplet.parseByte(value_left);
      DAC_OUT[1] = PApplet.parseByte(value_right);
      spi.transfer(DAC_OUT);
      GPIO.digitalWrite(5,GPIO.HIGH);
      //ENDE___________________________________
  }
}

//**********************************************************
public void InnenLichtLinks(boolean Rot, boolean Gruen, boolean Blau)
{
  if(Rot == false)
    GPIO.pinMode(RGB1R, GPIO.HIGH);
  else
    GPIO.pinMode(RGB1R, GPIO.LOW);  
  if(Gruen == false)
    GPIO.pinMode(RGB1G, GPIO.HIGH);
  else
    GPIO.pinMode(RGB1G, GPIO.LOW);  
  if(Blau == false)
    GPIO.pinMode(RGB1B, GPIO.HIGH);
  else
    GPIO.pinMode(RGB1B, GPIO.LOW);
}

//**********************************************************
public void InnenLichtRechts(boolean Rot, boolean Gruen, boolean Blau)
{
  if(Rot == false)
    GPIO.pinMode(RGB3R, GPIO.HIGH);
  else
    GPIO.pinMode(RGB3R, GPIO.LOW);  
  if(Gruen == false)
    GPIO.pinMode(RGB3G, GPIO.HIGH);
  else
    GPIO.pinMode(RGB3G, GPIO.LOW);  
  if(Blau == false)
    GPIO.pinMode(RGB3B, GPIO.HIGH);
  else
    GPIO.pinMode(RGB3B, GPIO.LOW);
}

//**********************************************************
public void InnenLichtOben(boolean Rot, boolean Gruen, boolean Blau)
{
  if(Rot == false)
    GPIO.pinMode(RGB2R, GPIO.HIGH);
  else
    GPIO.pinMode(RGB2R, GPIO.LOW);  
  if(Gruen == false)
    GPIO.pinMode(RGB2G, GPIO.HIGH);
  else
    GPIO.pinMode(RGB2G, GPIO.LOW);  
  if(Blau == false)
    GPIO.pinMode(RGB2B, GPIO.HIGH);
  else
    GPIO.pinMode(RGB2B, GPIO.LOW);
}

//**********************************************************
public void InnenLicht(boolean R, boolean G, boolean B)
{
    InnenLichtLinks(R,G,B);
    InnenLichtRechts(R,G,B);
    InnenLichtOben(R,G,B);
}



String[]    Teilnehmer        = new String[9]  ;
String[]    Datenbank_Player  = new String[9]  ;
Spieler[]   Player            = new Spieler[9] ;
int         AnzahlTeilnehmer                   ;
int         AnzahlAllerSpieler                 ;


public void SpielerNeuAnlegen()
{
  String[] TeilnehmerVergleich= new String[9];
  TeilnehmerVergleich = loadStrings(Pfad_Teilnehmer);  
  if(TeilnehmerVergleich==null) //Dokument nicht vorhanden
    ;                           //mache nichts!
  else                          //Wenn vorhanden Spieler anlegen
  {
      boolean gleich = VergleichStringArray(Teilnehmer,TeilnehmerVergleich);   //<>//
      if(gleich==true)
        ; //<>//
      else
      {
        Teilnehmer = loadStrings(Pfad_Teilnehmer);
        
        AnzahlTeilnehmer = Teilnehmer.length;
        
        //Anzahl Aller vorhanden Spieler in Datenbank ermitteln
        for(int i = 1; i<30 ; i++)
        {
          String[] TextDokument= loadStrings(Pfad_Player+i+".INOUT");
          if ((TextDokument==null))
          {
            AnzahlAllerSpieler = i-1;
            break;
          } 
        }
        
        for(int i=1;i<=AnzahlTeilnehmer;i++)
        {
          int DatenbankIndex = 1;
          for(int k=1;k<=AnzahlAllerSpieler;k++)
          {         
          //Datenbank durchsuchen nach Namen des Teilnehmers
          Datenbank_Player = loadStrings(Pfad_Player+k+".INOUT");
          
              
             if(Teilnehmer[i-1].equals(Datenbank_Player[1]) == true)
             {
               DatenbankIndex = k;
             }
             //println(Teilnehmer[i-1],Datenbank_Player[1],DatenbankIndex);
          }         
          //if(DatenbankIndex>0) // Spieler in Datenbank gefunden
          //{
              switch (i)
              {
              case 1:
                 Datenbank_Player = loadStrings(Pfad_Player+DatenbankIndex+".INOUT");
                 Player[1] = new Spieler(Datenbank_Player[1],Datenbank_Player[3],i);
                 break;    
              case 2:
                 Datenbank_Player = loadStrings(Pfad_Player+DatenbankIndex+".INOUT");
                 Player[2] = new Spieler(Datenbank_Player[1],Datenbank_Player[3],i);
                 break; 
              case 3:
                 Datenbank_Player = loadStrings(Pfad_Player+DatenbankIndex+".INOUT");
                 Player[3] = new Spieler(Datenbank_Player[1],Datenbank_Player[3],i);
                 break; 
              case 4:
                 Datenbank_Player = loadStrings(Pfad_Player+DatenbankIndex+".INOUT");
                 Player[4] = new Spieler(Datenbank_Player[1],Datenbank_Player[3],i);
                 break; 
              case 5:
                 Datenbank_Player = loadStrings(Pfad_Player+DatenbankIndex+".INOUT");
                 Player[5] = new Spieler(Datenbank_Player[1],Datenbank_Player[3],i);
                 break; 
              case 6:
                 Datenbank_Player = loadStrings(Pfad_Player+DatenbankIndex+".INOUT");
                 Player[6] = new Spieler(Datenbank_Player[1],Datenbank_Player[3],i);
                 break; 
              case 7:
                 Datenbank_Player = loadStrings(Pfad_Player+DatenbankIndex+".INOUT");
                 Player[7] = new Spieler(Datenbank_Player[1],Datenbank_Player[3],i);
                 break; 
              case 8:
                 Datenbank_Player = loadStrings(Pfad_Player+DatenbankIndex+".INOUT");
                 Player[8] = new Spieler(Datenbank_Player[1],Datenbank_Player[3],i);
                 break; 
              }
          //}
          //else
          //  println("Datenbank inkonsistent!");
        }
      }
  }
}


//*************************************************************************
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
public class Spieler
{
  boolean Gewonnen;
  
  boolean Ballbesitz ;
  int     Tore;
  float   Quote;

  String  Name;
  boolean Aktiv;        //Spieler spielt
  int     Rangfolge;    //1 ist aktueller Spieler
  
  int   Farbe = color(255,0,10);
  int     Siege;
  int     transp = 0;
  
  
  //Konstruktor++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Spieler(String NameDesSpielers, String FarbeInt, int Rang)
  {
    Name = NameDesSpielers;
    Rangfolge = Rang;
    Farbe = PApplet.parseInt(FarbeInt);
    Siege = 0;
 
        Gewonnen   = false;
      
  }
  //Methoden+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  public void card()
  { 
     if(Pfeileingabe == true )
     {
       fill(255,200);
       rect(displayWidth*0.035f,(displayHeight*0.2f*(Rangfolge*0.5f))+displayHeight*0.03f,displayWidth*0.75f,displayHeight*0.08f);
       fill(Farbe);
       rect(displayWidth*0.035f,(displayHeight*0.2f*(Rangfolge*0.5f))+displayHeight*0.03f,displayWidth*0.155f,displayHeight*0.08f);
       fill(0);
       textSize(70);
       text(Name, displayWidth*0.2f,(displayHeight*0.2f*(Rangfolge*0.5f))+displayHeight*0.1f);
       
       textSize(90);
       text(Tore, displayWidth*0.52f,(displayHeight*0.2f*(Rangfolge*0.5f))+displayHeight*0.1f);
       fill(130);
       textSize(60);
       text(Quote, displayWidth*0.62f,(displayHeight*0.2f*(Rangfolge*0.5f))+displayHeight*0.1f);
       
       //Beschriftung
       fill(240);
       textSize(60);
       text("TORE", displayWidth*0.49f,(displayHeight*0.2f*(AnzahlTeilnehmer*0.5f))+displayHeight*0.17f);
       text("QUOTE", displayWidth*0.62f,(displayHeight*0.2f*(AnzahlTeilnehmer*0.5f))+displayHeight*0.17f);
       text("ZEIT", displayWidth*0.85f,(displayHeight*0.2f*(AnzahlTeilnehmer*0.5f))+displayHeight*0.17f);
       
       if(Ballbesitz == true)
       {
         stroke(10);
         strokeWeight(4);
         fill(0);
         noFill();
         rect(displayWidth*0.035f,(displayHeight*0.2f*(Rangfolge*0.5f))+displayHeight*0.03f,displayWidth*0.75f,displayHeight*0.08f);
         noStroke();
         PImage img; 
         img = loadImage("Bilder/Ball.png");    
         image(img, 40, (displayHeight*0.2f*(Rangfolge*0.5f))-displayHeight*0.025f, 200,200 );
       }
        
     }
     else // Siege anzeigen zwischen den Spielen
     {
       boolean SiegeAnzeigen = false;
       for(int i = 1; i<=AnzahlTeilnehmer;i++)
       {
         if(Player[i].Siege > 0 )
           SiegeAnzeigen = true;       
       }
       if( SiegeAnzeigen == true)
       {
         for(int i = 1; i<=AnzahlTeilnehmer;i++)
         {
           int Teilung = PApplet.parseInt((displayHeight*0.78f)/(AnzahlTeilnehmer+1));
           int Verteilung = i;
           if(AnzahlTeilnehmer>4)
           {
              textAlign(CENTER);
              textSize(80);         
              fill(20,30);
              rect(displayWidth*0.28f,displayHeight*0.16f,displayWidth*0.43f,Teilung);
              fill(230);
              text("SIEGE",displayWidth*0.49f,displayHeight*0.23f-((AnzahlTeilnehmer-8)*10));
              textAlign(LEFT);
              fill(100,110);
              rect(displayWidth*0.28f,displayHeight*0.16f+Verteilung*Teilung,displayWidth*0.43f,Teilung);
              fill(Player[i].Farbe,170);
              rect(displayWidth*0.28f,displayHeight*0.16f+Verteilung*Teilung,40,Teilung);
              fill(255);
              text(Player[i].Name,displayWidth*0.31f,displayHeight*0.23f+Verteilung*Teilung);
              textAlign(RIGHT);
              text(Player[i].Siege,displayWidth*0.68f,displayHeight*0.235f+Verteilung*Teilung);
           }
           else
           {
              textAlign(CENTER);
              textSize(80);         
              fill(20,30);
              rect(displayWidth*0.28f,displayHeight*0.16f,displayWidth*0.43f,Teilung);
              fill(230);
              text("SIEGE",displayWidth*0.49f,displayHeight*0.23f-((AnzahlTeilnehmer-8)*10));
              textAlign(LEFT);
              fill(100,110);
              rect(displayWidth*0.28f,displayHeight*0.16f+Verteilung*Teilung,displayWidth*0.43f,Teilung);
              fill(Player[i].Farbe,170);
              rect(displayWidth*0.28f,displayHeight*0.16f+Verteilung*Teilung,40,Teilung);
              fill(255);
              text(Player[i].Name,displayWidth*0.31f,displayHeight*0.27f+Verteilung*Teilung);
              textAlign(RIGHT);
              text(Player[i].Siege,displayWidth*0.68f,displayHeight*0.27f+Verteilung*Teilung);             
           }
         }
       }
     }
  }
  
  
  //Interne Methoden++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //protected 
  protected void RangAktualisieren()
  {
    //Rang bei Wiederholung neu sortieren
    
  }
 
  
  protected  void Gewonnen()
  {
    println("***************** "+Name+" gewinnt das Spiel! ********************");
    //weitere Aktionen

    Gewonnen = true;
    
  }
}


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

public void ResetPunkte()
{
  for(int i=1;i<=AnzahlTeilnehmer;i++)
  {

        Player[i].Gewonnen   = false;
  }
}
String[] Spielmodi = new String[10];
Modi Spielmodus = new Modi();

public class Modi
{
  int Startwert; //301, 501,...
  int IN;        //1 Single 2 Doppel 
  int OUT;       //1 Single 2 Doppel 3 Master -OUT
  int Zeit;
  
  //Konstruktor++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Modi()
  {
  }
  Modi( int zeit)
  {
     Zeit = zeit;
  }
  //***********************************************************************
  public void Aktualisieren()
  {
    String[] SpielmodiVergleich = new String[8];
    SpielmodiVergleich = loadStrings( Pfad_Spielmodi);
    if(SpielmodiVergleich==null)
      ;
    else
    {
      boolean gleich = VergleichStringArray(Spielmodi,SpielmodiVergleich);
    
      if(gleich==true)
      ;
      else//wird einmal ausgeführt wenn Datei Spielmodi.INOUT verändert wird
      {
        Spielmodi = loadStrings(Pfad_Spielmodi);    
        Spielmodus = new Modi(PApplet.parseInt(Spielmodi[5]));  
      }
    }
  }
  
  
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "DartSoccer" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
