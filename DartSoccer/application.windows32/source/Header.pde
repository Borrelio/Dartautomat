

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


  textFont(headerFont);
  textAlign(LEFT);
  text("SOCCER  | "+Spielmodus.Zeit+" MIN ",displayWidth*0.035,80);
  textAlign(LEFT);
  textFont(pageFont);
}

void GewinnerHintergrund()
{
 
  for(int i = 1; i<=AnzahlTeilnehmer;i++)
  {
 
    if(Player[i].Gewonnen == true )
    {
      //println("Gewinner Background");
      fill(0);
      rect(0,0,displayWidth,displayHeight);
      textAlign(CENTER);
      textSize(100);
      fill(255);
      text(Player[i].Name +" gewinnt das Spiel!",displayWidth/2,displayHeight/2);
      img_header = img_header1[int(random(0,12))];
    }

  }
}
