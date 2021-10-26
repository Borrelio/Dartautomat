import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import at.mukprojects.console.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class DartMenu extends PApplet {

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

public void settings()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
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


public void setup()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

public void draw()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{
  // Programmschleife wird nur durch ein TouchEvent abgearbeitet

}

public void mouseReleased()//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
        if(((page5||page8) == true) && PApplet.parseInt(Aktualisierung[1])==0) //& nicht gewonnen
              Aktualisierung[5]= "1";
        else
              Aktualisierung[5]= "0";      
        saveStrings( Pfad_Status, Aktualisierung);
    }
}

public void Aktualisieren()
{
  
  header();

  if ( page1 == true)
    AktuellePage=1;

  if ( page2 == true)
    AktuellePage=2;

  if ( page3 == true)
    AktuellePage=3;

  if ( page4 == true)
    AktuellePage=4;

  if ( page5 == true)
    AktuellePage=5;

  if ( page6 == true)
    AktuellePage=6;

  if ( page7 == true)
    AktuellePage=7;
    
  if ( page8 == true)
    AktuellePage=8;
    
    
     

  //Zeichnen der ELemente
  //page11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
  Seite1Spielstart ((AktuellePage==1), false);
  Seite1Spielstart2((AktuellePage==1), false);
  Seite1Spielstart3((AktuellePage==1), false);
  Seite1Spielstart4((AktuellePage==1), false);
  //page22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
  Seite2SpielmodiStartwert((AktuellePage==2), Seite2SpielmodiStartwertAktiv);
  Seite2SpielmodiIn       ((AktuellePage==2), Seite2SpielmodiInAktiv);
  Seite2SpielmodiOut      ((AktuellePage==2), Seite2SpielmodiOutAktiv);
  Seite2TeilnehmerAnzahl  ((AktuellePage==2), Seite2TeilnehmerAnzahlAktiv);
  if (Startwert != " " && SpielmodiIn != " " && SpielmodiOut != " " && TeilnehmerAnzahl > 0)
    Seite2WeiterButtonAktiv = true;
  Seite2WeiterButton      ((AktuellePage==2), Seite2WeiterButtonAktiv);
  
  //page33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
  Seite3SpielerAnlegen    ((AktuellePage==3)|AktuellePage==4); 
  Seite3Mitspieler        ((AktuellePage==3), Seite3MitspielerAktiv);
  if (((Seite3PruefeMitspieler() == TeilnehmerAnzahl) | SpielerEntfernen == true && Seite3MitspielerAktiv>0 ) && (AktuellePage==3) )
    Seite3LosButtonAktiv = true;
  else
    Seite3LosButtonAktiv = false; 
  Seite3LosButton         ((AktuellePage==3), Seite3LosButtonAktiv); 
  
  //page44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
  Seite4Tastatureingabe   ((AktuellePage==4)); 
  Seite4TexteingabeName   ((AktuellePage==4), Seite4TexteingabeNameAktiv);
  if(Name != "")
    Seite4HinzuButtonAktiv = true;
  else
    Seite4HinzuButtonAktiv = false;
  Seite4HinzuButton       ((AktuellePage==4), Seite4HinzuButtonAktiv);
  Seite4Collerpicker      ((AktuellePage==4));
  Seite4EinfachAus        ((AktuellePage==4), Seite4EinfachAusAktiv);
  
  //page55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
  Seite5PunkteEingabe     ((AktuellePage==5),Seite5PunkteEingabeAktiv);
  Seite5Pfeil1Anzeige     ((AktuellePage==5),Seite5Pfeil1AnzeigeAktiv);
  Seite5Pfeil2Anzeige     ((AktuellePage==5),Seite5Pfeil2AnzeigeAktiv);
  Seite5Pfeil3Anzeige     ((AktuellePage==5),Seite5Pfeil3AnzeigeAktiv);
  if(Pfeil1 != "" && Pfeil2 != "" && Pfeil3 != "" && (AktuellePage==5))
    Seite5OkButtonAktiv = true;
  else
    Seite5OkButtonAktiv = false;  
  Seite5OkButton          ((AktuellePage==5),Seite5OkButtonAktiv);
  
  //page66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
  Seite6SpielNeustarten   ((AktuellePage==6),Seite6SpielNeustartenAktiv);
  Seite6ZumHauptmenu      ((AktuellePage==6),Seite6ZumHauptmenuAktiv);
  
  //page77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
  Seite7Spielbeschreibung      ((AktuellePage==7), Seite7SpielbeschreibungAktiv);
  Seite7Spielzeit     ((AktuellePage==7), Seite7SpielzeitAktiv);
  Seite7TeilnehmerAnzahl  ((AktuellePage==7), Seite7TeilnehmerAnzahlAktiv);
  if (TeilnehmerAnzahl > 0)
    Seite7WeiterButtonAktiv = true;
  Seite7WeiterButton      ((AktuellePage==7), Seite7WeiterButtonAktiv);
   
  //page88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
  Seite8Mitspieler      ((AktuellePage==8), Seite8MitspielerAktiv);
  Seite8Punkteingabe    ((AktuellePage==8), Seite8PunkteingabeAktiv);
  if(Seite8MitspielerAktiv > 0   && (AktuellePage==8))
    Seite8BestaetigungAktiv = true;
  else
    Seite8BestaetigungAktiv = false; 
  Seite8Bestaetigung    ((AktuellePage==8), Seite8BestaetigungAktiv);
  
  
  Sidebar();
  println(AktuellePage+" ist die aktuelle Seite!");
}




//#####################################################################################################
public void PageChange(int page, boolean Sidebar_F)
{
  if(AktuellePage!=page | Sidebar_F!=Sidebar)
  {
    if(Sidebar_F == true)
      Sidebar = true;
    else
      Sidebar = false;
    page1 = false;
    page2 = false;
    page3 = false;
    page4 = false;
    page5 = false;
    page6 = false;
    page7 = false;
    page8 = false;
    
    switch (page)
    {
    case 1:
      page1 = true;
      break;
    case 2:
      page2 = true;
      break;  
     case 3:
      page3 = true;
      break;
    case 4:
      page4 = true;
      break;
    case 5:
      page5 = true;
      break;
    case 6:
      page6 = true;
      break;
    case 7:
      page7 = true;
      break;
    case 8:
      page8 = true;
      break;
    }
  }
  
  
  // Zeichnet den OutputStream um Programmablauf besser nachvollziehen zu können
  if(OutputStream == true)
  {
    // Draw the console to the screen.
    // (x, y, width, height, preferredTextSize, minTextSize, linespace, padding, strokeColor, backgroundColor, textColor)
    console.draw(0, 150, displayWidth,displayHeight-150, 25, 20, 4, 4, color(220), color(0,0,0,180), color(255));
    
    // Print the console to the system out.
    console.print();
    textFont(createFont("EraserDust.ttf", 70));
  }
  

}
boolean Sidebar = false;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Elemente zum Zeichnen                                                                          §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

public void header()
{
  //Zeichnet Header und Hintergrundbild
  image(Hintergrund, 0, 0, displayWidth,displayHeight );
  fill(0);
  noStroke();
  rect(0,0,displayWidth,displayHeight*0.08f);
  for(int i=0;i<20;i++)
  { 
    fill(255,100-(i*0.5f));
    rect(0,(displayHeight*0.08f)+i,displayWidth,2);
  }
  
  image(icon_Menu, 25, 10, 100, 100 );
  if(page1==true)
  {
    textAlign(RIGHT);
    textSize(50);
    text("START MENÜ",displayWidth-25,100);
  }
  if(page2==true || page7==true)
  {
    textAlign(RIGHT);
    textSize(50);
    text("NEUES SPIEL STARTEN",displayWidth-25,100);
  }
  if(page3==true)
  {
    textAlign(RIGHT);
    textSize(50);
    text("SPIELER AUSWÄHLEN",displayWidth-25,100);   
  }
  if(page4==true)
  {
    textAlign(RIGHT);
    textSize(50);
    text("SPIELER HINZUFÜGEN",displayWidth-25,100);
  }
  if(page5==true || page8==true)
  {
    textAlign(RIGHT);
    textSize(50);
    text("PUNKTEEINGABE",displayWidth-25,100);
  }

  
}

boolean OutputStream = false;

public void Sidebar()
{
  //Zeichnet Sidebar Menü
  if(Sidebar == true)
  {
    fill(255);
    rect(0,0,displayWidth*0.75f,displayHeight);
    fill(0);
    textAlign(LEFT);
    textSize(70);
    text("Zur Startseite",40,120);
    stroke(150);
    line(0,200,displayWidth*0.75f,200);
    text("Spieler hinzufügen",40,320);
    line(0,400,displayWidth*0.75f,400);
    text("Spieler entfernen",40,520);
    line(0,600,displayWidth*0.75f,600);
    text("Debug OutputStream",40,720);
    line(0,800,displayWidth*0.75f,800);
    
    
    
    noStroke();
  }
}

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Button Events                                                                                  §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
public void HeaderButtonEvent()
{
  //Menu Icon*************************************************************************************
  if ((mouseX > 10) && (mouseX<110) && (mouseY > 10) && (mouseY<110))
  {
    ChangingSidebar = true;
  }
  //Menu Sidebar**********************************************************************************
  if ((mouseX < displayWidth*0.75f) && (Sidebar == true))
  {
    if((mouseY > 0) && (mouseY<200))//Zur Startseite
    {
      ChangingSidebar = false;
      ChangingPage = 1;
      Aktualisierung[6]= "Programm schließen!";
      Aktualisierung[7]= "1";      
      saveStrings( Pfad_Status, Aktualisierung);
    }
    if((mouseY > 200) && (mouseY<400))//Spieler hinzufügen
    {
      ChangingSidebar = false;
      ChangingPage = 4;    
      Aktualisierung[6]= "Programm schließen!";
      Aktualisierung[7]= "1";      
      saveStrings( Pfad_Status, Aktualisierung);
    }
    if((mouseY > 400) && (mouseY<600))//Spieler entfernen
    {
      ChangingSidebar = false;
      ChangingPage = 3; 
      SpielerEntfernen = true;
      Aktualisierung[6]= "Programm schließen!";
      Aktualisierung[7]= "1";      
      saveStrings( Pfad_Status, Aktualisierung);
    }
    if((mouseY > 600) && (mouseY<800))//Debug Outputstream
    {
      ChangingSidebar = false;
      OutputStream = true;

    }
  }
  //Sidebar zurück********************************************************************************
  if ((mouseX > displayWidth*0.75f) && (Sidebar == true))
  {
    ChangingSidebar = false;
  }
}
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



public void Pfadermittlung()
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

public void Einstellungen()
{
   //Einstellungen laden
              screen_setting = PApplet.parseInt(Pfade[27]);
              Betriebssystem = PApplet.parseInt(Pfade[35]);
              println("Betriebssystem: "+Betriebssystem);
              
    println(sketch+" wird im Bildschirm "+screen_setting+ " ausgeführt!");
}
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§  Startseite  §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
boolean page1 = false;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Elemente zum Zeichnen                                                                          §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

