//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
String[] Pfade  = new String[50];
String  Pfad    ;
String  sketch  = getClass().getName(); // Name des Sketches zum Vergleich im Pfad
boolean Windows = false;
boolean Linux   = false;
boolean EXE     = false; //Ermittlung ob Programm von IDE oder EXE gestartet für Dateipfade

//§§§§§§§§§§§DATEI PFADE$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
String StandardPfad;
String Pfad_Punkte     = "";
String Pfad_Spielmodi  = "";
String Pfad_Status     = "";
String Pfad_Teilnehmer = "";
String Pfad_Player     = "";



void Pfadermittlung()
{
  //übergeordneten Ordner ermittteln um relativen Pfad festzulegen
  //unterschiede bei Übersetzter datei
  //Analyse auf Trennzeichen ob Linux oder Windows
  println("Der Dateipfad des Sketches ist: " + sketchPath());
  Pfad    = sketchPath();
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

          println(Pfad_Punkte);

}



//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

int screen_setting; //(Display 1,2 oder 3)
int Betriebssystem; //(1 Linux32/2 Linux64/3 Raspi/4 Windows32/5 Windows64)

void Einstellungen()
{
   //Einstellungen laden
              screen_setting = int(Pfade[27]);
              Betriebssystem = int(Pfade[35]);
              println("Betriebssystem: "+Betriebssystem);
              
    println(sketch+" wird im Bildschirm "+screen_setting+ " ausgeführt!");
}
