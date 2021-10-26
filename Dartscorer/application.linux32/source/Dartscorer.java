import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import at.mukprojects.console.*; 
import processing.io.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Dartscorer extends PApplet {


Console console;

//§§§§§§§§§§§ Variablen $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
String[] Pfade = new String[50];
String StandardPfad;
String Pfad_Punkte     = "";
String Pfad_Spielmodi  = "";
String Pfad_Status     = "";
String Pfad_Teilnehmer = "";
String Pfad_Player     = "";

PFont   headerFont;
PFont   pageFont;

int Betriebssystem;      // (1 Linux32/2 Linux64/3 Raspi/4 Windows32/5 Windows64)
boolean EXE     = false; // Ermittlung ob Programm von IDE oder EXE gestartet für Dateipfade
boolean Windows = false;
boolean Linux   = false;

int     Aktualisierung = 0;
boolean Pfeileingabe   = false;

boolean OutputStream     = false;
int     Lichtansteuerung = 0;

public void settings()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
{
  Pfadermittlung();
  Einstellungen();    
}

public void setup()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{
  // Initialisierung der internen Konsolenausgabe 
  console = new Console(this);
  console.start();
  
  BilderLaden();
  frameRate(4);
  LichtKonfiguration();
  headerFont = createFont("EraserDust.ttf", 70);
  pageFont   = createFont("Eraser.ttf", 80); 
}

public void draw()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{
  
  //Aktualisierung von DartMenu ueberpruefen!
  String[] AktualisierungString = loadStrings( Pfad_Status );
  if ( AktualisierungString!= null)
  {
    try
    {
      if(PApplet.parseInt(AktualisierungString[5]) == 1 )                        
        Pfeileingabe = true;    
      else
        Pfeileingabe = false;  
      if(PApplet.parseInt(AktualisierungString[7]) == 1) 
      //Programm beenden wenn zum Hauptmenu gewechselt wird
      {
        println("Programm wird vom DartMenu beendet!");
        exit();
      }
    }
    catch (Exception e)
    {
      println("####Abfangen des Fehlers gleichzeitig lesen/schreiben bei Aktualisierung!####");
    }
  }
  else
    println("Problem: Keine Angaben zum Status vorhanden");
  
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
  header();
  Spielmodus.Aktualisieren();    
  SpielerNeuAnlegen();      
  for(int i = 1; i<=AnzahlTeilnehmer;i++)
  {
    if(Player[i].Aktiv == true )
    {
      println("Spieler => "+i);
      Player[i].PfeileAktualisieren(); //Auslesen der Pfeile aus Dokument
      Player[i].PfeileOkay();          //Prüfen auf Eingabe OK
    }
  }
  RotiereCards();  
  GewinnerHintergrund();
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  if(OutputStream == true)
  {
    console.draw(0, 130, displayWidth,displayHeight-130, 30, 25, 4, 4, color(220), color(0,0,0,150), color(255));
    console.print();
  }

  
}

public void mousePressed() //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{
  // Ueberprüfung auf Funktion
  Shuffle=true;
  if(OutputStream ==false)
    OutputStream = true;
  else
    OutputStream = false;
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
  String IN = " ";
  String OUT = " ";
  switch (Spielmodus.IN)
  {
    case 1: IN = "SI";
      break;
    case 2: IN = "DI";
      break;
    case 0: IN = " 0 ";
      break;
  }
  switch (Spielmodus.OUT)
  {
    case 1: OUT = "SO";
      break;
    case 2: OUT = "DO";
      break;
    case 3: OUT = "MO";
      break;
    case 0: OUT = " 0 ";
      break;
  }
  int Startwert = Spielmodus.Startwert;
  if(Startwert<300)
    Startwert = 0;
  textFont(headerFont);
  textAlign(CENTER);
  text("DARTS | "+Spielmodus.Startwert+" | "+IN+" | "+OUT,displayWidth/2,80);
  textAlign(LEFT);
  textFont(pageFont);
}

