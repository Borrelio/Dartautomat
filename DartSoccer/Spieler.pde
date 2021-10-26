

String[]    Teilnehmer        = new String[9]  ;
String[]    Datenbank_Player  = new String[9]  ;
Spieler[]   Player            = new Spieler[9] ;
int         AnzahlTeilnehmer                   ;
int         AnzahlAllerSpieler                 ;


void SpielerNeuAnlegen()
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
  
  color   Farbe = color(255,0,10);
  int     Siege;
  int     transp = 0;
  
  
  //Konstruktor++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Spieler(String NameDesSpielers, String FarbeInt, int Rang)
  {
    Name = NameDesSpielers;
    Rangfolge = Rang;
    Farbe = int(FarbeInt);
    Siege = 0;
 
        Gewonnen   = false;
      
  }
  //Methoden+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  void card()
  { 
     if(Pfeileingabe == true )
     {
       fill(255,200);
       rect(displayWidth*0.035,(displayHeight*0.2*(Rangfolge*0.5))+displayHeight*0.03,displayWidth*0.75,displayHeight*0.08);
       fill(Farbe);
       rect(displayWidth*0.035,(displayHeight*0.2*(Rangfolge*0.5))+displayHeight*0.03,displayWidth*0.155,displayHeight*0.08);
       fill(0);
       textSize(70);
       text(Name, displayWidth*0.2,(displayHeight*0.2*(Rangfolge*0.5))+displayHeight*0.1);
       
       textSize(90);
       text(Tore, displayWidth*0.52,(displayHeight*0.2*(Rangfolge*0.5))+displayHeight*0.1);
       fill(130);
       textSize(60);
       text(Quote, displayWidth*0.62,(displayHeight*0.2*(Rangfolge*0.5))+displayHeight*0.1);
       
       //Beschriftung
       fill(240);
       textSize(60);
       text("TORE", displayWidth*0.49,(displayHeight*0.2*(AnzahlTeilnehmer*0.5))+displayHeight*0.17);
       text("QUOTE", displayWidth*0.62,(displayHeight*0.2*(AnzahlTeilnehmer*0.5))+displayHeight*0.17);
       text("ZEIT", displayWidth*0.84,(displayHeight*0.52));
       
       if(Ballbesitz == true)
       {
         stroke(10);
         strokeWeight(4);
         fill(0);
         noFill();
         rect(displayWidth*0.035,(displayHeight*0.2*(Rangfolge*0.5))+displayHeight*0.03,displayWidth*0.75,displayHeight*0.08);
         noStroke();
         PImage img; 
         img = loadImage("Bilder/Ball.png");    
         image(img, 40, (displayHeight*0.2*(Rangfolge*0.5))-displayHeight*0.025, 200,200 );
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
           int Teilung = int((displayHeight*0.78)/(AnzahlTeilnehmer+1));
           int Verteilung = i;
           if(AnzahlTeilnehmer>4)
           {
              textAlign(CENTER);
              textSize(80);         
              fill(20,30);
              rect(displayWidth*0.28,displayHeight*0.16,displayWidth*0.43,Teilung);
              fill(230);
              text("SIEGE",displayWidth*0.49,displayHeight*0.23-((AnzahlTeilnehmer-8)*10));
              textAlign(LEFT);
              fill(100,110);
              rect(displayWidth*0.28,displayHeight*0.16+Verteilung*Teilung,displayWidth*0.43,Teilung);
              fill(Player[i].Farbe,170);
              rect(displayWidth*0.28,displayHeight*0.16+Verteilung*Teilung,40,Teilung);
              fill(255);
              text(Player[i].Name,displayWidth*0.31,displayHeight*0.23+Verteilung*Teilung);
              textAlign(RIGHT);
              text(Player[i].Siege,displayWidth*0.68,displayHeight*0.235+Verteilung*Teilung);
           }
           else
           {
              textAlign(CENTER);
              textSize(80);         
              fill(20,30);
              rect(displayWidth*0.28,displayHeight*0.16,displayWidth*0.43,Teilung);
              fill(230);
              text("SIEGE",displayWidth*0.49,displayHeight*0.23-((AnzahlTeilnehmer-8)*10));
              textAlign(LEFT);
              fill(100,110);
              rect(displayWidth*0.28,displayHeight*0.16+Verteilung*Teilung,displayWidth*0.43,Teilung);
              fill(Player[i].Farbe,170);
              rect(displayWidth*0.28,displayHeight*0.16+Verteilung*Teilung,40,Teilung);
              fill(255);
              text(Player[i].Name,displayWidth*0.31,displayHeight*0.27+Verteilung*Teilung);
              textAlign(RIGHT);
              text(Player[i].Siege,displayWidth*0.68,displayHeight*0.27+Verteilung*Teilung);             
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

void ResetPunkte()
{
  for(int i=1;i<=AnzahlTeilnehmer;i++)
  {

        Player[i].Gewonnen   = false;
  }
}