//Auswahl Button Neus Spiel Starten+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
boolean Seite1SpielstartAktiv = false; //Auswahl 3Button
public void Seite1Spielstart(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    if (aktiv == true)
    {
      fill(0xff5e7eff);//türkis
    } else
    {
      fill(0xff212d5e);//dunkelblau
    }
    rect(25, 200, displayWidth-50, 200);
    textSize(80);
    textAlign(CENTER);
    fill(230);
    text("KLASSICHES DART", displayWidth/2, 320);
  }
}
//Auswahl Button Neus Spiel Starten2+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
boolean Seite1Spielstart2Aktiv = false; //Auswahl 3Button
public void Seite1Spielstart2(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    if (aktiv == true)
    {
      fill(0xff5e7eff);//türkis
    } else
    {
      fill(0xff212d5e);//dunkelblau
    }
  //Out of Service 
  fill(0xff8E8E8E); //Grau 
    rect(25, 430, displayWidth-50, 200);
    textSize(80);
    textAlign(CENTER);
    fill(230);
    text("SOCCER", displayWidth/2, 550);

  //image(img_beta, 10, 420, 300,200 );
    image(img_ComingSoon, displayWidth*0.67f, 440, 300,200 );
  }
}
//Auswahl Button Neus Spiel Starten3+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
boolean Seite1Spielstart3Aktiv = false; //Auswahl 3Button
public void Seite1Spielstart3(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    if (aktiv == true)
    {
      fill(0xff5e7eff);//türkis
    } else
    {
      fill(0xff212d5e);//dunkelblau
    }
    
  //Out of Service 
  fill(0xff8E8E8E); //Grau 
    rect(25, 660, displayWidth-50, 200);
    textSize(80);
    textAlign(CENTER);
    fill(230);
    text("CRICKET", displayWidth/2, 790);

  image(img_ComingSoon, displayWidth*0.67f, 670, 300,200 );
  }
}
//Auswahl Button Neus Spiel Starten4+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
boolean Seite1Spielstart4Aktiv = false; //Auswahl 4Button
public void Seite1Spielstart4(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    if (aktiv == true)
    {
      fill(0xff5e7eff);//türkis
    } else
    {
      fill(0xff212d5e);//dunkelblau
    }
  //Out of Service 
  fill(0xff8E8E8E); //Grau 
    rect(25, 890, displayWidth-50, 200);
    textSize(80);
    textAlign(CENTER);
    fill(230);
    text("AROUND THE CLOCK", displayWidth/2, 1010);
    
  image(img_ComingSoon, displayWidth*0.67f, 900, 300,200 );
  }
}


//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Button Events                                                                                  §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

public void Page1ButtonEvent()
{
  //Seite1.Neues spiel starten********************************************************************
  //Klassisches Dart starten
  if ((mouseX > 25) && (mouseX<displayWidth-25) && (mouseY >200) && (mouseY<400) && (page1==true))
  {
        PrintWriter output=null;
        Aktualisierung[6]= "Programm schließen!";
        Aktualisierung[7]= "0";      //Programm soll sich nicht schließen 
        saveStrings( Pfad_Status, Aktualisierung);

        output = createWriter("DartscorerAusfuehren.bat");
        output.println("cd "+sketchPath());
        output.println("cd ..");
        if(EXE == true) //kompiliertes Programm
          output.println("cd ..");            
        switch(Betriebssystem)
        {
          case 1: output.println("cd Dartscorer"+File.separator+"application.linux32"); break;
          case 2: output.println("cd Dartscorer"+File.separator+"application.linux64"); break; 
          case 3: output.println("cd Dartscorer"+File.separator+"application.linux-armv6hf"); break;
          case 4: output.println("cd Dartscorer"+File.separator+"application.windows32"); break;
          case 5: output.println("cd Dartscorer"+File.separator+"application.windows64"); break;
        }          
        if(Linux == true)
          output.println("sudo bash Dartscorer"); 
        else
          output.println("start Dartscorer.exe");  
        output.flush();
        output.close();  
        output=null; 
        if(Linux == true)
          exec("bash",sketchPath()+"/DartscorerAusfuehren.bat");
        else
          launch(sketchPath()+"\\DartscorerAusfuehren.bat");
    
        println("externes Programm ausführen: DartscorerAusfuehren.bat");
        ChangingPage = 2;
    
          String[]clear  = {"","","","","","","",""};
          saveStrings(Pfad_Status, clear);
          
          
          Seite2SpielmodiStartwertAktiv=0;
          Seite2SpielmodiInAktiv=0;
          Seite2SpielmodiOutAktiv=0;
          Seite2TeilnehmerAnzahlAktiv=0;
          Seite2WeiterButtonAktiv=false;
          Seite3MitspielerAktiv=0;
          Seite3LosButtonAktiv=false;
          Seite4TexteingabeNameAktiv=false;
          Seite4HinzuButtonAktiv=false;
          Seite6SpielNeustartenAktiv=false;
          Seite6ZumHauptmenuAktiv=false;
          
          Startwert    = " " ;
          SpielmodiIn  = " " ;
          SpielmodiOut = " " ;
          TeilnehmerAnzahl =0;
          
  }
  //Seite1.Neues spiel starten********************************************************************
  //Soccer starten
  if ((mouseX > 25) && (mouseX<displayWidth-25) && (mouseY >430) && (mouseY<630) && (page1==true))
  {
        //PrintWriter output=null;
        //Aktualisierung[6]= "Programm schließen!";
        //Aktualisierung[7]= "0";      //Programm soll sich nicht schließen 
        //saveStrings( Pfad_Status, Aktualisierung);

        //output = createWriter("DartSoccerAusfuehren.bat");
        //output.println("cd "+sketchPath());
        //output.println("cd ..");
        //if(EXE == true) //kompiliertes Programm
        //  output.println("cd ..");            
        //switch(Betriebssystem)
        //{
        //  case 1: output.println("cd DartSoccer"+File.separator+"application.linux32"); break;
        //  case 2: output.println("cd DartSoccer"+File.separator+"application.linux64"); break; 
        //  case 3: output.println("cd DartSoccer"+File.separator+"application.linux-armv6hf"); break;
        //  case 4: output.println("cd DartSoccer"+File.separator+"application.windows32"); break;
        //  case 5: output.println("cd DartSoccer"+File.separator+"application.windows64"); break;
        //}          
        //if(Linux == true)
        //  output.println("sudo bash DartSoccer"); 
        //else
        //  output.println("start DartSoccer.exe");  
        //output.flush();
        //output.close();  
        //output=null; 
        //if(Linux == true)
        //  exec("bash",sketchPath()+"/DartSoccerAusfuehren.bat");
        //else
        //  launch(sketchPath()+"\\DartSoccerAusfuehren.bat");
    
        //ChangingPage = 7;
    
        //  String[]clear  = {"","","","","","","",""};
        //  saveStrings(Pfad_Status, clear);
          
          
        //  Seite2SpielmodiStartwertAktiv=0;
        //  Seite2SpielmodiInAktiv=0;
        //  Seite2SpielmodiOutAktiv=0;
        //  Seite2TeilnehmerAnzahlAktiv=0;
        //  Seite2WeiterButtonAktiv=false;
        //  Seite3MitspielerAktiv=0;
        //  Seite3LosButtonAktiv=false;
        //  Seite4TexteingabeNameAktiv=false;
        //  Seite4HinzuButtonAktiv=false;
        //  Seite6SpielNeustartenAktiv=false;
        //  Seite6ZumHauptmenuAktiv=false;
          
        //  Startwert    = " " ;
        //  SpielmodiIn  = " " ;
        //  SpielmodiOut = " " ;
        //  TeilnehmerAnzahl =0;
          
  }
}
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§  Spielmodi  §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
boolean page2 = false;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Elemente zum Zeichnen                                                                          §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

