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

void Seite5PunkteEingabe(boolean sichtbar, int aktiv )
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
      fill(#5e7eff);
    else
      fill(230);
    rect(0,800+(teilung*5),displayWidth/2,1000);
       
    if(aktiv==2)
      fill(#5e7eff);
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
void Seite5Pfeil1Anzeige(boolean sichtbar, boolean aktiv)
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
      stroke(#5e7eff);
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
void Seite5Pfeil2Anzeige(boolean sichtbar, boolean aktiv)
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
      stroke(#5e7eff);
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
void Seite5Pfeil3Anzeige(boolean sichtbar, boolean aktiv)
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
      stroke(#5e7eff);
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
void Seite5OkButton(boolean sichtbar, boolean aktiv)
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


void Page5ButtonEvent()
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
              if(int(Aktualisierung[1])== 1) //Spiel ist beendet
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
