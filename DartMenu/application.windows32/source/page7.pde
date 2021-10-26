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
void Seite7Spielbeschreibung(boolean sichtbar, int aktiv)
{
  if (sichtbar == true)
  {
    fill(#212d4a);
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
void Seite7Spielzeit(boolean sichtbar, int aktiv)
{
  if (sichtbar == true)
  {
    noStroke();
    fill(#212d5e);
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
void Seite7TeilnehmerAnzahl(boolean sichtbar, int aktiv)
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
   noStroke();
  }
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Weiter Button Seite 7
boolean Seite7WeiterButtonAktiv = false; 
boolean Seite7WarAktiv = false;
void Seite7WeiterButton(boolean sichtbar, boolean aktiv)
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

void Page7ButtonEvent()
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
