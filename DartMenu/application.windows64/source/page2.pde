//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§  Spielmodi  §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
boolean page2 = false;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Elemente zum Zeichnen                                                                          §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

//Auswahl Button zum Auswählen des Spielmodis 301,501,...+++++++++++++++++++++++++++++++++++++++++
int Seite2SpielmodiStartwertAktiv = 0;
void Seite2SpielmodiStartwert(boolean sichtbar, int aktiv)
{
  if (sichtbar == true)
  {
    fill(#212d5e);
    rect(25, 200, displayWidth-50, 200);
    textSize(80);
    textAlign(RIGHT);
    fill(230);
    text("301", ((25+((displayWidth-50)/3))-80), 320);
    text("501", ((25+((displayWidth-50)/3)*2)-80), 320);
    text("901", ((25+((displayWidth-50)/3)*3)-80), 320);
    if (aktiv == 1)
    {
      fill(#5e7eff);
      rect(25, 200, (displayWidth-50)/3, 200);
      fill(230);
      text("301", ((25+((displayWidth-50)/3))-80), 320);
      Startwert = "301";
    }
    if (aktiv == 2)
    {
      fill(#5e7eff);
      rect(25+((displayWidth-50)/3), 200, (displayWidth-50)/3, 200);
      fill(230);
      text("501", ((25+((displayWidth-50)/3)*2)-80), 320);
      Startwert = "501";
    }
    if (aktiv == 3)
    {
      fill(#5e7eff);
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
void Seite2SpielmodiIn(boolean sichtbar, int aktiv)
{
  if (sichtbar == true)
  {
    fill(#212d5e);
    rect(25, 420, displayWidth-50, 200);
    textSize(80);
    textAlign(CENTER);
    fill(230);
    text("SI", ((displayWidth/2)/2), 540);
    text("DI", ((displayWidth/2)/2)*3, 540);
    if (aktiv == 1)
    {
      fill(#5e7eff);
      rect(25, 420, (displayWidth-50)/2, 200);
      fill(230);
      text("SI", ((displayWidth/2)/2), 540);
      SpielmodiIn = "SI";
    }
    if (aktiv == 2)
    {
      fill(#5e7eff);
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
void Seite2SpielmodiOut(boolean sichtbar, int aktiv)
{
  if (sichtbar == true)
  {
    fill(#212d5e);
    rect(25, 640, displayWidth-50, 200);
    textSize(80);
    textAlign(RIGHT);
    fill(230);
    text("SO", (25+(((displayWidth-50)/3))  -75), 760);
    text("DO", (25+(((displayWidth-50)/3)*2)-85), 760);
    text("MO", (25+(((displayWidth-50)/3)*3)-75), 760);
    if (aktiv == 1)
    {
      fill(#5e7eff);
      rect(25, 640, (displayWidth-50)/3, 200);
      fill(230);
      text("SO", (25+(((displayWidth-50)/3))  -75), 760);
      SpielmodiOut = "SO";
    }
    if (aktiv == 2)
    {
      fill(#5e7eff);
      rect(25+((displayWidth-50)/3), 640, (displayWidth-50)/3, 200);
      fill(230);
      text("DO", (25+(((displayWidth-50)/3)*2)-85), 760);
      SpielmodiOut = "DO";
    }
    if (aktiv == 3)
    {
      fill(#5e7eff);
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
void Seite2TeilnehmerAnzahl(boolean sichtbar, int aktiv)
{
  if (sichtbar == true)
  {
    fill(#212d5e);
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
      fill(#5e7eff);
      rect(25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("1", ((((displayWidth-50)/8)*1)+25)-55, 1180);
      TeilnehmerAnzahl = 1;
    }
    if (aktiv == 2)
    {
      fill(#5e7eff);
      rect((((displayWidth-50)/8)*1)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("2", ((((displayWidth-50)/8)*2)+25)-55, 1180);
      TeilnehmerAnzahl = 2;
    }
    if (aktiv == 3)
    {
      fill(#5e7eff);
      rect((((displayWidth-50)/8)*2)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("3", ((((displayWidth-50)/8)*3)+25)-55, 1180);
      TeilnehmerAnzahl = 3;
    }
    if (aktiv == 4)
    {
      fill(#5e7eff);
      rect((((displayWidth-50)/8)*3)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("4", ((((displayWidth-50)/8)*4)+25)-55, 1180);
      TeilnehmerAnzahl = 4;
    }
    if (aktiv == 5)
    {
      fill(#5e7eff);
      rect((((displayWidth-50)/8)*4)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("5", ((((displayWidth-50)/8)*5)+25)-55, 1180);
      TeilnehmerAnzahl = 5;
    }
    if (aktiv == 6)
    {
      fill(#5e7eff);
      rect((((displayWidth-50)/8)*5)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("6", ((((displayWidth-50)/8)*6)+25)-55, 1180);
      TeilnehmerAnzahl = 6;
    }
    if (aktiv == 7)
    {
      fill(#5e7eff);
      rect((((displayWidth-50)/8)*6)+25, 1060, ((displayWidth-50)/8), 200);
      fill(230);
      text("7", ((((displayWidth-50)/8)*7)+25)-55, 1180);
      TeilnehmerAnzahl = 7;
    }
    if (aktiv == 8)
    {
      fill(#5e7eff);
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
void Seite2WeiterButton(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    if (aktiv == true)
    {
      fill(#00E323);//grün
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

void Page2ButtonEvent()
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
