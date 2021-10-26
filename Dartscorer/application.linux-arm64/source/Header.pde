

void header()
{
  //Zeichnet Header und Hintergrundbild
  textSize(70);
  image(img_header, 0, 0, displayWidth,displayHeight );
  fill(0);
  noStroke();
  rect(0,0,displayWidth,displayHeight*0.1);
  for(int i=0;i<200;i++)
  { 
    fill(255,100-(i*0.5));
    rect(0,(displayHeight*0.1)+i,displayWidth,3);
  }
  fill(255);
  String IN = " ";
  String OUT = " ";
  switch (Spielmodus.IN)
  {
    case 1: IN = "SI";
      break;
    case 2: IN = "DI";
      break;
    case 0: IN = " 0 ";
      break;
  }
  switch (Spielmodus.OUT)
  {
    case 1: OUT = "SO";
      break;
    case 2: OUT = "DO";
      break;
    case 3: OUT = "MO";
      break;
    case 0: OUT = " 0 ";
      break;
  }
  int Startwert = Spielmodus.Startwert;
  if(Startwert<300)
    Startwert = 0;
  textFont(headerFont);
  textAlign(CENTER);
  text("DARTS | "+Spielmodus.Startwert+" | "+IN+" | "+OUT,displayWidth/2,80);
  textAlign(LEFT);
  textFont(pageFont);
}

void GewinnerHintergrund()
{
 
  for(int i = 1; i<=AnzahlTeilnehmer;i++)
  {

    if(Player[i].Gewonnen == true )
    {
          String[]status  = {"Gewonnen:","1","Aktualisierung","1","","","",""};
          saveStrings( Pfad_Status, status);     
          
      println("Gewinner Background");
      
      //Bildschirm schwarz
      fill(0);
      rect(0,0,displayWidth,displayHeight);
      
      //Random versetzt
      textAlign(CENTER);
      textSize(250);
      fill(170);
      text(Player[i].Name +" gewinnt das Spiel!",((displayWidth/2)*random(0,1)),((displayHeight/2))*random(0,1));

      textAlign(CENTER);
      textSize(100);
      fill(255);
      text(Player[i].Name +" gewinnt das Spiel!",displayWidth/2,displayHeight/2);
     
      img_header = img_header1[int(random(0,12))];
    }
  }
}
