String[] Spielmodi = new String[10];
Modi Spielmodus = new Modi();

public class Modi
{
  int Startwert; //301, 501,...
  int IN;        //1 Single 2 Doppel 
  int OUT;       //1 Single 2 Doppel 3 Master -OUT
  
  //Konstruktor++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Modi()
  {
  }
  Modi(   int startwert,int In,int Out)
  {
    Startwert  = startwert;
    IN   = In;
    OUT  = Out;
  }
  //***********************************************************************
  void Aktualisieren()
  {
    String[] SpielmodiVergleich = new String[8];
    SpielmodiVergleich = loadStrings( Pfad_Spielmodi);
    if(SpielmodiVergleich==null)
      ;
    else
    {
      boolean gleich = VergleichStringArray(Spielmodi,SpielmodiVergleich);
    
      if(gleich==true)
      ;
      else//wird einmal ausgeführt wenn Datei Spielmodi.INOUT verändert wird
      {
        Spielmodi = loadStrings(Pfad_Spielmodi);    
        Spielmodus = new Modi(int(Spielmodi[0]),int(Spielmodi[2]),int(Spielmodi[4]));  
      }
    }
  }
}
