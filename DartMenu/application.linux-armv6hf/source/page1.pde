//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§  Startseite  §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
boolean page1 = false;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Elemente zum Zeichnen                                                                          §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

//Auswahl Button Neus Spiel Starten+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
boolean Seite1SpielstartAktiv = false; //Auswahl 3Button
void Seite1Spielstart(boolean sichtbar, boolean aktiv)
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
    rect(25, 200, displayWidth-50, 200);
    textSize(80);
    textAlign(CENTER);
    fill(230);
    text("KLASSICHES DART", displayWidth/2, 320);
  }
}
//Auswahl Button Neus Spiel Starten2+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
boolean Seite1Spielstart2Aktiv = false; //Auswahl 3Button
void Seite1Spielstart2(boolean sichtbar, boolean aktiv)
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
  //Out of Service 
  fill(#8E8E8E); //Grau 
    rect(25, 430, displayWidth-50, 200);
    textSize(80);
    textAlign(CENTER);
    fill(230);
    text("SOCCER", displayWidth/2, 550);

  //image(img_beta, 10, 420, 300,200 );
    image(img_ComingSoon, displayWidth*0.67, 440, 300,200 );
  }
}
//Auswahl Button Neus Spiel Starten3+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
boolean Seite1Spielstart3Aktiv = false; //Auswahl 3Button
void Seite1Spielstart3(boolean sichtbar, boolean aktiv)
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
    
  //Out of Service 
  fill(#8E8E8E); //Grau 
    rect(25, 660, displayWidth-50, 200);
    textSize(80);
    textAlign(CENTER);
    fill(230);
    text("CRICKET", displayWidth/2, 790);

  image(img_ComingSoon, displayWidth*0.67, 670, 300,200 );
  }
}
//Auswahl Button Neus Spiel Starten4+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
boolean Seite1Spielstart4Aktiv = false; //Auswahl 4Button
void Seite1Spielstart4(boolean sichtbar, boolean aktiv)
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
  //Out of Service 
  fill(#8E8E8E); //Grau 
    rect(25, 890, displayWidth-50, 200);
    textSize(80);
    textAlign(CENTER);
    fill(230);
    text("AROUND THE CLOCK", displayWidth/2, 1010);
    
  image(img_ComingSoon, displayWidth*0.67, 900, 300,200 );
  }
}


//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Button Events                                                                                  §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

void Page1ButtonEvent()
{
  //Seite1.Neues spiel starten********************************************************************
  //Klassisches Dart starten
  if ((mouseX > 25) && (mouseX<displayWidth-25) && (mouseY >200) && (mouseY<400) && (page1==true))
  {
        PrintWriter output=null;
        Aktualisierung[6]= "Programm schließen!";
        Aktualisierung[7]= "0";      //Programm soll sich nicht schließen 
        saveStrings( Pfad_Status, Aktualisierung);

        output = createWriter("DartscorerAusfuehren.bat");
        output.println("cd "+sketchPath());
        output.println("cd ..");
        if(EXE == true) //kompiliertes Programm
          output.println("cd ..");            
        switch(Betriebssystem)
        {
          case 1: output.println("cd Dartscorer"+File.separator+"application.linux32"); break;
          case 2: output.println("cd Dartscorer"+File.separator+"application.linux64"); break; 
          case 3: output.println("cd Dartscorer"+File.separator+"application.linux-armv6hf"); break;
          case 4: output.println("cd Dartscorer"+File.separator+"application.windows32"); break;
          case 5: output.println("cd Dartscorer"+File.separator+"application.windows64"); break;
        }          
        if(Linux == true)
          output.println("sudo bash Dartscorer"); 
        else
          output.println("start Dartscorer.exe");  
        output.flush();
        output.close();  
        output=null; 
        if(Linux == true)
          exec("bash",sketchPath()+"/DartscorerAusfuehren.bat");
        else
          launch(sketchPath()+"\\DartscorerAusfuehren.bat");
    
        println("externes Programm ausführen: DartscorerAusfuehren.bat");
        ChangingPage = 2;
    
          String[]clear  = {"","","","","","","",""};
          saveStrings(Pfad_Status, clear);
          
          
          Seite2SpielmodiStartwertAktiv=0;
          Seite2SpielmodiInAktiv=0;
          Seite2SpielmodiOutAktiv=0;
          Seite2TeilnehmerAnzahlAktiv=0;
          Seite2WeiterButtonAktiv=false;
          Seite3MitspielerAktiv=0;
          Seite3LosButtonAktiv=false;
          Seite4TexteingabeNameAktiv=false;
          Seite4HinzuButtonAktiv=false;
          Seite6SpielNeustartenAktiv=false;
          Seite6ZumHauptmenuAktiv=false;
          
          Startwert    = " " ;
          SpielmodiIn  = " " ;
          SpielmodiOut = " " ;
          TeilnehmerAnzahl =0;
          
  }
  //Seite1.Neues spiel starten********************************************************************
  //Soccer starten
  if ((mouseX > 25) && (mouseX<displayWidth-25) && (mouseY >430) && (mouseY<630) && (page1==true))
  {
        //PrintWriter output=null;
        //Aktualisierung[6]= "Programm schließen!";
        //Aktualisierung[7]= "0";      //Programm soll sich nicht schließen 
        //saveStrings( Pfad_Status, Aktualisierung);

        //output = createWriter("DartSoccerAusfuehren.bat");
        //output.println("cd "+sketchPath());
        //output.println("cd ..");
        //if(EXE == true) //kompiliertes Programm
        //  output.println("cd ..");            
        //switch(Betriebssystem)
        //{
        //  case 1: output.println("cd DartSoccer"+File.separator+"application.linux32"); break;
        //  case 2: output.println("cd DartSoccer"+File.separator+"application.linux64"); break; 
        //  case 3: output.println("cd DartSoccer"+File.separator+"application.linux-armv6hf"); break;
        //  case 4: output.println("cd DartSoccer"+File.separator+"application.windows32"); break;
        //  case 5: output.println("cd DartSoccer"+File.separator+"application.windows64"); break;
        //}          
        //if(Linux == true)
        //  output.println("sudo bash DartSoccer"); 
        //else
        //  output.println("start DartSoccer.exe");  
        //output.flush();
        //output.close();  
        //output=null; 
        //if(Linux == true)
        //  exec("bash",sketchPath()+"/DartSoccerAusfuehren.bat");
        //else
        //  launch(sketchPath()+"\\DartSoccerAusfuehren.bat");
    
        //ChangingPage = 7;
    
        //  String[]clear  = {"","","","","","","",""};
        //  saveStrings(Pfad_Status, clear);
          
          
        //  Seite2SpielmodiStartwertAktiv=0;
        //  Seite2SpielmodiInAktiv=0;
        //  Seite2SpielmodiOutAktiv=0;
        //  Seite2TeilnehmerAnzahlAktiv=0;
        //  Seite2WeiterButtonAktiv=false;
        //  Seite3MitspielerAktiv=0;
        //  Seite3LosButtonAktiv=false;
        //  Seite4TexteingabeNameAktiv=false;
        //  Seite4HinzuButtonAktiv=false;
        //  Seite6SpielNeustartenAktiv=false;
        //  Seite6ZumHauptmenuAktiv=false;
          
        //  Startwert    = " " ;
        //  SpielmodiIn  = " " ;
        //  SpielmodiOut = " " ;
        //  TeilnehmerAnzahl =0;
          
  }
}
