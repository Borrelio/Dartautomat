/*
Darstellung der Dartscheibe und Ermittlung der Punktezahl
auf der Dartscheibe.

TODO: 

*/
//###############EINSTELLUNGEN#####################
  //Modellierung der realen Dartscheibe
  //manuelle Anpassungen Erforderlich
  float ProzentAusenring  = 0.08;
  float ProzentInnenring  = 0.42;  
  float ProzentInnenring2 = 0.5;  
  float ProzentBull25     = 0.1;
  float ProzentBull50     = 0.05;
//#################################################

void DartscheibeInit(int MittelpunktX,int MittelpunktY, int Radius)
{  
  noStroke();
  float Teilumfang = 360/20;
  for(int k=0;k<6;k++)
  {
      for(int i=0;i<20;i++)//20
      {     
         if(k==0)//*************************************************************************************************************************************************
         {//Ausenring(Doppel)
           //if(GeradeOderUngerade(i)==true)//rot/grün
           fill(i*10,255,255);
           arc(MittelpunktX, MittelpunktY, Radius, Radius,radians(Teilumfang/2+(i*Teilumfang)),radians(Teilumfang/2+Teilumfang+(i*Teilumfang)));
         }
         if(k==1)//*************************************************************************************************************************************************
         {//innererRing(einfach)
           fill(0,i*10,255);
           arc(MittelpunktX, MittelpunktY, Radius-Radius*ProzentAusenring, Radius-Radius*ProzentAusenring,radians(Teilumfang/2+(i*Teilumfang)),radians(Teilumfang/2+Teilumfang+(i*Teilumfang)));
         }
         if(k==2)//*************************************************************************************************************************************************
         {//innererRing(dripple)
           fill(255,0,i*10);
           arc(MittelpunktX, MittelpunktY, Radius-Radius*ProzentInnenring, Radius-Radius*ProzentInnenring,radians(Teilumfang/2+(i*Teilumfang)),radians(Teilumfang/2+Teilumfang+(i*Teilumfang)));
         }
         if(k==3)//*************************************************************************************************************************************************
         {//innererRing(einfach)
           fill(0,i*10,255);
           arc(MittelpunktX, MittelpunktY, Radius-Radius*ProzentInnenring2, Radius-Radius*ProzentInnenring2,radians(Teilumfang/2+(i*Teilumfang)),radians(Teilumfang/2+Teilumfang+(i*Teilumfang)));
         } 
      }
      if(k==4)//*************************************************************************************************************************************************
      {//Bull 25
        fill(0,140,0);
        //Feld[k*20]= createShape(
        ellipse(MittelpunktX,MittelpunktY,Radius*ProzentBull25,Radius*ProzentBull25);
      }
      if(k==4)//*************************************************************************************************************************************************
      {//Bull 50
        fill(0,240,0);
        //Feld[1+20*k]= createShape
        ellipse(MittelpunktX,MittelpunktY,Radius*ProzentBull50,Radius*ProzentBull50);
      }
  }
  stroke(5);
}


String PunktezahlAusPosition (int PosX, int PosY)
{
  DartscheibeInit(displayWidth/2+400,displayHeight/2+100,radius);
  color x = get( PosX , PosY );
  println(x);
  
   if(-16738561 ==x) 
    return "1";
   if(-16771841  ==x) 
    return "2"; 
   if(-16766721 ==x) 
    return "3";
   if(-16733441  ==x) 
    return "4"; 
   if(-16743681 ==x) 
    return "5";
   if(-16728321  ==x)
    return "6";
   if(-16761601 ==x) 
    return "7";
   if(-16756481  ==x) 
    return "8"; 
   if(-16748801 ==x) 
    return "9";
   if(-16776961 ==x) 
    return "10";
   if(-16753921 ==x) 
    return "11";
   if(-16746241  ==x) 
    return "12"; 
   if(-16730881 ==x) 
    return "13";
   if(-16751361  ==x) 
    return "14"; 
   if(-16774401 ==x) 
    return "15";
   if(-16759041  ==x)
    return "16";
   if(-16769281 ==x) 
    return "17";
   if(-16736001  ==x) 
    return "18"; 
   if(-16764161 ==x) 
    return "19";   
   if(-16741121 ==x) 
    return "20";  
    
   if(-6881281 ==x) 
    return "D1";
   if(-15400961  ==x) 
    return "D2"; 
   if(-14090241 ==x) 
    return "D3";
   if(-5570561  ==x) 
    return "D4"; 
   if(-8192001 ==x) 
    return "D5";
   if(-4259841  ==x)
    return "D6";
   if(-12779521 ==x) 
    return "D7";
   if(-11468801  ==x) 
    return "D8"; 
   if(-9502721 ==x) 
    return "D9";
   if(-16711681 ==x) 
    return "D10";
   if(-10813441 ==x) 
    return "D11";
   if(-8847361  ==x) 
    return "D12"; 
   if(-4915201 ==x) 
    return "D13";
   if(-10158081  ==x) 
    return "D14"; 
   if(-16056321 ==x) 
    return "D15";
   if(-12124161  ==x)
    return "D16";
   if(-14745601 ==x) 
    return "D17";
   if(-6225921  ==x) 
    return "D18"; 
   if(-13434881 ==x) 
    return "D19";   
   if(-7536641 ==x) 
    return "D20";   
    
   if(-65386 ==x) 
    return "T1";
   if(-65516 ==x) 
    return "T2"; 
   if(-65496 ==x) 
    return "T3";
   if(-65366  ==x) 
    return "T4"; 
   if(-65406 ==x) 
    return "T5";
   if(-65346  ==x)
    return "T6";
   if(-65476 ==x) 
    return "T7";
   if(-65456  ==x) 
    return "T8"; 
   if(-65426 ==x) 
    return "T9";
   if(-65536 ==x) 
    return "T10";
   if(-65446 ==x) 
    return "T11";
   if(-65416  ==x) 
    return "T12"; 
   if(-65356 ==x) 
    return "T13";
   if(-65436  ==x) 
    return "T14"; 
   if(-65526 ==x) 
    return "T15";
   if(-65466  ==x)
    return "T16";
   if(-65506 ==x) 
    return "T17";
   if(-65376 ==x) 
    return "T18"; 
   if(-65486 ==x) 
    return "T19";   
   if(-65396 ==x) 
    return "T20";      
    
   if(-16741376  ==x) 
    return "25"; 
   if(-16715776  ==x) 
    return "50"; 
    
    else
    return "";
   
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++HILSFUNKTIONEN+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
boolean GeradeOderUngerade(int Zahl)//gerade --> true
{
  if(Zahl%2 == 0) 
    return true;
  else
    return false;
}
