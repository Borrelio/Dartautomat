boolean Sidebar = false;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Elemente zum Zeichnen                                                                          §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

void header()
{
  //Zeichnet Header und Hintergrundbild
  image(Hintergrund, 0, 0, displayWidth,displayHeight );
  fill(0);
  noStroke();
  rect(0,0,displayWidth,displayHeight*0.08);
  for(int i=0;i<20;i++)
  { 
    fill(255,100-(i*0.5));
    rect(0,(displayHeight*0.08)+i,displayWidth,2);
  }
  
  image(icon_Menu, 25, 10, 100, 100 );
  if(page1==true)
  {
    textAlign(RIGHT);
    textSize(50);
    text("START MENÜ",displayWidth-25,100);
  }
  if(page2==true || page7==true)
  {
    textAlign(RIGHT);
    textSize(50);
    text("NEUES SPIEL STARTEN",displayWidth-25,100);
  }
  if(page3==true)
  {
    textAlign(RIGHT);
    textSize(50);
    text("SPIELER AUSWÄHLEN",displayWidth-25,100);   
  }
  if(page4==true)
  {
    textAlign(RIGHT);
    textSize(50);
    text("SPIELER HINZUFÜGEN",displayWidth-25,100);
  }
  if(page5==true || page8==true)
  {
    textAlign(RIGHT);
    textSize(50);
    text("PUNKTEEINGABE",displayWidth-25,100);
  }

  
}

boolean OutputStream = false;

void Sidebar()
{
  //Zeichnet Sidebar Menü
  if(Sidebar == true)
  {
    fill(255);
    rect(0,0,displayWidth*0.75,displayHeight);
    fill(0);
    textAlign(LEFT);
    textSize(70);
    text("Zur Startseite",40,120);
    stroke(150);
    line(0,200,displayWidth*0.75,200);
    text("Spieler hinzufügen",40,320);
    line(0,400,displayWidth*0.75,400);
    text("Spieler entfernen",40,520);
    line(0,600,displayWidth*0.75,600);
    text("Debug OutputStream",40,720);
    line(0,800,displayWidth*0.75,800);
    
    
    
    noStroke();
  }
}

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//Button Events                                                                                  §
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
void HeaderButtonEvent()
{
  //Menu Icon*************************************************************************************
  if ((mouseX > 10) && (mouseX<110) && (mouseY > 10) && (mouseY<110))
  {
    ChangingSidebar = true;
  }
  //Menu Sidebar**********************************************************************************
  if ((mouseX < displayWidth*0.75) && (Sidebar == true))
  {
    if((mouseY > 0) && (mouseY<200))//Zur Startseite
    {
      ChangingSidebar = false;
      ChangingPage = 1;
      Aktualisierung[6]= "Programm schließen!";
      Aktualisierung[7]= "1";      
      saveStrings( Pfad_Status, Aktualisierung);
    }
    if((mouseY > 200) && (mouseY<400))//Spieler hinzufügen
    {
      ChangingSidebar = false;
      ChangingPage = 4;    
      Aktualisierung[6]= "Programm schließen!";
      Aktualisierung[7]= "1";      
      saveStrings( Pfad_Status, Aktualisierung);
    }
    if((mouseY > 400) && (mouseY<600))//Spieler entfernen
    {
      ChangingSidebar = false;
      ChangingPage = 3; 
      SpielerEntfernen = true;
      Aktualisierung[6]= "Programm schließen!";
      Aktualisierung[7]= "1";      
      saveStrings( Pfad_Status, Aktualisierung);
    }
    if((mouseY > 600) && (mouseY<800))//Debug Outputstream
    {
      ChangingSidebar = false;
      OutputStream = true;

    }
  }
  //Sidebar zurück********************************************************************************
  if ((mouseX > displayWidth*0.75) && (Sidebar == true))
  {
    ChangingSidebar = false;
  }
}
