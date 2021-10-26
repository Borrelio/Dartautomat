//Uebersicht der Seitenstruktur:

// ->page1 [Startseite]
// |     ...Auswahl Klassisch Dart
// |     -->page 2 [Spielmodus]
// |         -->page 3 [Spielerauswahl]
// |             -->page 5 [Tastatureingabe klassisch Dart]
// |            |       ...Spiel gewonnen
// |            |       -->page 6 
// |            |______ ...Auswahl Wiederholung
// |___________________ ...Auswahl Startseite    
//
// ->page1 [Startseite]
// |     ...Auswahl Soccer
// |     -->page 7 [Spielmodus Soccer]
// |         -->page 3 [Spielerauswahl]
// |             -->page 8 [Tastatureingabe Soccer]
// |            |       ...Spiel gewonnen
// |            |       -->page 6 
// |            |______ ...Auswahl Wiederholung
// |___________________ ...Auswahl Startseite  
//
//
// -> Header
//      --> page 3 [Spieler entfernen]
//      --> page 4 [Spieler hinzufuegen]


//Bibliothek zur Umleitung des Output-Streams
import at.mukprojects.console.*;
Console console;


//§§§§§GLOBALE VARIABLEN$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
int     AktuellePage    = 0;
int     AmAktualisieren = 2;
int     ChangingPage    = 1;
boolean ChangingSidebar = false;

//Variablen zur Übergabe:
String  Startwert        = " " ;
String  SpielmodiIn      = " " ;
String  SpielmodiOut     = " " ;
int     TeilnehmerAnzahl = 0 ;


//Bilder 
PImage img_beta;
PImage img_ComingSoon;
PImage Hintergrund; 
PImage icon_Menu;
  
//Datenaustausch zwischen Programmen -> Touch Event
String[] Aktualisierung = new String[50];

void settings()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
{
  Pfadermittlung();
  Einstellungen();
  //Screen Einstellungen nur in settings() möglich
  switch(screen_setting)
  {
    case 1: fullScreen(1); break;
    case 2: fullScreen(2); break;
    case 3: fullScreen(3); break;
  }  
}


void setup()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{
  // Initialisierung der internen Konsole
  console = new Console(this);
  console.start();
    
  println("Display Abmessungen:",displayWidth,"x",displayHeight);
  frameRate(4);
  textFont(createFont("EraserDust.ttf", 70));
  
  //Bilder laden
  img_beta       = loadImage("Bilder/beta.png");
  img_ComingSoon = loadImage("Bilder/ComingSoon.png");
  Hintergrund    = loadImage("Bilder/Hintergrund.jpg");
  icon_Menu      = loadImage("Bilder/MenuIcon.png");

  //page1
  Seite1Spielstart(true,false);
    
  //Startpage Aktiv!
  page1 = true;
  Aktualisieren();
  
  println("Setup des DartMenu abgeschlossen!");
}

void draw()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{
  // Programmschleife wird nur durch ein TouchEvent abgearbeitet

}

void mouseReleased()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{ 
    redraw();
    HeaderButtonEvent();
    Page1ButtonEvent();
    Page2ButtonEvent();
    Page3ButtonEvent();
    Page4ButtonEvent();
    Page5ButtonEvent();
    Page6ButtonEvent();
    Page7ButtonEvent();
    Page8ButtonEvent();

    PageChange(ChangingPage,ChangingSidebar);
    Aktualisieren();
 
    //Aktualisierung von DartScorer als Event
    Aktualisierung = loadStrings( Pfad_Status );   
    if ( Aktualisierung!= null)
    {
        //Aktualisierung[2]= "Aktualisierung:";
        //Aktualisierung[3]= "1";
        Aktualisierung[4]= "PfeileingabeAktiv:";
        if(((page5||page8) == true) && int(Aktualisierung[1])==0) //& nicht gewonnen
              Aktualisierung[5]= "1";
        else
              Aktualisierung[5]= "0";      
        saveStrings( Pfad_Status, Aktualisierung);
    }
}