public void GewinnerHintergrund()
{
 
  for(int i = 1; i<=AnzahlTeilnehmer;i++)
  {

    if(Player[i].Gewonnen == true )
    {
          String[]status  = {"Gewonnen:","1","Aktualisierung","1","","","",""};
          saveStrings( Pfad_Status, status);     
          
      println("Gewinner Background");
      
      //Bildschirm schwarz
      fill(0);
      rect(0,0,displayWidth,displayHeight);
      
      //Random versetzt
      textAlign(CENTER);
      textSize(250);
      fill(170);
      text(Player[i].Name +" gewinnt das Spiel!",((displayWidth/2)*random(0,1)),((displayHeight/2))*random(0,1));

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




public boolean RandomBoolean()
{
  boolean erg = false;

  if ( 5 > random(0,10) )
    erg = true;
  
  return erg;
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
  if (null == (spi = new SPI(SPI.list()[1])) || Windows == true || Lichtansteuerung == 0)
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
  if (FehlerLicht == false)
  {
    InnenLichtLinks(R,G,B);
    InnenLichtRechts(R,G,B);
    InnenLichtOben(R,G,B);
  }
}

public void Pfadermittlung()
{
  //relativen Pfadangabe
  //übergeordneten Ordner ermittteln um relativen Pfad festzulegen
  //unterschiede bei Übersetzter datei
  println("Der Dateipfad des Sketches ist: " + sketchPath());
  String Pfad = sketchPath();
  String sketch = getClass().getName(); 
  // Name des Sketches zum Vergleich im Pfad
  println("Der Sketch hat den Namen: "+ sketch);
  //Betriebssystem ermitteln
  String os = System.getProperty("os.name");
  if (os.contains("Windows")) 
  {
    // os-specific setup and config here
    println("Als Betriebssystem wird Windows erkannt");
    Windows = true;
  } 
  else if (os.contains("Linux")) 
  {
    println("Als Betriebssystem wird Linux erkannt");
    Linux= true;
  } 
  else 
  {
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
}

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

public void Einstellungen()
{
  //Einstellungen laden
          int  screen_setting   = PApplet.parseInt(Pfade[29]);
               Betriebssystem   = PApplet.parseInt(Pfade[35]);
               Lichtansteuerung = PApplet.parseInt(Pfade[31]);
  //size(1200,displayHeight);
  println("Dartscorer wird im Bildschirm "+screen_setting+ " ausgeführt!");

  switch(screen_setting)
  {
    case 1: fullScreen(1); break;
    case 2: fullScreen(2); break;
    case 3: fullScreen(3); break;
  }  
}



String[]    Teilnehmer        = new String[9]  ;
String[]    Datenbank_Player  = new String[9]  ;
Spieler[]   Player            = new Spieler[9] ;
int         AnzahlTeilnehmer                   ;
int         AnzahlAllerSpieler                 ;
boolean     PfeileOkay        = false          ;
boolean     GewonnenGlobal    = false          ;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
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
             println(Teilnehmer[i-1],Datenbank_Player[1],DatenbankIndex);
          }         
              switch (i)
              {
              case 1:
                 Datenbank_Player = loadStrings(Pfad_Player+DatenbankIndex+".INOUT");
                 Player[1] = new Spieler(Datenbank_Player[1],Datenbank_Player[3],i,Spielmodus.Startwert,Datenbank_Player[7]);
                 break;    
              case 2:
                 Datenbank_Player = loadStrings(Pfad_Player+DatenbankIndex+".INOUT");
                 Player[2] = new Spieler(Datenbank_Player[1],Datenbank_Player[3],i,Spielmodus.Startwert,Datenbank_Player[7]);
                 break; 
              case 3:
                 Datenbank_Player = loadStrings(Pfad_Player+DatenbankIndex+".INOUT");
                 Player[3] = new Spieler(Datenbank_Player[1],Datenbank_Player[3],i,Spielmodus.Startwert,Datenbank_Player[7]);
                 break; 
              case 4:
                 Datenbank_Player = loadStrings(Pfad_Player+DatenbankIndex+".INOUT");
                 Player[4] = new Spieler(Datenbank_Player[1],Datenbank_Player[3],i,Spielmodus.Startwert,Datenbank_Player[7]);
                 break; 
              case 5:
                 Datenbank_Player = loadStrings(Pfad_Player+DatenbankIndex+".INOUT");
                 Player[5] = new Spieler(Datenbank_Player[1],Datenbank_Player[3],i,Spielmodus.Startwert,Datenbank_Player[7]);
                 break; 
              case 6:
                 Datenbank_Player = loadStrings(Pfad_Player+DatenbankIndex+".INOUT");
                 Player[6] = new Spieler(Datenbank_Player[1],Datenbank_Player[3],i,Spielmodus.Startwert,Datenbank_Player[7]);
                 break; 
              case 7:
                 Datenbank_Player = loadStrings(Pfad_Player+DatenbankIndex+".INOUT");
                 Player[7] = new Spieler(Datenbank_Player[1],Datenbank_Player[3],i,Spielmodus.Startwert,Datenbank_Player[7]);
                 break; 
              case 8:
                 Datenbank_Player = loadStrings(Pfad_Player+DatenbankIndex+".INOUT");
                 Player[8] = new Spieler(Datenbank_Player[1],Datenbank_Player[3],i,Spielmodus.Startwert,Datenbank_Player[7]);
                 break; 
              }
        }
      }
  }
}


