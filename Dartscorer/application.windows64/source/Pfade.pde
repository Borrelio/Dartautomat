
void Pfadermittlung()
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

void Einstellungen()
{
  //Einstellungen laden
          int  screen_setting   = int(Pfade[29]);
               Betriebssystem   = int(Pfade[35]);
               Lichtansteuerung = int(Pfade[31]);
  //size(1200,displayHeight);
  println("Dartscorer wird im Bildschirm "+screen_setting+ " ausgeführt!");

  switch(screen_setting)
  {
    case 1: fullScreen(1); break;
    case 2: fullScreen(2); break;
    case 3: fullScreen(3); break;
  }  
}
