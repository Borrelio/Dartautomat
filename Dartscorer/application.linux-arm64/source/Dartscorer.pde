import at.mukprojects.console.*;
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

void settings()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
{
  Pfadermittlung();
  Einstellungen();    
}

void setup()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

void draw()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{
  
  //Aktualisierung von DartMenu ueberpruefen!
  String[] AktualisierungString = loadStrings( Pfad_Status );
  if ( AktualisierungString!= null)
  {
    try
    {
      if(int(AktualisierungString[5]) == 1 )                        
        Pfeileingabe = true;    
      else
        Pfeileingabe = false;  
      if(int(AktualisierungString[7]) == 1) 
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

void mousePressed() //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{
  // Ueberprüfung auf Funktion
  Shuffle=true;
  if(OutputStream ==false)
    OutputStream = true;
  else
    OutputStream = false;
}