//Auswahl Button zum Auswählen des Spielmodis 301,501,...+++++++++++++++++++++++++++++++++++++++++
int Seite2SpielmodiStartwertAktiv = 0;
public void Seite2SpielmodiStartwert(boolean sichtbar, int aktiv)
{
  if (sichtbar == true)
  {
    fill(0xff212d5e);
    rect(25, 200, displayWidth-50, 200);
    textSize(80);
    textAlign(RIGHT);
    fill(230);
    text("301", ((25+((displayWidth-50)/3))-80), 320);
    text("501", ((25+((displayWidth-50)/3)*2)-80), 320);
    text("901", ((25+((displayWidth-50)/3)*3)-80), 320);
    if (aktiv == 1)
    {
      fill(0xff5e7eff);
      rect(25, 200, (displayWidth-50)/3, 200);
      fill(230);
      text("301", ((25+((displayWidth-50)/3))-80), 320);
      Startwert = "301";
    }
    if (aktiv == 2)
    {
      fill(0xff5e7eff);
      rect(25+((displayWidth-50)/3), 200, (displayWidth-50)/3, 200);
      fill(230);
      text("501", ((25+((displayWidth-50)/3)*2)-80), 320);
      Startwert = "501";
    }
    if (aktiv == 3)
    {
      fill(0xff5e7eff);
      rect(25+((displayWidth-50)/3)*2, 200, (displayWidth-50)/3, 200);
      fill(230);
      text("901", ((25+((displayWidth-50)/3)*3)-80), 320);
      Startwert = "901";
    }
    //Trennlinie
    stroke(205);
    line(25+((displayWidth-50)/3), 200, 25+((displayWidth-50)/3), 200+200);
    line(25+((displayWidth-50)/3)*2, 200, 25+((displayWidth-50)/3)*2, 200+200);
    noStroke();
  }
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Auswahl Button Spielmodi In ( DoubleIn, SingleIn)

int Seite2SpielmodiInAktiv = 0;
public void Seite2SpielmodiIn(boolean sichtbar, int aktiv)
{
  if (sichtbar == true)
  {
    fill(0xff212d5e);
    rect(25, 420, displayWidth-50, 200);
    textSize(80);
    textAlign(CENTER);
    fill(230);
    text("SI", ((displayWidth/2)/2), 540);
    text("DI", ((displayWidth/2)/2)*3, 540);
    if (aktiv == 1)
    {
      fill(0xff5e7eff);
      rect(25, 420, (displayWidth-50)/2, 200);
      fill(230);
      text("SI", ((displayWidth/2)/2), 540);
      SpielmodiIn = "SI";
    }
    if (aktiv == 2)
    {
      fill(0xff5e7eff);
      rect(25+((displayWidth-50)/2), 420, (displayWidth-50)/2, 200);
      fill(230);
      text("DI", ((displayWidth/2)/2)*3, 540);
      SpielmodiIn = "DI";
    }

    //Trennlinie
    stroke(205);
    line(25+((displayWidth-50)/2), 420, 25+((displayWidth-50)/2), 420+200);
    noStroke();
  }
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Auswahl Button Spielmodi Out ( DoubleOut, SingleOut)
int Seite2SpielmodiOutAktiv = 0;
public void Seite2SpielmodiOut(boolean sichtbar, int aktiv)
{
  if (sichtbar == true)
  {
    fill(0xff212d5e);
    rect(25, 640, displayWidth-50, 200);
    textSize(80);
    textAlign(RIGHT);
    fill(230);
    text("SO", (25+(((displayWidth-50)/3))  -75), 760);
    text("DO", (25+(((displayWidth-50)/3)*2)-85), 760);
    text("MO", (25+(((displayWidth-50)/3)*3)-75), 760);
    if (aktiv == 1)
    {
      fill(0xff5e7eff);
      rect(25, 640, (displayWidth-50)/3, 200);
      fill(230);
      text("SO", (25+(((displayWidth-50)/3))  -75), 760);
      SpielmodiOut = "SO";
    }
    if (aktiv == 2)
    {
      fill(0xff5e7eff);
      rect(25+((displayWidth-50)/3), 640, (displayWidth-50)/3, 200);
      fill(230);
      text("DO", (25+(((displayWidth-50)/3)*2)-85), 760);
      SpielmodiOut = "DO";
    }
    if (aktiv == 3)
    {
      fill(0xff5e7eff);
      rect(25+((displayWidth-50)/3)*2, 640, (displayWidth-50)/3, 200);
      fill(230);
      text("MO", (25+(((displayWidth-50)/3)*3)-75), 760);
      SpielmodiOut = "MO";
    }
    //Trennlinie
    stroke(205);
    line(25+((displayWidth-50)/3), 640, 25+((displayWidth-50)/3), 640+200);
    line(25+((displayWidth-50)/3)*2, 640, 25+((displayWidth-50)/3)*2, 640+200);
    noStroke();
  }
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Drop Down zur Auswahl der Anzahl der Spieler

int Seite2TeilnehmerAnzahlAktiv = 0;
public void Seite2TeilnehmerAnzahl(boolean sichtbar, int aktiv)
{
  if (sichtbar == true)
  {
    fill(0xff212d5e);
    rect(25, 860, displayWidth-50, 400);
    textSize(80);
    textAlign(CENTER);
    fill(230);
    text("ANZAHL SPIELER", displayWidth/2, 990);
    stroke(220);
    line(25, 1060, displayWidth-25, 1060);
    line((((displayWidth-50)/8)*1)+25, 1060, (((displayWidth-50)/8)*1)+25, 1260);
    line((((displayWidth-50)/8)*2)+25, 1060, (((displayWidth-50)/8)*2)+25, 1260);
    line((((displayWidth-50)/8)*3)+25, 1060, (((displayWidth-50)/8)*3)+25, 1260);
    line((((displayWidth-50)/8)*4)+25, 1060, (((displayWidth-50)/8)*4)+25, 1260);
    line((((displayWidth-50)/8)*5)+25, 1060, (((displayWidth-50)/8)*5)+25, 1260);
    line((((displayWidth-50)/8)*6)+25, 1060, (((displayWidth-50)/8)*6)+25, 1260);
    line((((displayWidth-50)/8)*7)+25, 1060, (((displayWidth-50)/8)*7)+25, 1260);
    noStroke();
    text("1", ((((displayWidth-50)/8)*1)+25)-55, 1180);
    text("2", ((((displayWidth-50)/8)*2)+25)-55, 1180);
    text("3", ((((displayWidth-50)/8)*3)+25)-55, 1180);
    text("4", ((((displayWidth-50)/8)*4)+25)-55, 1180);
    text("5", ((((displayWidth-50)/8)*5)+25)-55, 1180);
    text("6", ((((displayWidth-50)/8)*6)+25)-55, 1180);
    text("7", ((((displayWidth-50)/8)*7)+25)-55, 1180);
    text("8", ((((displayWidth-50)/8)*8)+25)-55, 1180);
    if (aktiv == 1)
    {
      fill(0xff5e7eff);
      rect(25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("1", ((((displayWidth-50)/8)*1)+25)-55, 1180);
      TeilnehmerAnzahl = 1;
    }
    if (aktiv == 2)
    {
      fill(0xff5e7eff);
      rect((((displayWidth-50)/8)*1)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("2", ((((displayWidth-50)/8)*2)+25)-55, 1180);
      TeilnehmerAnzahl = 2;
    }
    if (aktiv == 3)
    {
      fill(0xff5e7eff);
      rect((((displayWidth-50)/8)*2)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("3", ((((displayWidth-50)/8)*3)+25)-55, 1180);
      TeilnehmerAnzahl = 3;
    }
    if (aktiv == 4)
    {
      fill(0xff5e7eff);
      rect((((displayWidth-50)/8)*3)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("4", ((((displayWidth-50)/8)*4)+25)-55, 1180);
      TeilnehmerAnzahl = 4;
    }
    if (aktiv == 5)
    {
      fill(0xff5e7eff);
      rect((((displayWidth-50)/8)*4)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("5", ((((displayWidth-50)/8)*5)+25)-55, 1180);
      TeilnehmerAnzahl = 5;
    }
    if (aktiv == 6)
    {
      fill(0xff5e7eff);
      rect((((displayWidth-50)/8)*5)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("6", ((((displayWidth-50)/8)*6)+25)-55, 1180);
      TeilnehmerAnzahl = 6;
    }
    if (aktiv == 7)
    {
      fill(0xff5e7eff);
      rect((((displayWidth-50)/8)*6)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("7", ((((displayWidth-50)/8)*7)+25)-55, 1180);
      TeilnehmerAnzahl = 7;
    }
    if (aktiv == 8)
    {
      fill(0xff5e7eff);
      rect((((displayWidth-50)/8)*7)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("8", ((((displayWidth-50)/8)*8)+25)-55, 1180);
      TeilnehmerAnzahl = 8;
    }
    //Trennlinie
    stroke(205);
    line(25+((displayWidth-50)/3), 640, 25+((displayWidth-50)/3), 640+200);
    line(25+((displayWidth-50)/3)*2, 640, 25+((displayWidth-50)/3)*2, 640+200);
    noStroke();
  }
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Weiter Button Seite 2
boolean Seite2WeiterButtonAktiv = false; 
public void Seite2WeiterButton(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    if (aktiv == true)
    {
      fill(0xff00E323);//grün
    } else
    {
      fill(100);//dunkelblau
    }
    rect(25, 1280, displayWidth-50, 200);
    textSize(70);
    textAlign(CENTER);
    fill(230);
    text("WEITER", displayWidth/2, 1400);
  }
}


//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Button Events                                                                                  §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

public void Page2ButtonEvent()
{
  //Seite2.Spielmode Startwert********************************************************************
  if ((mouseX > 25) && (mouseX<displayWidth-25) && (mouseY > 200) && (mouseY<400) && (page2==true))
  {
    if ((mouseX > 25) && (mouseX<((displayWidth-50)/3)))//Teilbutton1
    {
      Seite2SpielmodiStartwertAktiv =1;
    }
    if ((mouseX > ((displayWidth-50)/3)) && (mouseX<2*((displayWidth-50)/3)))//Teilbutton2
    {
      Seite2SpielmodiStartwertAktiv =2;
    }
    if ((mouseX > 2*((displayWidth-50)/3)) && (mouseX<displayWidth-25))//Teilbutton1
    {
      Seite2SpielmodiStartwertAktiv =3;
    }
  }
  //Seite2.Spielmodi Input************************************************************************
  if ((mouseX > 25) && (mouseX<displayWidth-25) && (mouseY > 420) && (mouseY<620) && (page2==true))
  {
    if ((mouseX > 25) && (mouseX<((displayWidth)/2)))//Teilbutton1
    {
      Seite2SpielmodiInAktiv =1;
    }
    if ((mouseX > ((displayWidth)/2)) && (mouseX<(displayWidth-25)))//Teilbutton2
    {
      Seite2SpielmodiInAktiv =2;
    }
  }
  //Seite2.Spielmodi Output***********************************************************************
  if ((mouseX > 25) && (mouseX<displayWidth-25) && (mouseY > 640) && (mouseY<840) && (page2==true))
  {
    if ((mouseX > 25) && (mouseX<((displayWidth-50)/3)))//Teilbutton1
    {
      Seite2SpielmodiOutAktiv =1;
    }
    if ((mouseX > ((displayWidth-50)/3)) && (mouseX<2*((displayWidth-50)/3)))//Teilbutton2
    {
      Seite2SpielmodiOutAktiv =2;
    }
    if ((mouseX > 2*((displayWidth-50)/3)) && (mouseX<displayWidth-25))//Teilbutton1
    {
      Seite2SpielmodiOutAktiv =3;
    }
  }
  //Seite2.Anzahl Spieler**************************************************************************
  if ((mouseX > 25) && (mouseX<displayWidth-25) && (mouseY > 1060) && (mouseY<1260) && (page2==true))
  {
    if ((mouseX > 25) && (mouseX<((displayWidth-50)/8)+25))//Teilbutton1
    {
      Seite2TeilnehmerAnzahlAktiv =1;
    }
    if ((mouseX > (((displayWidth-50)/8)+25)) && (mouseX<(((displayWidth-50)/8)*2)+25))//Teilbutton2
    {
      Seite2TeilnehmerAnzahlAktiv =2;
    }
    if ((mouseX > (((displayWidth-50)/8)*2)+25) && (mouseX<(((displayWidth-50)/8)*3)+25))//Teilbutton2
    {
      Seite2TeilnehmerAnzahlAktiv =3;
    }
    if ((mouseX > (((displayWidth-50)/8)*3)+25) && (mouseX<(((displayWidth-50)/8)*4)+25))//Teilbutton2
    {
      Seite2TeilnehmerAnzahlAktiv =4;
    }
    if ((mouseX > (((displayWidth-50)/8)*4)+25) && (mouseX<(((displayWidth-50)/8)*5)+25))//Teilbutton2
    {
      Seite2TeilnehmerAnzahlAktiv =5;
    }
    if ((mouseX > (((displayWidth-50)/8)*5)+25) && (mouseX<(((displayWidth-50)/8)*6)+25))//Teilbutton2
    {
      Seite2TeilnehmerAnzahlAktiv =6;
    }
    if ((mouseX > (((displayWidth-50)/8)*6)+25) && (mouseX<(((displayWidth-50)/8)*7)+25))//Teilbutton2
    {
      Seite2TeilnehmerAnzahlAktiv =7;
    }
    if ((mouseX > (((displayWidth-50)/8)*7)+25) && (mouseX<(((displayWidth-50)/8)*8)+25))//Teilbutton2
    {
      Seite2TeilnehmerAnzahlAktiv =8;
    }
  }
  //Seite2.Weiter*********************************************************************************
  if ((mouseX > 25) && (mouseX<displayWidth-25) && (mouseY>1280) && (page2==true) 
    && (Seite2WeiterButtonAktiv==true))
  {
    ChangingPage = 3;
  }

}
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§  SpielerAuswahl  §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

boolean    page3 = false;
int        AnzahlAllerSpieler = 0;
int        AnzahlAllerSpielerVergleich = 1;
boolean    SpielerEntfernen = false;
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Spieler Klasse                                                                                 §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
public class Spieler
{
  String  Name;
  boolean MitSpieler;   
  String  LiedName;
  int   SpielerFarbe;

  //Konstruktoren+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Spieler(String NameDesSpielers, String NameDesLieds, int FarbeDesSpielers)
  {
    Name = NameDesSpielers;
    LiedName = NameDesLieds;
    SpielerFarbe = FarbeDesSpielers;
  }
  //Methoden++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  public void card()
  {
  }
  //Interne Methoden++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //protected 
  protected void RangAktualisieren()
  {
  }
}
/////////////////////////////////////////////////////////////////////////////////////////////////
//FUNKTION UM FESTZUSTELLEN WIEVIELE SPIELER MITSPIELER SIND
public int Seite3PruefeMitspieler()
{
  try
  {
    int Anzahl = 0;
    for (int i=1; i<=AnzahlAllerSpieler; i++)
    {
      if (Player[i].MitSpieler == true)
        Anzahl = Anzahl + 1;
    }
    return Anzahl;
  }
  catch(Exception e)
  {
    int ret = -1;
    return ret;
  }
}
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Spieler anlegen mit Klasse Spieler                                                             §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
public void Seite3SpielerAnlegen(boolean Aktiv)
{
  if (Aktiv == true)
  {
    if (AnzahlAllerSpielerVergleich != AnzahlAllerSpieler)
    {
      boolean abbruch = false;
      for ( int i=1; i<100; i++)
      { 
        TextDokument = loadStrings(Pfad_Player+i+".INOUT");
        if ((TextDokument==null))
        {
          AnzahlAllerSpieler = i-1;
          println(AnzahlAllerSpieler+" Spieler aktuell gelistet.");
          abbruch = true;
        }    
        if (abbruch==true) break;
      } 

      for ( int i=1; i<=AnzahlAllerSpieler; i++)
      {
        TextDokument= loadStrings(Pfad_Player+i+".INOUT");     
        Player[i] = new Spieler(TextDokument[1], TextDokument[5], color(PApplet.parseInt(TextDokument[3])));
        AnzahlAllerSpielerVergleich = AnzahlAllerSpieler;
      }
    }
  }
}
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Elemente zum Zeichnen                                                                          §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


//Auswahl Der Button von Mitspielern+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
int Seite3MitspielerAktiv = 0; 
public void Seite3Mitspieler(boolean sichtbar, int aktiv)
{
  if (sichtbar == true)
  {
    textSize(80);
    textAlign(CENTER);
    fill(0xff212d5e);
    rect(25, 180, displayWidth-50, 1000);
    
    if (AnzahlAllerSpieler > 0)//Fehler abfangen Division durch null
    {
      boolean SpielerAn = false;
      int teilung = 1000/AnzahlAllerSpieler;
      for (int i=1; i<=AnzahlAllerSpieler; i++)
      {
        if (Player[i].MitSpieler == true)
        {
          SpielerAn = true;
          fill(0xff5e7eff);//türkis
          rect(25, 180+(teilung*(i-1)), displayWidth-50, teilung);
        }
        fill(220);
        text(Player[i].Name, displayWidth/2, 200+(teilung/2)+((i-1)*teilung));
      }
      if (SpielerAn == true)
      {
        Seite3MitspielerAktiv = 1;
      }
      else
        Seite3MitspielerAktiv = 0;
    }
  }
}


        //rect(25, 180+(teilung*(i)), displayWidth-50, teilung);
        //fill(220);
        //textSize(80);
        //textAlign(CENTER);
        //text(TeilnehmerVergleich[i], displayWidth/2 ,200+(teilung/2)+(teilung*(i)));
        
//*************************************************************************************************
//Los Gehts Button Seite 3 bzw. Spieler entfernen
boolean Seite3LosButtonAktiv = false; 
public void Seite3LosButton(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    if (aktiv == true)
    {
      if(SpielerEntfernen == false)
        fill(0xff00E323);//grün
      else
        fill(0xffFF5252);
    } 
    else
    {
      fill(100);
    }
    rect(25, 1220, displayWidth-50, 200);
    textSize(80);
    textAlign(CENTER);
    fill(230);
    if(SpielerEntfernen == false)
      text("LOS GEHTS!", displayWidth/2, 1337);
    else
      text("ENTFERNEN", displayWidth/2, 1337);
  }
}


//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Button Events                                                                                  §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

public void Page3ButtonEvent()
{

  //Seite3.Spielerauswahl**************************************************************************
  if ((mouseY > 180) && (mouseY<1280) && (page3==true) )
  {
    if (AnzahlAllerSpieler > 0)//Fehelr abfangen Division durch null
    {
        println(AnzahlAllerSpieler);
        int teilung = 1000/AnzahlAllerSpieler;
    
        for ( int i=1; i<=AnzahlAllerSpieler; i++)
        {
          if ((mouseY > 180+((i-1)*teilung)) && (mouseY< 180+(i*teilung))) 
          {
            if ( Player[i].MitSpieler == true) 
              Player[i].MitSpieler = false;
            else
              Player[i].MitSpieler = true;
          }
        }
     }
  }
  //Seite3.Los Gehts Button************************************************************************
  if ( (mouseY > 1250) && (mouseY<1350) && (page3==true) && (Seite3LosButtonAktiv==true) )
  {
    if(SpielerEntfernen == false)
    {
        if(Seite7WarAktiv == false) //Tastatur für klassisch Dart++++++++++++++++++++++++++++++++++
        {
              ChangingPage = 5;     
              String IntSpielmodiIn  ="";
              String IntSpielmodiOut ="";
          
              if (SpielmodiIn == "SI")
                IntSpielmodiIn = "1";
              if (SpielmodiIn == "DI")
                IntSpielmodiIn = "2";
              if (SpielmodiOut == "SO")
                IntSpielmodiOut = "1";
              if (SpielmodiOut == "DO")
                IntSpielmodiOut = "2";
              if (SpielmodiOut == "MO")
                IntSpielmodiOut = "3";
          
              String Spielmodi[] = {Startwert, 
                                    "IN: 1=Single, 2=Double", 
                                    IntSpielmodiIn, 
                                    "OUT:1=Single, 2=Double, 3=Master", 
                                    IntSpielmodiOut,
                                    "5",
                                    "Spielzeit in Minuten"};
              saveStrings(Pfad_Spielmodi, Spielmodi);
              
          
        }
        if(Seite7WarAktiv == true) //Eingabe für Soccer++++++++++++++++++++++++++++++++++++++++++++++
        {
          ChangingPage = 8;
              String Spielmodi[] = {"",
                                    "",
                                    "",
                                    "",
                                    "",
                                    str(Seite7SpielzeitAktiv), 
                                    "Spielzeit in Minuten"};
              saveStrings(Pfad_Spielmodi, Spielmodi);
          
        }
        Seite7WarAktiv = false;
        String Teilnehmer[] = new String[TeilnehmerAnzahl];
        int zeahler = 0;
        for(int i=1; i<=AnzahlAllerSpieler ; i++)
        {
          if(Player[i].MitSpieler==true)
          {     
            Teilnehmer[zeahler] = Player[i].Name;
            zeahler++;
          }
        }
        saveStrings( Pfad_Teilnehmer, Teilnehmer);
        
        for(int i=1; i<=AnzahlAllerSpieler ; i++)
        {
          if(Player[i].MitSpieler==true)
            Player[i].MitSpieler = false;
        }          
     

     }
     else // Seite nutzen für Spieler entfernen
     {
        ChangingPage = 1;
        SpielerEntfernen = false;
        for(int i=1; i<=AnzahlAllerSpieler ; i++)
        {
          if(Player[i].MitSpieler==true)//Person löschen
          {
            File f = new File(dataPath(Pfad_Player+i+".INOUT"));
            f.delete();
            println("Spieler "+i+" wurde entfernt!");
            for(int k=i; k<=AnzahlAllerSpieler-1 ; k++)//Alle Folgeelemte nachrücken und das letzte löschen
            {
              TextDokument= loadStrings(Pfad_Player+(k+1)+".INOUT"); 
              saveStrings(Pfad_Player+k+".INOUT", TextDokument );
            }
            File l = new File(dataPath(Pfad_Player+AnzahlAllerSpieler+".INOUT"));  
            l.delete();
            AnzahlAllerSpieler--;
          }
        }
     }
  }

}
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§  SpielerHinzu  §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
boolean    page4 = false;
Spieler[]  Player = new Spieler[100];
String[]   TextDokument = new String[20];  //Buffer vom Textdokument 20 Zeilen

String     Anhaengen = "";
String     Name = "";


//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Elemente zum Zeichnen                                                                          §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

public void Seite4Tastatureingabe(boolean sichtbar)
{
  if (sichtbar == true)
  {
    fill(200);
    rect(0,1200,displayWidth,1200);
    stroke(170);
    line(0, displayHeight-((displayHeight-1200)/3)*1,displayWidth,displayHeight-((displayHeight-1200)/3)*1);
    line(0, displayHeight-((displayHeight-1200)/3)*2,displayWidth,displayHeight-((displayHeight-1200)/3)*2);
    for(int i=1;i<11;i++)
    {
      if((i==1)||(i==10))
        line((displayWidth/11)*i,1200,(displayWidth/11)*i,displayHeight-((displayHeight-1200)/3)*1);
      else
        line((displayWidth/11)*i,1200,(displayWidth/11)*i,displayHeight);
    }
    String[] Tastatur = {"Q","W","E","R","T","Z","U","I","O","P","Ü","A","S","D","F","G","H","J","K","L","Ö",
                         "Ä","Y","X","C","V","B","N","M"};
    for(int i=0;i<Tastatur.length;i++)
    {
      fill(50);
      if(i<11)
        text(Tastatur[i],(displayWidth/11)*(i+1)-20,(displayHeight-((displayHeight-1200)/3)*2)-40);
      if(i>=11)
        text(Tastatur[i],(displayWidth/11)*(i-10)-20,(displayHeight-((displayHeight-1200)/3)*1)-40);
      if(i>21)
        text(Tastatur[i],(displayWidth/11)*(i-19)-20,(displayHeight-((displayHeight-1200)/3)*0)-40);
      PImage img; 
      img = loadImage("Bilder/PfeilIcon.png");
      image(img, displayWidth-145, displayHeight-108, 100, 100 );
    }
  }
}
//*************************************************************************************************
//Texteingabefeld Name
boolean BuchstabeAbziehen = false;
boolean Seite4TexteingabeNameAktiv = false;
public void Seite4TexteingabeName(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    textAlign(LEFT);
    text("NAME EINGEBEN:",25,230);
    stroke(0);
    fill(230);
    rect(25,260,displayWidth-50, 100);
    if(aktiv==true)
    {
      stroke(0xff5e7eff);
      strokeWeight(10);
      fill(230);
      rect(25,260,displayWidth-50, 100);
      strokeWeight(1);
      noStroke();
      if(BuchstabeAbziehen == true)
      {
        if( Name.length()>0)
          Name =  Name.substring( 0, Name.length()-1 );
        BuchstabeAbziehen = false;
      }
      else
      if(Anhaengen != "")
      Name = Name + Anhaengen;
      fill(30);
      text(Name,50,330);
    }
  }
}
//*************************************************************************************************
//CollerPicker Seite 4
int Farbe_R = 100;
int Farbe_G = 100;
int Farbe_B = 100;

int Slider_R = 510;
int Slider_G = 510;
int Slider_B = 510;

int Spielerfarbe = 0;

public void Seite4Collerpicker(boolean sichtbar)
{
  if(sichtbar == true)
  {
    fill(30);
    textAlign(LEFT);
    text("FARBE EINSTELLEN:",25,430);    

    
    //Kasten mit RGB Farbe
    fill(Farbe_R,Farbe_G,Farbe_B);
    rect(25,450,width-50,360);
    
    //Slider RGB
    //R
    fill(230);
    text("R",80,540); 
    fill(230);
    rect(240,520,510,10);
    fill(100);
    circle(Slider_R+2,528,53);
    fill(230);
    circle(Slider_R,525,50);
    //G
    fill(230);
    text("G",80,640); 
    fill(230);
    rect(240,620,510,10);
    fill(100);
    circle(Slider_G+2,628,53);
    fill(230);
    circle(Slider_G,625,50);
    //B
    fill(230);
    text("B",80,740); 
    fill(230);
    rect(240,720,510,10);
    fill(100);
    circle(Slider_B+2,728,53);
    fill(230);
    circle(Slider_B,725,50);
    
    Spielerfarbe = color(Farbe_R,Farbe_G,Farbe_B);
  }
}
//*************************************************************************************************
//Einfach Aus Seite 4
boolean Seite4EinfachAusAktiv = false; 
String Seite4EinfachAusString = "0";
public void Seite4EinfachAus(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    if (aktiv == true)
    {
      fill(0xff5e7eff);//türkis
      Seite4EinfachAusString = "1";
    }
    else
    {
      fill(100);//dunkelblau
      Seite4EinfachAusString = "0";
    }
    rect(625,830,250,100);
    textAlign(CENTER);
    fill(230);
    if ( aktiv == true)
      text("AKTIV",750,900);
    else
      text("INAKTIV",750,900);
    fill(30);
    textAlign(LEFT);
    text("EINFACH AUS:",25,880);
  }
}
//*************************************************************************************************
//Hinzu Button Seite 4
boolean Seite4HinzuButtonAktiv = false; 

public void Seite4HinzuButton(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    if (aktiv == true)
    {
      fill(0xff00E323);//grün
    } else
    {
      fill(100);//dunkelblau
    }
    rect(25, 970, displayWidth-50, 200);
    textSize(50);
    textAlign(CENTER);
    fill(230);
    text("SPIELER ERSTELLEN", displayWidth/2, 1090);
  }
}
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Button Events                                                                                  §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
public void Page4ButtonEvent()
{
  //Seite4.Tastatureingabe************************************************************************
  if ((mouseY >1200) && (page4==true)) //Tastaturbereich
  {
    if ((mouseY< displayHeight-((displayHeight-1200)/3)*2)) //erste Reihe
    {
      if( (mouseX>(displayWidth/11)*0) && (mouseX<(displayWidth/11)*1))
        Anhaengen = "Q";
      if( (mouseX>(displayWidth/11)*1) && (mouseX<(displayWidth/11)*2))
        Anhaengen = "W"; 
      if( (mouseX>(displayWidth/11)*2) && (mouseX<(displayWidth/11)*3))
        Anhaengen = "E";   
      if( (mouseX>(displayWidth/11)*3) && (mouseX<(displayWidth/11)*4))
        Anhaengen = "R";   
      if( (mouseX>(displayWidth/11)*4) && (mouseX<(displayWidth/11)*5))
        Anhaengen = "T";   
      if( (mouseX>(displayWidth/11)*5) && (mouseX<(displayWidth/11)*6))
        Anhaengen = "Z";   
      if( (mouseX>(displayWidth/11)*6) && (mouseX<(displayWidth/11)*7))
        Anhaengen = "U";   
      if( (mouseX>(displayWidth/11)*7) && (mouseX<(displayWidth/11)*8))
        Anhaengen = "I";   
      if( (mouseX>(displayWidth/11)*8) && (mouseX<(displayWidth/11)*9))
        Anhaengen = "O";   
      if( (mouseX>(displayWidth/11)*9) && (mouseX<(displayWidth/11)*10))
        Anhaengen = "P";   
      if( (mouseX>(displayWidth/11)*10) && (mouseX<(displayWidth/11)*11))
        Anhaengen = "Ü";   
    }
    if ((mouseY> displayHeight-((displayHeight-1200)/3)*2) && 
       (mouseY< (displayHeight-((displayHeight-1200)/3)*1)) ) //zweite Reihe
    {
      if( (mouseX>(displayWidth/11)*0) && (mouseX<(displayWidth/11)*1))
        Anhaengen = "A";
      if( (mouseX>(displayWidth/11)*1) && (mouseX<(displayWidth/11)*2))
        Anhaengen = "S"; 
      if( (mouseX>(displayWidth/11)*2) && (mouseX<(displayWidth/11)*3))
        Anhaengen = "D";   
      if( (mouseX>(displayWidth/11)*3) && (mouseX<(displayWidth/11)*4))
        Anhaengen = "F";   
      if( (mouseX>(displayWidth/11)*4) && (mouseX<(displayWidth/11)*5))
        Anhaengen = "G";   
      if( (mouseX>(displayWidth/11)*5) && (mouseX<(displayWidth/11)*6))
        Anhaengen = "H";   
      if( (mouseX>(displayWidth/11)*6) && (mouseX<(displayWidth/11)*7))
        Anhaengen = "J";   
      if( (mouseX>(displayWidth/11)*7) && (mouseX<(displayWidth/11)*8))
        Anhaengen = "K";   
      if( (mouseX>(displayWidth/11)*8) && (mouseX<(displayWidth/11)*9))
        Anhaengen = "L";   
      if( (mouseX>(displayWidth/11)*9) && (mouseX<(displayWidth/11)*10))
        Anhaengen = "Ö";   
      if( (mouseX>(displayWidth/11)*10) && (mouseX<(displayWidth/11)*11))
        Anhaengen = "Ä";   
    }
    if (mouseY> (displayHeight-((displayHeight-1200)/3)*1)) //dritte Reihe
    {
      if( (mouseX>(displayWidth/11)*2) && (mouseX<(displayWidth/11)*3))
        Anhaengen = "Y";   
      if( (mouseX>(displayWidth/11)*3) && (mouseX<(displayWidth/11)*4))
        Anhaengen = "X";   
      if( (mouseX>(displayWidth/11)*4) && (mouseX<(displayWidth/11)*5))
        Anhaengen = "C";   
      if( (mouseX>(displayWidth/11)*5) && (mouseX<(displayWidth/11)*6))
        Anhaengen = "V";   
      if( (mouseX>(displayWidth/11)*6) && (mouseX<(displayWidth/11)*7))
        Anhaengen = "B";   
      if( (mouseX>(displayWidth/11)*7) && (mouseX<(displayWidth/11)*8))
        Anhaengen = "N";   
      if( (mouseX>(displayWidth/11)*8) && (mouseX<(displayWidth/11)*9))
        Anhaengen = "M";   
      if( (mouseX>(displayWidth/11)*9) && (mouseX<(displayWidth/11)*11))
      {
        BuchstabeAbziehen = true;
        Anhaengen = "";
      }
    }
  }  
  if ((mouseY <1200) && (page4==true)) //Tastaturbereich
  {
    Anhaengen = "";
  }
  //Seite4.Texteingabefeld Name********************************************************************
  if ((mouseY >260) && (mouseY <360) && (page4==true))
  {  
    Seite4TexteingabeNameAktiv = true;
  }
  //Seite4.Eingabe der Farbe***********************************************************************
  //Slider für R
  if ((mouseY >500) && (mouseY <550) && (page4==true))
  {  
    if ((mouseX>240) && (mouseX < 750))
    {
      Farbe_R = (mouseX-240)/2;
      Slider_R = mouseX;
    }
  }
  //Slider für G
  if ((mouseY >600) && (mouseY <650) && (page4==true))
  {  
    if ((mouseX>240) && (mouseX < 750))
    {
      Farbe_G = (mouseX-240)/2;
      Slider_G = mouseX;
    }
  }
  //Slider für B
  if ((mouseY >700) && (mouseY <750) && (page4==true))
  {  
    if ((mouseX>240) && (mouseX < 750))
    {
      Farbe_B = (mouseX-240)/2;
      Slider_B = mouseX;
    }
  }
  //Seite4. Einfach Aus****************************************************************************
  if ((mouseY >830) && (mouseY <930) && (mouseX >625) && (page4==true))
  { 
    if ( Seite4EinfachAusAktiv == true )
      Seite4EinfachAusAktiv = false;
    else
      Seite4EinfachAusAktiv = true;
  }
  //Seite4. Spieler Erstellen**********************************************************************
  if ((mouseY >950) && (mouseY <1150) && (page4==true))
  { 
    
    String[] text = {"Spielername:",Name,
                     "Spielerfarbe:",str(Spielerfarbe),
                     "Spielerlied:","Noch nich implementiert",
                     "Spieler kann immer einfach aus machen:",Seite4EinfachAusString};
    saveStrings(Pfad_Player+(AnzahlAllerSpieler+1)+".INOUT", text );
    AnzahlAllerSpieler=AnzahlAllerSpieler+1;
    //page1 = false;
    //page2 = false;
    //page3 = true; 
    //page4 = false;
    //page5 = false;
    //page6 = false;
    ChangingPage = 1;      
  }
}
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§Tastatur§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
boolean page5 = false;

String Pfeil1 = "";
String Pfeil2 = "";
String Pfeil3 = "";

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Elemente zum Zeichnen                                                                          §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
int Seite5PunkteEingabeAktiv = 0;

public void Seite5PunkteEingabe(boolean sichtbar, int aktiv )
{
  if (sichtbar == true)
  {
    int teilung = 0;
    teilung = (displayHeight-(displayHeight-800))/7;
    
    fill(200);
    rect(0,800,displayWidth,800);
    fill(220);
    rect((displayWidth/5)*4,800,1000,1000);

      
    if(aktiv==1)
      fill(0xff5e7eff);
    else
      fill(230);
    rect(0,800+(teilung*5),displayWidth/2,1000);
       
    if(aktiv==2)
      fill(0xff5e7eff);
    else
      fill(230);
    rect(displayWidth/2,800+(teilung*5),displayWidth/2,1000);
    
    stroke(170);

    line(0, 800+(teilung*1),displayWidth,(800+teilung*1));
    line(0, 800+(teilung*2),displayWidth,(800+teilung*2));
    line(0, 800+(teilung*3),displayWidth,(800+teilung*3));
    line(0, 800+(teilung*4),displayWidth,(800+teilung*4));
    line(0, 800+(teilung*5),displayWidth,(800+teilung*5));

    for(int i=1;i<5;i++)
        line((displayWidth/5)*i,800,(displayWidth/5)*i,(800+teilung*5));
    line(displayWidth/2,(800+teilung*5),displayWidth/2,displayHeight);
    
    String[] ZahlenN = {"1","2","3","4","","5","6","7","8","","9","10",
                        "11","12","0","13","14","15","16","25","17",
                        "18","19","20","50","DOUBLE","TRIPLE"};
    String[] ZahlenT = {"T1","T2","T3","T4","","T5","T6","T7","T8",""
                        ,"T9","T10","T11","T12","0","T13","T14","T15",
                        "T16","25","T17",
                        "T18","T19","T20","50","DOUBLE","TRIPLE"};
    String[] ZahlenD = {"D1","D2","D3","D4","","D5","D6","D7","D8","",
                        "D9","D10","D11","D12","0","D13","D14","D15",
                        "D16","25","D17",
                        "D18","D19","D20","50","DOUBLE","TRIPLE"};
    String[] Zahlen  = {};
    switch (aktiv)
    {
      case 0:
        Zahlen = ZahlenN;
        break;
      case 1:
        Zahlen = ZahlenD;
        break;
      case 2:
        Zahlen = ZahlenT;
        break;
    }
    textAlign(CENTER);
    textSize(70);
    for(int i=0;i<Zahlen.length;i++)
    {
      fill(50);
      if(i<5)
        text(Zahlen[i],(displayWidth/5)*(i+1)-90,770+(teilung*1));
      if(i>=5)
        text(Zahlen[i],(displayWidth/5)*(i-4)-90,770+(teilung*2));
      if(i>=9)
        text(Zahlen[i],(displayWidth/5)*(i-9)-90,770+(teilung*3));
      if(i>14)
        text(Zahlen[i],(displayWidth/5)*(i-14)-90,770+(teilung*4));
      if((i>=19)&&(i<25))
        text(Zahlen[i],(displayWidth/5)*(i-19)-90,770+(teilung*5));
      if(i==25)//Double
      {
        text(Zahlen[i],((displayWidth/5)*(i-23)-20)-100,800+(teilung*6));
      }
      if(i==26)//Trible
      {
        text(Zahlen[i],((displayWidth/5)*(i-23)-20)+160,800+(teilung*6));
      }
    }
  }
}
//Pfeilanzeige1++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

boolean Seite5Pfeil1AnzeigeAktiv = false;
public void Seite5Pfeil1Anzeige(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    textAlign(CENTER);
    stroke(0);
    fill(230);
    rect(80,260,(displayWidth/3)-80, 200);
    fill(0);
    textSize(120);
    text(Pfeil1,190,390);
    if(aktiv==true)
    {
      stroke(0xff5e7eff);
      strokeWeight(10);
      noFill();
      rect(80,260,(displayWidth/3)-80, 200);
      strokeWeight(1);
      noStroke();
    }
  }
}
//Pfeilanzeige2++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

boolean Seite5Pfeil2AnzeigeAktiv = false;
public void Seite5Pfeil2Anzeige(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    textAlign(CENTER);
    stroke(0);
    fill(230);
    rect(340,260,(displayWidth/3)-80, 200);
    fill(0);
    textSize(120);
    text(Pfeil2,450,390);
    if(aktiv==true)
    {
      stroke(0xff5e7eff);
      strokeWeight(10);
      noFill();
      rect(340,260,(displayWidth/3)-80, 200);
      strokeWeight(1);
      noStroke();

    }
  }
}
//Pfeilanzeige3++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

boolean Seite5Pfeil3AnzeigeAktiv = false;
public void Seite5Pfeil3Anzeige(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    textAlign(CENTER);
    stroke(0);
    fill(230);
    rect(600,260,(displayWidth/3)-80, 200);
    fill(0);
    textSize(120);
    text(Pfeil3,710,390);
    if(aktiv==true)
    {
      stroke(0xff5e7eff);
      strokeWeight(10);
      noFill();
      rect(600,260,(displayWidth/3)-80, 200);
      strokeWeight(1);
      noStroke();
    }
  }
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Seite 5 Ok button
boolean Seite5OkButtonAktiv = false; 
public void Seite5OkButton(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    if (aktiv == true)
    {
      fill(0xff00E323);//grün
    } else
    {
      fill(100);//dunkelblau
    }
    rect(25, 550, displayWidth-50, 200);
    textSize(90);
    textAlign(CENTER);
    fill(230);
    text("OKAY!", displayWidth/2, 680);
  }
}
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Button Events                                                                                  §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


public void Page5ButtonEvent()
{
  int Nummer  = 0;
  boolean Eingabe = false;
  //Seite5.Punkteeingabe**************************************************************************
  if ((mouseY >800) && (page5==true)) //Punkteeingabebereich
  {

    int teilung = 0;
    teilung = (displayHeight-(displayHeight-800))/7;
   

    if ((mouseY< 800+teilung)) //erste Reihe
    {
      if( (mouseX>(displayWidth/5)*0) && (mouseX<(displayWidth/5)*1))//1
        Nummer = 1;
      if( (mouseX>(displayWidth/5)*1) && (mouseX<(displayWidth/5)*2))//2
        Nummer = 2;
      if( (mouseX>(displayWidth/5)*2) && (mouseX<(displayWidth/5)*3))//3
        Nummer = 3;   
      if( (mouseX>(displayWidth/5)*3) && (mouseX<(displayWidth/5)*4))//4
        Nummer = 4; 
      if( (mouseX>(displayWidth/5)*4) && (mouseX<(displayWidth/5)*5))//Reserve
        Nummer = 5;
      Eingabe = true;
    }
    if ((mouseY>800+teilung) &&  mouseY< 800+teilung*2 ) //zweite Reihe
    {
      if( (mouseX>(displayWidth/5)*0) && (mouseX<(displayWidth/5)*1))//5
        Nummer = 6;
      if( (mouseX>(displayWidth/5)*1) && (mouseX<(displayWidth/5)*2))//6
        Nummer = 7;
      if( (mouseX>(displayWidth/5)*2) && (mouseX<(displayWidth/5)*3))//7
        Nummer = 8;   
      if( (mouseX>(displayWidth/5)*3) && (mouseX<(displayWidth/5)*4))//8
        Nummer = 9; 
      if( (mouseX>(displayWidth/5)*4) && (mouseX<(displayWidth/5)*5))//Reserve
        Nummer = 10;
      Eingabe = true;
    }
    if (mouseY> 800+teilung*2 && mouseY< 800+teilung*3 ) //dritte Reihe
    {
      if( (mouseX>(displayWidth/5)*0) && (mouseX<(displayWidth/5)*1))//9
        Nummer = 11;
      if( (mouseX>(displayWidth/5)*1) && (mouseX<(displayWidth/5)*2))//10
        Nummer = 12;
      if( (mouseX>(displayWidth/5)*2) && (mouseX<(displayWidth/5)*3))//11
        Nummer = 13;   
      if( (mouseX>(displayWidth/5)*3) && (mouseX<(displayWidth/5)*4))//12
        Nummer = 14; 
      if( (mouseX>(displayWidth/5)*4) && (mouseX<(displayWidth/5)*5))//0
      {//Prüfen on Eingabefelder leer sind und auffüllen mit 0
        if(Pfeil1 == "" && Pfeil2 == "" && Pfeil3 == "" )
        {
          Pfeil1 = "0";
          Pfeil2 = "0";
          Pfeil3 = "0";
        }
        if(Pfeil2 == "" && Pfeil3 == "")
        {
          Pfeil2 = "0";
          Pfeil3 = "0";
        }        
        if(Pfeil3 == "")
          Pfeil3 = "0";
        Nummer = 15;  
      }
      Eingabe = true;
    }
    if (mouseY> 800+teilung*3 && mouseY< 800+teilung*4 ) //vierte Reihe
    {
      if( (mouseX>(displayWidth/5)*0) && (mouseX<(displayWidth/5)*1))//13
        Nummer = 16;
      if( (mouseX>(displayWidth/5)*1) && (mouseX<(displayWidth/5)*2))//14
        Nummer = 17;
      if( (mouseX>(displayWidth/5)*2) && (mouseX<(displayWidth/5)*3))//15
        Nummer = 18;   
      if( (mouseX>(displayWidth/5)*3) && (mouseX<(displayWidth/5)*4))//16
        Nummer = 19; 
      if( (mouseX>(displayWidth/5)*4) && (mouseX<(displayWidth/5)*5))//25
        Nummer = 20;   
      Eingabe = true;
    }
    if (mouseY> 800+teilung*4 && mouseY< 800+teilung*5 ) //fünfte Reihe
    {
      if( (mouseX>(displayWidth/5)*0) && (mouseX<(displayWidth/5)*1))//17
        Nummer = 21;
      if( (mouseX>(displayWidth/5)*1) && (mouseX<(displayWidth/5)*2))//18
        Nummer = 22;
      if( (mouseX>(displayWidth/5)*2) && (mouseX<(displayWidth/5)*3))//19
        Nummer = 23;   
      if( (mouseX>(displayWidth/5)*3) && (mouseX<(displayWidth/5)*4))//20
        Nummer = 24; 
      if( (mouseX>(displayWidth/5)*4) && (mouseX<(displayWidth/5)*5))//50
        Nummer = 25;   
      Eingabe = true;
    }
    if (mouseY> 800+teilung*5  && (page5==true)) //sechste Reihe
    {
      if(mouseX > displayWidth/2  && (page5==true)) //Triple
      {
        if(Seite5PunkteEingabeAktiv!=2)
        {
          Seite5PunkteEingabeAktiv = 2;
        } 
        else
          Seite5PunkteEingabeAktiv = 0;
      }
      if(mouseX < displayWidth/2) //Double
      {
        if(Seite5PunkteEingabeAktiv!=1)
          Seite5PunkteEingabeAktiv = 1;
        else
          Seite5PunkteEingabeAktiv = 0;
      }
    }
  if(Eingabe==true  && (page5==true))
  {
      String Punkte ="";
      //Auflösung der Nummer zur String Variable
      switch (Nummer)
      {
        case 0:
          Punkte = "";
          break;
        case 1:
          Punkte = "1";
          break;
        case 2:
          Punkte = "2";
          break;
        case 3:
          Punkte = "3";
          break;    
        case 4:
          Punkte = "4";
          break;
        case 5:
          Punkte = "";//Reserve
          break;
        case 6:
          Punkte = "5";
          break;
        case 7:
          Punkte = "6";
          break; 
        case 8:
          Punkte = "7";
          break;
        case 9:
          Punkte = "8";
          break;
        case 10:
          Punkte = "";//Reserve
          break; 
        case 11:
          Punkte = "9";
          break;
        case 12:
          Punkte = "10";
          break;
        case 13:
          Punkte = "11";
          break;    
        case 14:
          Punkte = "12";
          break;
        case 15:
          Punkte = "0";
          break;
        case 16:
          Punkte = "13";
          break;
        case 17:
          Punkte = "14";
          break; 
        case 18:
          Punkte = "15";
          break;
        case 19:
          Punkte = "16";
          break;
        case 20:
          Punkte = "25";
          break; 
        case 21:
          Punkte = "17";
          break;
        case 22:
          Punkte = "18";
          break;
        case 23:
          Punkte = "19";
          break;    
        case 24:
          Punkte = "20";
          break;
        case 25:
          Punkte = "50";
          break;
    
      }
      if(Seite5PunkteEingabeAktiv==1 && Nummer!=15 && Nummer!=20 && Nummer!=25)
      //Double mit ausnahme der 0 25 und 50
      {
        Punkte = "D"+Punkte;
      }
      if(Seite5PunkteEingabeAktiv==2 && Nummer!=15 && Nummer!=20 && Nummer!=25)
      //Trible mit ausnahme der 0 25 und 50
      {
        Punkte = "T"+Punkte;
      }
      //Speichere Pfeile in Dokument
      boolean voll = false;
      
      if( Seite5Pfeil3AnzeigeAktiv == false &&
          Seite5Pfeil2AnzeigeAktiv == false &&
          Seite5Pfeil1AnzeigeAktiv == false )
      {
        if(Pfeil1=="" && voll==false)
        {
          Pfeil1=Punkte; 
          voll = true;
          println("Eingabe Pfeil1");
        }
        if(Pfeil2=="" && voll==false)
        {
          Pfeil2=Punkte; 
          voll = true;
          println("Eingabe Pfeil2");
        }
        if(Pfeil3=="" && voll==false)
        {
          Pfeil3=Punkte; 
          voll = true;
          println("Eingabe Pfeil3");
        }
      }
      else//Eingabe von Pfeil angeklickt
      {
        if(Seite5Pfeil1AnzeigeAktiv == true)
          Pfeil1=Punkte; 
        if(Seite5Pfeil2AnzeigeAktiv == true)
          Pfeil2=Punkte; 
        if(Seite5Pfeil3AnzeigeAktiv == true)
          Pfeil3=Punkte; 
      }
      String[] text = {Pfeil1,Pfeil2,Pfeil3};
      saveStrings( Pfad_Punkte, text );
      }  
    if(mouseY<800+teilung*5) //Eingabebereich 
    {
      //Double oder Triple nach eingabe wieder ausschalten
      if(Seite5PunkteEingabeAktiv==1 || Seite5PunkteEingabeAktiv==2 )
          Seite5PunkteEingabeAktiv = 0;     
    }
  }
  if ((mouseY <800) && (page5==true)) //Tastaturbereich
  {
    //Sound
  }
  //Seite5.Pfeil1 Feld******************************************************************************
  //rect(80,260,(displayWidth/3)-80, 200);
  if(mouseX > 80 && (mouseX < (80+(displayWidth/3)-80)) && mouseY >260 && mouseY <460  && (page5==true))
  {
    Seite5Pfeil3AnzeigeAktiv = false;
    Seite5Pfeil2AnzeigeAktiv = false;
    Seite5Pfeil1AnzeigeAktiv = true;
  }
  //Seite5.Pfeil2 Feld******************************************************************************
  //rect(340,260,(displayWidth/3)-80, 200);
  if(mouseX > 340 && (mouseX < (340+(displayWidth/3)-80)) && mouseY >260 && mouseY <460  && (page5==true))
  {
    Seite5Pfeil3AnzeigeAktiv = false;
    Seite5Pfeil2AnzeigeAktiv = true;
    Seite5Pfeil1AnzeigeAktiv = false;
  }
  //Seite5.Pfeil3 Feld******************************************************************************
  //rect(600,260,(displayWidth/3)-80, 200);
  if(mouseX > 600 && (mouseX < (600+(displayWidth/3)-80)) && mouseY >260 && mouseY <460  && (page5==true))
  {
    Seite5Pfeil3AnzeigeAktiv = true;
    Seite5Pfeil2AnzeigeAktiv = false;
    Seite5Pfeil1AnzeigeAktiv = false;
  }
  //Seite5. Okay Button*****************************************************************************
  if ((mouseY >550) && (mouseY <750) && (page5==true) && Seite5OkButtonAktiv==true)
  { 
    String[] text = {Pfeil1,Pfeil2,Pfeil3,"Button Okay:","1"};

    saveStrings(  Pfad_Punkte, text );
    Pfeil1 = "";
    Pfeil2 = "";
    Pfeil3 = "";
    Seite5OkButtonAktiv=false;
    Seite5Pfeil3AnzeigeAktiv = false;
    Seite5Pfeil2AnzeigeAktiv = false;
    Seite5Pfeil1AnzeigeAktiv = false;
    Seite5PunkteEingabeAktiv = 0;
    
    Aktualisierung = loadStrings( Pfad_Status );   
    if ( Aktualisierung!= null)
    {
      int numtries = 3;
      while(numtries-- != 0)
         try 
         {
           println("#### Ueberpruefen ob Spiel bendet?! ####");
              if(PApplet.parseInt(Aktualisierung[1])== 1) //Spiel ist beendet
              {
                ChangingPage = 6;      
                String[]clear  = {"","","","","","","",""};
                saveStrings(  Pfad_Status, clear);
                println("#### Spiel beendet --> page wechsel! ####");
              }
              Aktualisieren();
              break;
         } 
         catch(Exception e) 
         {
              delay(100);
              println("#### Abfangen des Fehlers gleichzeitig lesen/schreiben bei Aktualisierung! ####");
              continue;
         }      
    }
  }
}
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§ZURÜCK§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
boolean page6 = false;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Elemente zum Zeichnen                                                                          §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Auswahl Button Neues Spiel Starten++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
boolean Seite6SpielNeustartenAktiv = false; 
public void Seite6SpielNeustarten(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    if (aktiv == true)
    {
      fill(0xff5e7eff);//türkis
    } else
    {
      fill(0xff212d5e);//dunkelblau
    }
    rect(25, 200, displayWidth-50, 400);
    textSize(70);
    textAlign(CENTER);
    fill(230);
    text("WIEDERHOLUNG", displayWidth/2, 420);
  }
}
//Auswahl Button Hauptseite++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
boolean Seite6ZumHauptmenuAktiv = false; 
public void Seite6ZumHauptmenu(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    if (aktiv == true)
    {
      fill(0xff5e7eff);//türkis
    } else
    {
      fill(0xff212d5e);//dunkelblau
    }
    rect(25, 700, displayWidth-50, 400);
    textSize(70);
    textAlign(CENTER);
    fill(230);
    text("ZUR STARTSEITE", displayWidth/2, 920);
  }
}

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Button Events                                                                                  §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

public void Page6ButtonEvent()
{
  //Spiel Neu Starten
  if ((mouseX > 25) && (mouseX<displayWidth-25) && (mouseY >200) && (mouseY<600) && (page6==true))
  {
    //gehe auf Scorer Seite
    ChangingPage = 5;      
  }
  //zum Hauptmenu
  if ((mouseX > 25) && (mouseX<displayWidth-25) && (mouseY >700) && (mouseY<1100) && (page6==true))
  {
    //gehe auf Startseite
    ChangingPage = 1;  
    
      Aktualisierung[6]= "Programm schließen!";
      Aktualisierung[7]= "1";      
      saveStrings( Pfad_Status, Aktualisierung);
  }
}
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§  Spielmodi  §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
// Auswahl für Soccer $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
boolean page7 = false;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Elemente zum Zeichnen                                                                          §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Beschreibung zum Spiel Soccer

int Seite7SpielbeschreibungAktiv = 0;
public void Seite7Spielbeschreibung(boolean sichtbar, int aktiv)
{
  if (sichtbar == true)
  {
    fill(0xff212d4a);
    rect(25, 200, displayWidth-50, 400);
    textSize(60);
    textAlign(CENTER);
    fill(230);
    text("1. Erlange den Ballbesitz über", ((displayWidth)/2), 270);
    text("das Bulls-Eye", ((displayWidth)/2), 330);
    text("2. Sammle Punkte bei Ballbesitz", ((displayWidth)/2), 390);
    text("über den Außenring (Tore)", ((displayWidth)/2), 450);
    text("3. Achte auf die Zeit", ((displayWidth)/2), 530);

    noStroke();
  }
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Auswahl Button Spielzeit
int Seite7SpielzeitAktiv = 5;
public void Seite7Spielzeit(boolean sichtbar, int aktiv)
{
  if (sichtbar == true)
  {
    noStroke();
    fill(0xff212d5e);
    rect(25, 640, displayWidth-50, 200);
    fill(255);
    rect(25, 640, 230, 200);
    rect(645, 640, 230, 200);
    
    textSize(60);
    textAlign(CENTER);
    text("MINUTEN", ((displayWidth)/2), 810);
    textSize(90);
    text(aktiv,((displayWidth)/2), 730);

  PImage img; 
  //tint(0);    
    img = loadImage("Bilder/MinusIcon.png");
    image(img, 70, 660, 150,150 );
    img = loadImage("Bilder/PlusIcon.png");
    image(img, 680, 660, 150,150 );
  }
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Drop Down zur Auswahl der Anzahl der Spieler

int Seite7TeilnehmerAnzahlAktiv = 0;
public void Seite7TeilnehmerAnzahl(boolean sichtbar, int aktiv)
{
  if (sichtbar == true)
  {
    fill(0xff212d5e);
    rect(25, 860, displayWidth-50, 400);
    textSize(80);
    textAlign(CENTER);
    fill(230);
    text("ANZAHL SPIELER", displayWidth/2, 990);
    stroke(220);
    line(25, 1060, displayWidth-25, 1060);
    line((((displayWidth-50)/8)*1)+25, 1060, (((displayWidth-50)/8)*1)+25, 1260);
    line((((displayWidth-50)/8)*2)+25, 1060, (((displayWidth-50)/8)*2)+25, 1260);
    line((((displayWidth-50)/8)*3)+25, 1060, (((displayWidth-50)/8)*3)+25, 1260);
    line((((displayWidth-50)/8)*4)+25, 1060, (((displayWidth-50)/8)*4)+25, 1260);
    line((((displayWidth-50)/8)*5)+25, 1060, (((displayWidth-50)/8)*5)+25, 1260);
    line((((displayWidth-50)/8)*6)+25, 1060, (((displayWidth-50)/8)*6)+25, 1260);
    line((((displayWidth-50)/8)*7)+25, 1060, (((displayWidth-50)/8)*7)+25, 1260);
    noStroke();
    text("1", ((((displayWidth-50)/8)*1)+25)-55, 1180);
    text("2", ((((displayWidth-50)/8)*2)+25)-55, 1180);
    text("3", ((((displayWidth-50)/8)*3)+25)-55, 1180);
    text("4", ((((displayWidth-50)/8)*4)+25)-55, 1180);
    text("5", ((((displayWidth-50)/8)*5)+25)-55, 1180);
    text("6", ((((displayWidth-50)/8)*6)+25)-55, 1180);
    text("7", ((((displayWidth-50)/8)*7)+25)-55, 1180);
    text("8", ((((displayWidth-50)/8)*8)+25)-55, 1180);
    if (aktiv == 1)
    {
      fill(0xff5e7eff);
      rect(25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("1", ((((displayWidth-50)/8)*1)+25)-55, 1180);
      TeilnehmerAnzahl = 1;
    }
    if (aktiv == 2)
    {
      fill(0xff5e7eff);
      rect((((displayWidth-50)/8)*1)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("2", ((((displayWidth-50)/8)*2)+25)-55, 1180);
      TeilnehmerAnzahl = 2;
    }
    if (aktiv == 3)
    {
      fill(0xff5e7eff);
      rect((((displayWidth-50)/8)*2)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("3", ((((displayWidth-50)/8)*3)+25)-55, 1180);
      TeilnehmerAnzahl = 3;
    }
    if (aktiv == 4)
    {
      fill(0xff5e7eff);
      rect((((displayWidth-50)/8)*3)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("4", ((((displayWidth-50)/8)*4)+25)-55, 1180);
      TeilnehmerAnzahl = 4;
    }
    if (aktiv == 5)
    {
      fill(0xff5e7eff);
      rect((((displayWidth-50)/8)*4)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("5", ((((displayWidth-50)/8)*5)+25)-55, 1180);
      TeilnehmerAnzahl = 5;
    }
    if (aktiv == 6)
    {
      fill(0xff5e7eff);
      rect((((displayWidth-50)/8)*5)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("6", ((((displayWidth-50)/8)*6)+25)-55, 1180);
      TeilnehmerAnzahl = 6;
    }
    if (aktiv == 7)
    {
      fill(0xff5e7eff);
      rect((((displayWidth-50)/8)*6)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("7", ((((displayWidth-50)/8)*7)+25)-55, 1180);
      TeilnehmerAnzahl = 7;
    }
    if (aktiv == 8)
    {
      fill(0xff5e7eff);
      rect((((displayWidth-50)/8)*7)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("8", ((((displayWidth-50)/8)*8)+25)-55, 1180);
      TeilnehmerAnzahl = 8;
    }
   noStroke();
  }
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Weiter Button Seite 7
boolean Seite7WeiterButtonAktiv = false; 
boolean Seite7WarAktiv = false;
public void Seite7WeiterButton(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    if (aktiv == true)
    {
      fill(0xff00E323);//grün
    } else
    {
      fill(100);//dunkelblau
    }
    rect(25, 1280, displayWidth-50, 200);
    textSize(70);
    textAlign(CENTER);
    fill(230);
    text("WEITER", displayWidth/2, 1400);
  }
}


//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Button Events                                                                                  §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

public void Page7ButtonEvent()
{

  //Seite7.Spielzeit einstellen*******************************************************************
  if ((mouseY > 640) && (mouseY<840) && (page7==true))
  {
    if ((mouseX > 25) && (mouseX<175))//Teilbutton1
    {
      if(Seite7SpielzeitAktiv>2)
       Seite7SpielzeitAktiv--;
    }
    if ((mouseX > 645) && (mouseX<795))//Teilbutton2
    {
       Seite7SpielzeitAktiv++;
    }
  }
  //Seite7.Anzahl Spieler**************************************************************************
  if ((mouseX > 25) && (mouseX<displayWidth-25) && (mouseY > 1060) && (mouseY<1260) && (page7==true))
  {
    if ((mouseX > 25) && (mouseX<((displayWidth-50)/8)+25))//Teilbutton1
    {
      Seite7TeilnehmerAnzahlAktiv =1;
    }
    if ((mouseX > (((displayWidth-50)/8)+25)) && (mouseX<(((displayWidth-50)/8)*2)+25))//Teilbutton2
    {
      Seite7TeilnehmerAnzahlAktiv =2;
    }
    if ((mouseX > (((displayWidth-50)/8)*2)+25) && (mouseX<(((displayWidth-50)/8)*3)+25))//Teilbutton2
    {
      Seite7TeilnehmerAnzahlAktiv =3;
    }
    if ((mouseX > (((displayWidth-50)/8)*3)+25) && (mouseX<(((displayWidth-50)/8)*4)+25))//Teilbutton2
    {
      Seite7TeilnehmerAnzahlAktiv =4;
    }
    if ((mouseX > (((displayWidth-50)/8)*4)+25) && (mouseX<(((displayWidth-50)/8)*5)+25))//Teilbutton2
    {
      Seite7TeilnehmerAnzahlAktiv =5;
    }
    if ((mouseX > (((displayWidth-50)/8)*5)+25) && (mouseX<(((displayWidth-50)/8)*6)+25))//Teilbutton2
    {
      Seite7TeilnehmerAnzahlAktiv =6;
    }
    if ((mouseX > (((displayWidth-50)/8)*6)+25) && (mouseX<(((displayWidth-50)/8)*7)+25))//Teilbutton2
    {
      Seite7TeilnehmerAnzahlAktiv =7;
    }
    if ((mouseX > (((displayWidth-50)/8)*7)+25) && (mouseX<(((displayWidth-50)/8)*8)+25))//Teilbutton2
    {
      Seite7TeilnehmerAnzahlAktiv =8;
    }
  }
  //Seite7.Weiter*********************************************************************************
  if ((mouseX > 25) && (mouseX<displayWidth-25) && (mouseY>1280) && (page7==true) 
    && (Seite7WeiterButtonAktiv==true))
  {
    ChangingPage = 3;
    Seite7WarAktiv = true;
  }

}
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§  Tastatur Soccer §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

boolean    page8 = false;
int        Seite8AnzTeilnehmer = 0;


//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Elemente zum Zeichnen                                                                          §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


//Auswahl Der Button von Mitspielern+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
int Seite8MitspielerAktiv = 0; 
public void Seite8Mitspieler(boolean sichtbar, int aktiv)
{
  if (sichtbar == true)
  {
    //Nur vorher ausgewählte Mitspieler anzeigen
    String[] TeilnehmerVergleich = loadStrings(Pfad_Teilnehmer);  
    if(TeilnehmerVergleich==null) //Dokument nicht vorhanden
      ;                           //mache nichts!
    else                          //Wenn vorhanden Spieler anlegen
    {
      Seite8AnzTeilnehmer = TeilnehmerVergleich.length;
      int teilung = 800/TeilnehmerVergleich.length;
      for (int i=0; i<=TeilnehmerVergleich.length-1; i++)
      {
        println("Teilnehmer ",aktiv);
        if(i == aktiv-1)
          fill(0xff5e7eff);
        else
          fill(0xff212d5e);
        rect(25, 180+(teilung*(i)), displayWidth-50, teilung);
        fill(220);
        textSize(80);
        textAlign(CENTER);
        text(TeilnehmerVergleich[i], displayWidth/2 ,200+(teilung/2)+(teilung*(i)));
      }
    }    
  }
}
//*************************************************************************************************
//Punkteeingabe
int Seite8PunkteingabeAktiv = 0; 
public void Seite8Punkteingabe(boolean sichtbar, int aktiv)
{
  if (sichtbar == true)
  {
    println("Punkte  ",aktiv);
    fill(0xff212d5e);
    stroke(220);
    rect(25, 1000, displayWidth-50, 200);
    switch(aktiv)
    {
      case 0: break;
      case 1: fill(0xff5e7eff); 
              rect(25, 1000, (displayWidth-50)*0.3333f, 200);
              break;
      case 2: fill(0xff5e7eff); 
              rect(25+(displayWidth-50)*0.3333f, 1000, (displayWidth-50)*0.3333f, 200);
              break;
      case 3: fill(0xff5e7eff); 
              rect(25+(2*(displayWidth-50)*0.3333f), 1000, (displayWidth-50)*0.3333f, 200);
              break;
    }
    textSize(110);
    textAlign(CENTER);
    fill(230);
   
    text("1", displayWidth*0.333f*1-150, 1130);
    text("2", displayWidth*0.333f*2-150, 1130);
    text("3", displayWidth*0.333f*3-150, 1130);
    
    noStroke();

  }
}
//*************************************************************************************************
//Bestaetigung
boolean Seite8BestaetigungAktiv = false; 
public void Seite8Bestaetigung(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    if (aktiv == true)
      fill(0xff00E323);//grün
    else
      fill(100); //grau
    rect(25, 1250, displayWidth-50, 200);
    textSize(80);
    textAlign(CENTER);
    fill(230);
   
    text("OKAY!", displayWidth/2, 1380);
   
  }
}


//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Button Events                                                                                  §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

public void Page8ButtonEvent()
{

  //Seite8.Spielerauswahl**************************************************************************
  if ((mouseY > 180) && (mouseY<1280) && (page8==true) )
  {
    if (AnzahlAllerSpieler > 0)//Fehelr abfangen Division durch null
    {
        println(AnzahlAllerSpieler);
        int teilung = 800/Seite8AnzTeilnehmer;
    
        for ( int i=0; i<=Seite8AnzTeilnehmer; i++)
        {
          if ((mouseY > 180+((i-1)*teilung)) && (mouseY< 180+(i*teilung))) 
          {
            Seite8MitspielerAktiv = i;
          }
        }
     }
  }
  //Seite8.Punkteeingabe**************************************************************************
  if ( (mouseY > 1000) && (mouseY<1200) && (page8==true)  )
  {
    //1
    if ( (mouseX > 0) && (mouseX<displayWidth*0.333f*1) )
      if( Seite8PunkteingabeAktiv == 1 )
        Seite8PunkteingabeAktiv = 0; 
      else
        Seite8PunkteingabeAktiv = 1;
    //2
    if ( (mouseX > displayWidth*0.333f*1) && (mouseX<displayWidth*0.333f*2) )
      if( Seite8PunkteingabeAktiv == 2 )
        Seite8PunkteingabeAktiv = 0; 
      else
        Seite8PunkteingabeAktiv = 2;
    //3
    if ( (mouseX > displayWidth*0.333f*2) && (mouseX<displayWidth*0.333f*3) )
      if( Seite8PunkteingabeAktiv == 3 )
        Seite8PunkteingabeAktiv = 0; 
      else
        Seite8PunkteingabeAktiv = 3;
  }
  //Seite8.Okay Button****************************************************************************
  if ( (mouseY > 1250) && (mouseY<1450) && (page8==true) && (Seite8BestaetigungAktiv==true) )
  {
    Seite8PunkteingabeAktiv =0;
    
    String[] Status = loadStrings(Pfad_Status);
    if(Status!=null)
    {
      if(Status.length > 0)
      {
        //println(int(Status[1]),Status[1],int(Status[1])==1);
        if(PApplet.parseInt(Status[1])==1)
        {
          ChangingPage = 6;      
          String[]clear  = {"","","","","","","",""};
          saveStrings(  Pfad_Status, clear);
        }
      }
    }
  }

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "DartMenu" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