//******************************************************************************************
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
public class Spieler
{
  boolean Gewonnen;
  int     Punktezahl;
  int     PunkteVorher; //benötigt um bei überwerfen die Punktezahl zu setzen
  
  double  AVG       =0.0f;
  int     AnzPfeile =0;
  int     GesPunkte =0;
  
  String[]Pfeile;
  int     Pfeil1;
  int     Pfeil2;
  int     Pfeil3;
  int     LastPfeil1;
  int     LastPfeil2;
  int     LastPfeil3;
  boolean ResetUberwerf;
  int     ZwischenSumme;
  boolean Double;
  boolean Single;
  boolean Triple;

  boolean Uberworfen;
  String  Name;
  boolean Aktiv;        //Spieler spielt
  int     Rangfolge;    //1 ist aktueller Spieler
  int     transp = 0;   //Transparenz als Fade bei Spieler 1
  
  int   Farbe = color(255,0,10);
  int     Siege;
  
  boolean EinfachAus;
  
  //Konstruktor+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Spieler(String NameDesSpielers, String FarbeInt, int Rang, int startwert, String EinfachAusString)
  {
    Name = NameDesSpielers;
    Rangfolge = Rang;
    Punktezahl = startwert;
    Uberworfen = false;
    Farbe = PApplet.parseInt(FarbeInt);
    Siege = 0;
    EinfachAus = PApplet.parseBoolean(PApplet.parseInt(EinfachAusString)); 
    
        ResetUberwerf = false;
        LastPfeil1 = -1;
        LastPfeil2 = -1;
        LastPfeil3 = -1;      
        Pfeil1     = -1;
        Pfeil2     = -1;
        Pfeil3     = -1;
        ZwischenSumme =0;
        Uberworfen = false;
        ResetUberwerf = false;
        Gewonnen   = false;   
  }
  //Methoden+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  public void card()
  { 
     if(Pfeileingabe == true )
     {    
        if(Rangfolge==1 && Shuffle == false)//Spieler spielt
        { 
          Aktiv = true;
          if(transp<250)//faden
          {         
            noStroke();
            fill(230,transp);
            rect(displayWidth*0.03f,displayHeight*0.15f,displayWidth*0.5f,displayHeight*0.83f);
            //transp = 1+transp*4;      //Raspi nicht Leistungsstark --> faden ruckelt
            transp = 250;      
          }
          else
          { 
            AussenLicht(PApplet.parseInt(red(Farbe)), PApplet.parseInt(green(Farbe)), PApplet.parseInt(blue(Farbe)));
            //Weiss AN
            if (Gewonnen == true)
            {
                        InnenLichtLinks (RandomBoolean(),RandomBoolean(),RandomBoolean());
                        InnenLichtRechts(RandomBoolean(),RandomBoolean(),RandomBoolean());
                        InnenLichtOben  (RandomBoolean(),RandomBoolean(),RandomBoolean());
            }
            else
              InnenLicht(true,true,true);
                  
            fill(230,220);
            rect(displayWidth*0.03f,displayHeight*0.15f,displayWidth*0.5f,displayHeight*0.83f,30);

            fill(Farbe,transp);
            rect(displayWidth*0.03f,displayHeight*0.15f,50,displayHeight*0.83f,30,0,0,30);
            fill(250);
            textAlign(LEFT);
            if (Name.length() > 5)
              textSize(100);
            else
              textSize(130);
            if (Name.length() > 8)
              textSize(80);
            text(Name,displayWidth*0.075f,displayHeight*0.305f);
            fill(0);
            text(Name,displayWidth*0.07f,displayHeight*0.3f);
            textSize(180);
            textAlign(CENTER);
            
            //stroke(255);
            fill(255,100);
            circle(displayWidth*0.44f,displayHeight*0.3f,410);
            circle(displayWidth*0.44f,displayHeight*0.3f,399);
            circle(displayWidth*0.44f,displayHeight*0.3f,390);
            circle(displayWidth*0.44f,displayHeight*0.3f,385);
            fill(Farbe);
            noStroke();
            circle(displayWidth*0.44f,displayHeight*0.3f,380);
            //fill(Farbe,220);
            //circle(displayWidth*0.34,displayHeight*0.45,180);
            noStroke();
            if( AVG > 0.0f )
            {
              //stroke(255);
              fill(255,100);
              circle(displayWidth*0.37f,displayHeight*0.48f,215);
              circle(displayWidth*0.37f,displayHeight*0.48f,208);
              circle(displayWidth*0.37f,displayHeight*0.48f,203);
              textSize(70);
              fill(Farbe);
              circle(displayWidth*0.37f,displayHeight*0.48f,200);
              fill(255);
              text(String.format("%.1f", AVG) ,displayWidth*0.37f,displayHeight*0.495f);
            }
            textSize(180);
            fill(240);
            text(Punktezahl,displayWidth*0.438f,displayHeight*0.37f);
            fill(20);
            text(Punktezahl,displayWidth*0.435f,displayHeight*0.36f);
            textSize(80);
            
            noStroke();
            
            if(Pfeil1==-1)//noch keine Eingabe Pfeil 1
            {
              fill(240);
              rect(displayWidth*0.07f,displayHeight*0.38f,400,100,30);  
              image(img_pfeil, displayWidth*0.1f,displayHeight*0.32f, 250,200);
            }
            else
            {
              stroke(Farbe);
              fill(255);
              rect(displayWidth*0.07f,displayHeight*0.38f,400,100,30);  
              textAlign(CENTER);
              fill(40);
              text(Pfeil1,displayWidth*0.17f,displayHeight*0.46f);
              noStroke();
            }
            if(Pfeil2==-1)//noch keine Eingabe Pfeil 2
            {
              fill(240);
              rect(displayWidth*0.07f,displayHeight*0.525f,400,100,30);   
              image(img_pfeil, displayWidth*0.1f,displayHeight*0.47f, 250,200);
            }
            else
            {
              stroke(Farbe);
              fill(255);
              rect(displayWidth*0.07f,displayHeight*0.525f,400,100,30); 
              fill(40);
              text(Pfeil2,displayWidth*0.17f,displayHeight*0.605f);
              noStroke();
            }
            if(Pfeil3==-1)//noch keine Eingabe Pfeil 3
            {
              fill(240);
              rect(displayWidth*0.07f,displayHeight*0.67f,400,100,30);   
              image(img_pfeil, displayWidth*0.1f,displayHeight*0.61f, 250,200);
            }
            else
            {
              stroke(Farbe);
              fill(255);
              rect(displayWidth*0.07f,displayHeight*0.67f,400,100,30);
              fill(40);
              text(Pfeil3,displayWidth*0.17f,displayHeight*0.75f);
              noStroke();
            }
            textAlign(LEFT);
                      
            //Werte zum zusammen addieren nur einmal bei Änderung
            if(LastPfeil1 == -1)//von Grundstellung Dokument leer
            {
              if(Pfeil1 != LastPfeil1)
              {
                
                ZwischenSumme = ZwischenSumme + Pfeil1;
                PruefeUberwerfen(0);
                if(Uberworfen == false)
                  PfeileAbziehen(Pfeil1 , false, LastPfeil1, 0);
              }
            }
            else //Dokumentänderung
            {
              if(Pfeil1 != LastPfeil1)
              {
                println("test Ausgabe"+LastPfeil1+ Pfeil1);
                ZwischenSumme = ZwischenSumme - LastPfeil1;
                ZwischenSumme = ZwischenSumme + Pfeil1;
                PruefeUberwerfen(0);
                PfeileAbziehen(Pfeil1 , true, LastPfeil1, 0); 
                Gewonnen = false;
              }
            }
            if(LastPfeil2 == -1)//von Grundstellung Dokument leer
            {
              if(Pfeil2 != LastPfeil2)
              {
                ZwischenSumme = ZwischenSumme + Pfeil2;
                PruefeUberwerfen(1);
                PfeileAbziehen(Pfeil2 , false, LastPfeil2, 1);
              }
            }
            else //Dokumentänderung
            {
              if(Pfeil2 != LastPfeil2)
              {
                ZwischenSumme = ZwischenSumme - LastPfeil2;
                ZwischenSumme = ZwischenSumme + Pfeil2;
                PruefeUberwerfen(1);
                PfeileAbziehen(Pfeil2 , true, LastPfeil2, 1);
                Gewonnen = false;
              }
            }
            if(LastPfeil3 == -1)//von Grundstellung Dokument leer
            {
              if(Pfeil3 != LastPfeil3)
              {
                ZwischenSumme = ZwischenSumme + Pfeil3;
                PruefeUberwerfen(2);
                PfeileAbziehen(Pfeil3 , false, LastPfeil3, 2);
                
                //Caller(ZwischenSumme);
              }
            }
            else //Dokumentänderung
            {
              if(Pfeil3 != LastPfeil3)
              {
                ZwischenSumme = ZwischenSumme - LastPfeil3;
                ZwischenSumme = ZwischenSumme + Pfeil3;
                PruefeUberwerfen(2);
                PfeileAbziehen(Pfeil3 , true, LastPfeil3, 2); 
                Gewonnen = false;
              }
            }           
            if(Punktezahl == 0)
              Gewonnen();             
            fill(30);  
            textSize(40);
            CheckOut(Punktezahl);
            if((Punktezahl < 41) && EinfachAus == true) //Extra EinfachAus darstellen
            {
                    text("DU KANNST MIT",580,700);
                    text("EINER EINFACHEN",580,800);          
                    text("ZAHL GEWINNEN!",580,900);                
            }
            if((Punktezahl == Spielmodus.Startwert && Spielmodus.IN == 2) && EinfachAus == true) 
            //Extra EinfachEin darstellen
            {
                    text("DU KANNST MIT",580,700);
                    text("EINER EINFACHEN",580,800);          
                    text("ZAHL STARTEN!",580,900);    
            }          
            fill(0);
            textAlign(CENTER);
            textSize(100);
            if(Uberworfen == false)
            {
              if(ZwischenSumme > 0)
                text(ZwischenSumme,displayWidth*0.17f,displayHeight*0.9f);
            }
            else
            {
              textSize(70);
              text("ZU VIEL!",displayWidth*0.17f,displayHeight*0.9f);   
            }    
          }
        }
        else//Spieler wartet
        {
          if(Shuffle == false)
          {
            Aktiv = false;
            if(Rangfolge>0)
            {
              int Teilung = PApplet.parseInt((displayHeight*0.78f)/(AnzahlTeilnehmer-1));
              int Verteilung = Rangfolge - 2;
              
              textAlign(LEFT);
              textSize(90);
          
              fill(100,210);
              stroke(250,50);
              strokeWeight(4);
              rect(displayWidth*0.55f,displayHeight*0.16f+Verteilung*Teilung,displayWidth*0.43f,Teilung,30);
              noStroke();
              fill(Farbe,170);
              rect(displayWidth*0.55f,displayHeight*0.16f+Verteilung*Teilung,40,Teilung,30,0,0,30);
              fill(255);
              text(Name,displayWidth*0.58f,displayHeight*0.265f+Verteilung*Teilung);
              textAlign(RIGHT);
              text(Punktezahl,displayWidth*0.97f,displayHeight*0.265f+Verteilung*Teilung);
              
              textSize(70);
              fill(190);
              if(AnzahlTeilnehmer < 5 && AVG > 0.0f )
                text("AVG: "+String.format("%.1f", AVG) ,displayWidth*0.97f,displayHeight*0.4f+Verteilung*Teilung);
            }
          }
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
              stroke(250,50);
              strokeWeight(4);
              rect(displayWidth*0.28f,displayHeight*0.16f,displayWidth*0.43f,Teilung,20);
              fill(230);
              text("SIEGE",displayWidth*0.49f,displayHeight*0.23f-((AnzahlTeilnehmer-8)*10));
              textAlign(LEFT);
              fill(100,110);
              rect(displayWidth*0.28f,displayHeight*0.16f+Verteilung*Teilung,displayWidth*0.43f,Teilung,20);
              noStroke();
              fill(Player[i].Farbe,170);
              rect(displayWidth*0.28f,displayHeight*0.16f+Verteilung*Teilung,40,Teilung,20,0,0,20);
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
              stroke(250,50);
              strokeWeight(4);
              rect(displayWidth*0.28f,displayHeight*0.16f,displayWidth*0.43f,Teilung,20);              
              fill(230);
              text("SIEGE",displayWidth*0.49f,displayHeight*0.23f-((AnzahlTeilnehmer-8)*10));
              textAlign(LEFT);
              fill(100,110);
              rect(displayWidth*0.28f,displayHeight*0.16f+Verteilung*Teilung,displayWidth*0.43f,Teilung,20);            
              noStroke();            
              fill(Player[i].Farbe,170);
              rect(displayWidth*0.28f,displayHeight*0.16f+Verteilung*Teilung,40,Teilung,20,0,0,20);
              fill(255);
              text(Player[i].Name,displayWidth*0.31f,displayHeight*0.27f+Verteilung*Teilung);
              textAlign(RIGHT);
              text(Player[i].Siege,displayWidth*0.68f,displayHeight*0.27f+Verteilung*Teilung);             
           }
         }
       }
     }
  }
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  public void PfeileAktualisieren()
  {
    LastPfeil1 = Pfeil1;
    LastPfeil2 = Pfeil2;
    LastPfeil3 = Pfeil3;
    Pfeile = loadStrings( Pfad_Punkte);
    if(Pfeile!=null && Aktiv)
    {
      int numtries = 3;
      while(numtries-- != 0)
        try
        {
          Pfeil1 = PunkteStringToInt(Pfeile[0]);  
          Pfeil2 = PunkteStringToInt(Pfeile[1]);
          Pfeil3 = PunkteStringToInt(Pfeile[2]);
          break;
        }
        catch (Exception e)
        {
          delay(100);
          println("####Abfangen des Fehlers gleichzeitig lesen/schreiben bei Punkte der Pfeile!####");
          continue;
        }
    }
  }
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  public void PfeileOkay()
  {
    Pfeile = loadStrings( Pfad_Punkte);
    if(Pfeile.length > 3)
    {
      println("punkte ok",Pfeile[4],Pfeile[4]=="1");
      if(PApplet.parseInt(Pfeile[4])==1) //Pfeile sind korrekt eingegeben
      {
        //AVG berechnen
        AnzPfeile = AnzPfeile+3;
        GesPunkte = GesPunkte + (Pfeil1 + Pfeil2 + Pfeil3);
        AVG =  GesPunkte / (AnzPfeile/3) ;
           
        //Pfeile OK und Gewonnen
        //Pfeile Dokument beschreiben für Weiterschaltbedingung DartsMenu
        if(Gewonnen == true)
        {          
          //Rangfolge nach Punkten sortieren bevor Punktestand gelöscht wird
          int[] PunkteArray =         new int[AnzahlTeilnehmer];
          int[] PunkteArraySortiert = new int[AnzahlTeilnehmer];
          
          for(int k = 1; k<=AnzahlTeilnehmer;k++)
              PunkteArray[k-1] = Player[k].Punktezahl;
          PunkteArraySortiert = reverse(sort(PunkteArray));
          for(int i = 1; i<=AnzahlTeilnehmer;i++)
          {
            for(int k = 1; k<=AnzahlTeilnehmer;k++)
            {
              if(Player[i].Punktezahl == PunkteArraySortiert[k-1])
              {
                  printArray(PunkteArraySortiert);
                  println("Rang " +k+ "Spieler "+i);
                  Player[i].Rangfolge = k;
                  PunkteArraySortiert[k-1] = -1;
                  break;
              }      
            }
          }          
          //Rang um 1 erhöhen, damit geshuffelt werden kann
          for(int i = 1; i<=AnzahlTeilnehmer;i++)
          {
            Player[i].Rangfolge = Player[i].Rangfolge + 1 ;
            if(Player[i].Rangfolge == AnzahlTeilnehmer +1)
              Player[i].Rangfolge = 1;            
            println("Spieler "+i+" ist Rang "+ Player[i].Rangfolge+".");
          }        
          ResetPunkte();
          Siege ++;
        } 
        ResetUberwerf = false;
        LastPfeil1 = -1;
        LastPfeil2 = -1;
        LastPfeil3 = -1;      
        Pfeil1     = -1;
        Pfeil2     = -1;
        Pfeil3     = -1;
        PunkteVorher = Punktezahl;
        ZwischenSumme =0;
        Uberworfen = false;
        ResetUberwerf = false;
        Gewonnen   = false;      
        
        println("lösche Pfeile und schuffle cards");
        Shuffle    = true;     
        String[]clear  = {"","","","","","","",""};
        saveStrings( Pfad_Punkte, clear);       
      }
    }
  }
  //Interne Methoden++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //protected 
  protected void RangAktualisieren()
  {
    if(Rangfolge==0)
    {
      Rangfolge = AnzahlTeilnehmer+1;
    }
    if(Rangfolge==1)
    {
      Rangfolge = 0;//Zwischenposition damit es zu keiner Dopplung kommt
      transp = 0;
    }
    else
    {
      Rangfolge = Rangfolge-1;
      if(Rangfolge>1)
      {   
      //CardChange1.play();
      }
    }    
  }
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  protected  void PfeileAbziehen(int wert , boolean back, int lastWert, int ArrayWert)
  {
    if(Uberworfen == true)
    {
      Punktezahl=PunkteVorher;
    }
    if(Uberworfen == false)
    {
      //Prüfen auf Single- oder Double in
      if((Spielmodus.IN == 2 && Punktezahl == Spielmodus.Startwert)&& EinfachAus == false)
      //prüfen auf Double und abziehen
      {
        println("Prüfung auf Double",Single,Double,Triple);
        DoubleSingleOrDriple(ArrayWert);
        println("Geprüft : ",Single,Double,Triple);
        if(Double == true)
          Punktezahl = Punktezahl - wert;
      }
      else//einfach abziehen
      {
         if(ResetUberwerf == false)
         {
            if(back == true )//manuelle Änderung => Werte tauschen
            {
              Punktezahl = Punktezahl + lastWert;
              Punktezahl = Punktezahl - wert;
            }
            else
            {
              Punktezahl = Punktezahl - wert;
            }
         }
         else
         {
            Punktezahl= PunkteVorher - ZwischenSumme;
         }
      }
    } 
  }
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  protected  void DoubleSingleOrDriple(int ArrayWert)
  {
   //Vegleich Pfeil[ArrayWert] auf "T" bzw "D" else Single
   String[] m1 = match(Pfeile[ArrayWert], "T");
   String[] m2 = match(Pfeile[ArrayWert], "D");
   String[] m3 = match(Pfeile[ArrayWert], "50");

     Triple = false;
     Double = false;
     Single = true;
     
     if (m1 != null ) 
     { // Find T für Triple
       Triple = true;
       Double = false;
       Single = false;
     } 
     if (m2 != null || m3 != null) 
     { // Find D für Double
       Triple = false;
       Double = true;
       Single = false;
     } 
  }
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  protected  void PruefeUberwerfen(int ArrayWert)
  {
        int PunktezahlTheorie =0;
        if(Uberworfen == false)
          PunktezahlTheorie = Punktezahl - PunkteStringToInt(Pfeile[ArrayWert]);
        if(Uberworfen == true)
          PunktezahlTheorie = (Punktezahl-ZwischenSumme); 
          // - PunkteStringToInt(Pfeile[ArrayWert]);
        boolean UberworfenVorher = Uberworfen;
        ResetUberwerf = false;
        Uberworfen = false;
        
        if(PunktezahlTheorie<0 )
          Uberworfen = true;
        if((Spielmodus.OUT == 2 && (PunktezahlTheorie == 1 || PunktezahlTheorie == 0 )) && EinfachAus == false)
        //prüfen auf Double 
        {
          if (PunktezahlTheorie == 1 ) 
            Uberworfen = true;
          else
          {
             String[] m1 = match(Pfeile[ArrayWert], "D");
             String[] m2 = match(Pfeile[ArrayWert], "50");
             if (m1 != null || m2 != null )         
               Uberworfen = false;
             else
               Uberworfen = true;     
          }
        }
        if((Spielmodus.OUT == 3 && (PunktezahlTheorie == 1 || PunktezahlTheorie == 0))&& EinfachAus == false)
        //Master OUT
        {
          if (PunktezahlTheorie == 1 ) 
            Uberworfen = true;
          else
          {
             String[] m1 = match(Pfeile[ArrayWert], "T");
             String[] m2 = match(Pfeile[ArrayWert], "D");
             String[] m3 = match(Pfeile[ArrayWert], "50");
             if (m1 != null || m2 != null || m3 != null ) 
               Uberworfen = false;
             else
               Uberworfen = true;    
          }
        }
        //Erkennung der Änderung der Eingabe bei Überworfennen Wert
        if(UberworfenVorher == true && Uberworfen == false)
            ResetUberwerf = true;
  }
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  protected  void Gewonnen()
  {
    println("***************** "+Name+" gewinnt das Spiel! ********************");
    //weitere Aktionen

    Gewonnen = true;
    GewonnenGlobal = true;
  }
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Sorgt für die Rotation der einzelnen Karten
boolean Shuffle =false;
int z=1;

