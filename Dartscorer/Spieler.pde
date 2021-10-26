

String[]    Teilnehmer        = new String[9]  ;
String[]    Datenbank_Player  = new String[9]  ;
Spieler[]   Player            = new Spieler[9] ;
int         AnzahlTeilnehmer                   ;
int         AnzahlAllerSpieler                 ;
boolean     PfeileOkay        = false          ;
boolean     GewonnenGlobal    = false          ;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
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
  
  double  AVG       =0.0;
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
  
  color   Farbe = color(255,0,10);
  int     Siege;
  
  boolean EinfachAus;
  
  //Konstruktor+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Spieler(String NameDesSpielers, String FarbeInt, int Rang, int startwert, String EinfachAusString)
  {
    Name = NameDesSpielers;
    Rangfolge = Rang;
    Punktezahl = startwert;
    Uberworfen = false;
    Farbe = int(FarbeInt);
    Siege = 0;
    EinfachAus = boolean(int(EinfachAusString)); 
    
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
  void card()
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
            rect(displayWidth*0.03,displayHeight*0.15,displayWidth*0.5,displayHeight*0.83);
            //transp = 1+transp*4;      //Raspi nicht Leistungsstark --> faden ruckelt
            transp = 250;      
          }
          else
          { 
            AussenLicht(int(red(Farbe)), int(green(Farbe)), int(blue(Farbe)));
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
            rect(displayWidth*0.03,displayHeight*0.15,displayWidth*0.5,displayHeight*0.83,30);

            fill(Farbe,transp);
            rect(displayWidth*0.03,displayHeight*0.15,50,displayHeight*0.83,30,0,0,30);
            fill(250);
            textAlign(LEFT);
            if (Name.length() > 5)
              textSize(100);
            else
              textSize(130);
            if (Name.length() > 8)
              textSize(80);
            text(Name,displayWidth*0.075,displayHeight*0.305);
            fill(0);
            text(Name,displayWidth*0.07,displayHeight*0.3);
            textSize(180);
            textAlign(CENTER);
            
            //stroke(255);
            fill(255,100);
            circle(displayWidth*0.44,displayHeight*0.3,410);
            circle(displayWidth*0.44,displayHeight*0.3,399);
            circle(displayWidth*0.44,displayHeight*0.3,390);
            circle(displayWidth*0.44,displayHeight*0.3,385);
            fill(Farbe);
            noStroke();
            circle(displayWidth*0.44,displayHeight*0.3,380);
            //fill(Farbe,220);
            //circle(displayWidth*0.34,displayHeight*0.45,180);
            noStroke();
            if( AVG > 0.0 )
            {
              //stroke(255);
              fill(255,100);
              circle(displayWidth*0.37,displayHeight*0.48,215);
              circle(displayWidth*0.37,displayHeight*0.48,208);
              circle(displayWidth*0.37,displayHeight*0.48,203);
              textSize(70);
              fill(Farbe);
              circle(displayWidth*0.37,displayHeight*0.48,200);
              fill(255);
              text(String.format("%.1f", AVG) ,displayWidth*0.37,displayHeight*0.495);
            }
            textSize(180);
            fill(240);
            text(Punktezahl,displayWidth*0.438,displayHeight*0.37);
            fill(20);
            text(Punktezahl,displayWidth*0.435,displayHeight*0.36);
            textSize(80);
            
            noStroke();
            
            if(Pfeil1==-1)//noch keine Eingabe Pfeil 1
            {
              fill(240);
              rect(displayWidth*0.07,displayHeight*0.38,400,100,30);  
              image(img_pfeil, displayWidth*0.1,displayHeight*0.32, 250,200);
            }
            else
            {
              stroke(Farbe);
              fill(255);
              rect(displayWidth*0.07,displayHeight*0.38,400,100,30);  
              textAlign(CENTER);
              fill(40);
              text(Pfeil1,displayWidth*0.17,displayHeight*0.46);
              noStroke();
            }
            if(Pfeil2==-1)//noch keine Eingabe Pfeil 2
            {
              fill(240);
              rect(displayWidth*0.07,displayHeight*0.525,400,100,30);   
              image(img_pfeil, displayWidth*0.1,displayHeight*0.47, 250,200);
            }
            else
            {
              stroke(Farbe);
              fill(255);
              rect(displayWidth*0.07,displayHeight*0.525,400,100,30); 
              fill(40);
              text(Pfeil2,displayWidth*0.17,displayHeight*0.605);
              noStroke();
            }
            if(Pfeil3==-1)//noch keine Eingabe Pfeil 3
            {
              fill(240);
              rect(displayWidth*0.07,displayHeight*0.67,400,100,30);   
              image(img_pfeil, displayWidth*0.1,displayHeight*0.61, 250,200);
            }
            else
            {
              stroke(Farbe);
              fill(255);
              rect(displayWidth*0.07,displayHeight*0.67,400,100,30);
              fill(40);
              text(Pfeil3,displayWidth*0.17,displayHeight*0.75);
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
                text(ZwischenSumme,displayWidth*0.17,displayHeight*0.9);
            }
            else
            {
              textSize(70);
              text("ZU VIEL!",displayWidth*0.17,displayHeight*0.9);   
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
              int Teilung = int((displayHeight*0.78)/(AnzahlTeilnehmer-1));
              int Verteilung = Rangfolge - 2;
              
              textAlign(LEFT);
              textSize(90);
          
              fill(100,210);
              stroke(250,50);
              strokeWeight(4);
              rect(displayWidth*0.55,displayHeight*0.16+Verteilung*Teilung,displayWidth*0.43,Teilung,30);
              noStroke();
              fill(Farbe,170);
              rect(displayWidth*0.55,displayHeight*0.16+Verteilung*Teilung,40,Teilung,30,0,0,30);
              fill(255);
              text(Name,displayWidth*0.58,displayHeight*0.265+Verteilung*Teilung);
              textAlign(RIGHT);
              text(Punktezahl,displayWidth*0.97,displayHeight*0.265+Verteilung*Teilung);
              
              textSize(70);
              fill(190);
              if(AnzahlTeilnehmer < 5 && AVG > 0.0 )
                text("AVG: "+String.format("%.1f", AVG) ,displayWidth*0.97,displayHeight*0.4+Verteilung*Teilung);
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
           int Teilung = int((displayHeight*0.78)/(AnzahlTeilnehmer+1));
           int Verteilung = i;
           if(AnzahlTeilnehmer>4)
           {
              textAlign(CENTER);
              textSize(80);         
              fill(20,30);
              stroke(250,50);
              strokeWeight(4);
              rect(displayWidth*0.28,displayHeight*0.16,displayWidth*0.43,Teilung,20);
              fill(230);
              text("SIEGE",displayWidth*0.49,displayHeight*0.23-((AnzahlTeilnehmer-8)*10));
              textAlign(LEFT);
              fill(100,110);
              rect(displayWidth*0.28,displayHeight*0.16+Verteilung*Teilung,displayWidth*0.43,Teilung,20);
              noStroke();
              fill(Player[i].Farbe,170);
              rect(displayWidth*0.28,displayHeight*0.16+Verteilung*Teilung,40,Teilung,20,0,0,20);
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
              stroke(250,50);
              strokeWeight(4);
              rect(displayWidth*0.28,displayHeight*0.16,displayWidth*0.43,Teilung,20);              
              fill(230);
              text("SIEGE",displayWidth*0.49,displayHeight*0.23-((AnzahlTeilnehmer-8)*10));
              textAlign(LEFT);
              fill(100,110);
              rect(displayWidth*0.28,displayHeight*0.16+Verteilung*Teilung,displayWidth*0.43,Teilung,20);            
              noStroke();            
              fill(Player[i].Farbe,170);
              rect(displayWidth*0.28,displayHeight*0.16+Verteilung*Teilung,40,Teilung,20,0,0,20);
              fill(255);
              text(Player[i].Name,displayWidth*0.31,displayHeight*0.27+Verteilung*Teilung);
              textAlign(RIGHT);
              text(Player[i].Siege,displayWidth*0.68,displayHeight*0.27+Verteilung*Teilung);             
           }
         }
       }
     }
  }
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  void PfeileAktualisieren()
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
  void PfeileOkay()
  {
    Pfeile = loadStrings( Pfad_Punkte);
    if(Pfeile.length > 3)
    {
      println("punkte ok",Pfeile[4],Pfeile[4]=="1");
      if(int(Pfeile[4])==1) //Pfeile sind korrekt eingegeben
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

void RotiereCards()
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

void ResetPunkte()
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
void CheckOut( int Endwert)
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
