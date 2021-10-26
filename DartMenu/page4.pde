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

void Seite4Tastatureingabe(boolean sichtbar)
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
void Seite4TexteingabeName(boolean sichtbar, boolean aktiv)
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
      stroke(#5e7eff);
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

color Spielerfarbe = 0;

void Seite4Collerpicker(boolean sichtbar)
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
void Seite4EinfachAus(boolean sichtbar, boolean aktiv)
{
  if (sichtbar == true)
  {
    if (aktiv == true)
    {
      fill(#5e7eff);//türkis
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

void Seite4HinzuButton(boolean sichtbar, boolean aktiv)
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
void Page4ButtonEvent()
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
