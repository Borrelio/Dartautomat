
void Aktualisieren()
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
void PageChange(int page, boolean Sidebar_F)
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
