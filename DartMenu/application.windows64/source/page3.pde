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
  color   SpielerFarbe;

  //Konstruktoren+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Spieler(String NameDesSpielers, String NameDesLieds, color FarbeDesSpielers)
  {
    Name = NameDesSpielers;
    LiedName = NameDesLieds;
    SpielerFarbe = FarbeDesSpielers;
  }
  //Methoden++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  void card()
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
int Seite3PruefeMitspieler()
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
void Seite3SpielerAnlegen(boolean Aktiv)
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
        Player[i] = new Spieler(TextDokument[1], TextDokument[5], color(int(TextDokument[3])));
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
void Seite3Mitspieler(boolean sichtbar, int aktiv)
{
  if (sichtbar == true)
  {
    textSize(80);
    textAlign(CENTER);
    fill(#212d5e);
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
          fill(#5e7eff);//türkis
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
void Seite3LosButton(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    if (aktiv == true)
    {
      if(SpielerEntfernen == false)
        fill(#00E323);//grün
      else
        fill(#FF5252);
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

void Page3ButtonEvent()
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
