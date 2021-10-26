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
void Seite8Mitspieler(boolean sichtbar, int aktiv)
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
          fill(#5e7eff);
        else
          fill(#212d5e);
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
void Seite8Punkteingabe(boolean sichtbar, int aktiv)
{
  if (sichtbar == true)
  {
    println("Punkte  ",aktiv);
    fill(#212d5e);
    stroke(220);
    rect(25, 1000, displayWidth-50, 200);
    switch(aktiv)
    {
      case 0: break;
      case 1: fill(#5e7eff); 
              rect(25, 1000, (displayWidth-50)*0.3333, 200);
              break;
      case 2: fill(#5e7eff); 
              rect(25+(displayWidth-50)*0.3333, 1000, (displayWidth-50)*0.3333, 200);
              break;
      case 3: fill(#5e7eff); 
              rect(25+(2*(displayWidth-50)*0.3333), 1000, (displayWidth-50)*0.3333, 200);
              break;
    }
    textSize(110);
    textAlign(CENTER);
    fill(230);
   
    text("1", displayWidth*0.333*1-150, 1130);
    text("2", displayWidth*0.333*2-150, 1130);
    text("3", displayWidth*0.333*3-150, 1130);
    
    noStroke();

  }
}
//*************************************************************************************************
//Bestaetigung
boolean Seite8BestaetigungAktiv = false; 
void Seite8Bestaetigung(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    if (aktiv == true)
      fill(#00E323);//grün
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

void Page8ButtonEvent()
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
    if ( (mouseX > 0) && (mouseX<displayWidth*0.333*1) )
      if( Seite8PunkteingabeAktiv == 1 )
        Seite8PunkteingabeAktiv = 0; 
      else
        Seite8PunkteingabeAktiv = 1;
    //2
    if ( (mouseX > displayWidth*0.333*1) && (mouseX<displayWidth*0.333*2) )
      if( Seite8PunkteingabeAktiv == 2 )
        Seite8PunkteingabeAktiv = 0; 
      else
        Seite8PunkteingabeAktiv = 2;
    //3
    if ( (mouseX > displayWidth*0.333*2) && (mouseX<displayWidth*0.333*3) )
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
        if(int(Status[1])==1)
        {
          ChangingPage = 6;      
          String[]clear  = {"","","","","","","",""};
          saveStrings(  Pfad_Status, clear);
        }
      }
    }
  }

}
