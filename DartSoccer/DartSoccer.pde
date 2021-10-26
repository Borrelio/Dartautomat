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


void settings()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
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
          int screen_setting = int(Pfade[29]);
               Betriebssystem = int(Pfade[35]);

  //size(1200,displayHeight);
  println(sketch+" wird im Bildschirm "+screen_setting+ " ausgeführt!");

  switch(screen_setting)
  {
    case 1: fullScreen(1); break;
    case 2: fullScreen(2); break;
    case 3: fullScreen(3); break;
  }  
    
}

void setup()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{

  BilderLaden();
  //if(Betriebssystem==3)//Raspberry Hardware für Licht
    LichtKonfiguration();
  headerFont = createFont("EraserDust.ttf", 70);
  pageFont   = createFont("Eraser.ttf", 80); 
  frameRate(1);
}


void draw()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{

  //Aktualisierung von DartScorer als Event
  String[] AktualisierungString = loadStrings( Pfad_Status );

  if ( AktualisierungString!= null)
  {
    try
    {
      if(int(AktualisierungString[3]) == 1 ) //Fehler Array out of Bounds Exception 3
      {                                     //...gleichzeitiges lesen und schreiben
        Aktualisierung = 0;
        AktualisierungString[3]= "0";
        saveStrings( Pfad_Status, AktualisierungString);      
      }
      if(int(AktualisierungString[5]) == 1 )                        
        Pfeileingabe = true;    
      else
        Pfeileingabe = false;  
      if(int(AktualisierungString[7]) == 1) //Programm beenden wenn zum Hauptmenu gewechselt wird
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
    
    
    
    
    
    

  
  //Nur wenn Eingabe über DartMenu erfolgt, wird Programmschleife abgearbeitet!
  if(Aktualisierung < (180))
  {
    //println("Hauptprogrammschleife Dartscorer x mal ausführen.");
    Aktualisierung++;
    
    header();
    Spielmodus.Aktualisieren();    
    SpielerNeuAnlegen();
    
    

      
    for(int i = 1; i<=AnzahlTeilnehmer;i++)
    {

        //println(i);
        Player[i].card(); 

    }


    GewinnerHintergrund();

  }
  
  
          //Zeitbalken
    
    int ZeitProzent = int( ((millis()*0.001-StartZeit_s)   / (Spielmodus.Zeit*60 )) *100);
    fill(255,100);
    rect(displayWidth*0.8,displayHeight*0.13,displayWidth*0.16,displayHeight*0.78);
    fill(255);   
    if(ZeitProzent > 60)
      fill(#FAF24C);
    if(ZeitProzent > 85)
      fill(#FF2946);   
    rect(displayWidth*0.8,displayHeight*0.13, displayWidth*0.16, (ZeitProzent*displayHeight*0.78)/100);
    fill(255,10,10);
    println(millis()*0.001-StartZeit_s);
    println(Spielmodus.Zeit*60);
    println(   ((millis()*0.001-StartZeit_s)   / (Spielmodus.Zeit*60 )) *100 );
}


void mousePressed() //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{
  //Test

  StartZeit_s = millis()*0.001;
}
