//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§ZURÜCK§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
boolean page6 = false;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Elemente zum Zeichnen                                                                          §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Auswahl Button Neues Spiel Starten++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
boolean Seite6SpielNeustartenAktiv = false; 
void Seite6SpielNeustarten(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    if (aktiv == true)
    {
      fill(#5e7eff);//türkis
    } else
    {
      fill(#212d5e);//dunkelblau
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
void Seite6ZumHauptmenu(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    if (aktiv == true)
    {
      fill(#5e7eff);//türkis
    } else
    {
      fill(#212d5e);//dunkelblau
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

void Page6ButtonEvent()
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