public void RotiereCards()
{
  for(int i=1;i<=AnzahlTeilnehmer;i++)
  {
    Player[i].card();
  }
  if(Shuffle == true)
  {  
    if(z>AnzahlTeilnehmer)
    {
      z=1;
      Shuffle = false;
    }   
        if(Shuffle == false)
        z=0;
        
        int Spieler = 0;
        for(int i=1;i<AnzahlTeilnehmer+1;i++)
        {
            if(z==Player[i].Rangfolge)
              Spieler = i;
        }
        
            Player[Spieler].RangAktualisieren();
            z++;  
  } 
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

public void ResetPunkte()
{
  for(int i=1;i<=AnzahlTeilnehmer;i++)
  {
    Player[i].Punktezahl = Spielmodus.Startwert;
    Player[i].PunkteVorher = 0;
    
        Player[i].ResetUberwerf = false;
        Player[i].LastPfeil1 = -1;
        Player[i].LastPfeil2 = -1;
        Player[i].LastPfeil3 = -1;      
        Player[i].Pfeil1     = -1;
        Player[i].Pfeil2     = -1;
        Player[i].Pfeil3     = -1;
        Player[i].PunkteVorher = Player[i].Punktezahl;
        Player[i].ZwischenSumme =0;
        Player[i].Uberworfen = false;
        Player[i].ResetUberwerf = false;
        Player[i].Gewonnen   = false;
        
     if(GewonnenGlobal == true)
       Aktualisierung = 0;
     GewonnenGlobal =false;   
  }
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Table CheckOutTabelle;
public void CheckOut( int Endwert)
{
  CheckOutTabelle = loadTable("CheckOutTabelle.csv","csv");
 
  for (TableRow row  : CheckOutTabelle.rows()) {

    int AusmachWert = row.getInt(0);
    if (AusmachWert == Endwert)
    {
      //Möglichkeiten M und Pfeile 1,2,3
      String M1_1, M1_2, M1_3, M2_1, M2_2, M2_3, M3_1, M3_2;
      M1_1 = row.getString(1);
      M1_2 = row.getString(2);
      M1_3 = row.getString(3);
      M2_1 = row.getString(4);
      M2_2 = row.getString(5);
      M2_3 = row.getString(6);
      M3_1 = row.getString(7);
      M3_2 = row.getString(8);

      println("Rest:" + AusmachWert);
      println("1. Möglickeit:" + M1_1 +"  "+ M1_2 +"  "+ M1_3 +"  ");
      println("2. Möglickeit:" + M2_1 +"  "+ M2_2 +"  "+ M2_3 +"  ");
      println("3. Möglickeit:" + M3_1 +"  "+ M3_2);
      
      textSize(50);
      fill(0);
      
      text("CHECK OUT:",600,700);
      text(M1_1 +"  "+ M1_2 +"  "+ M1_3 +"  ",600,800);
      text(M2_1 +"  "+ M2_2 +"  "+ M2_3 +"  ",600,880);
      if((M2_1.equals("") == true))
        text(M3_1 +"  "+ M3_2,600,880);
      else
        text(M3_1 +"  "+ M3_2,600,960);
    }
  }
}
String[] Spielmodi = new String[10];
Modi Spielmodus = new Modi();

public class Modi
{
  int Startwert; //301, 501,...
  int IN;        //1 Single 2 Doppel 
  int OUT;       //1 Single 2 Doppel 3 Master -OUT
  
  //Konstruktor++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Modi()
  {
  }
  Modi(   int startwert,int In,int Out)
  {
    Startwert  = startwert;
    IN   = In;
    OUT  = Out;
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
        Spielmodus = new Modi(PApplet.parseInt(Spielmodi[0]),PApplet.parseInt(Spielmodi[2]),PApplet.parseInt(Spielmodi[4]));  
      }
    }
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Dartscorer" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
