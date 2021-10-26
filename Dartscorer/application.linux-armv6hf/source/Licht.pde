import processing.io.*;


  SPI spi;
  int value ;
  int value_left;
  int value_right;
  int config ;
  byte[] DAC_OUT = {0,0} ;
  
  boolean FehlerLicht = false;
  
  //PINOUT
  int RGB1R = 2;
  int RGB1G = 3;
  int RGB1B = 4;
  int RGB2R = 17;
  int RGB2G = 27;
  int RGB2B = 22;
  int RGB3R = 18;
  int RGB3G = 23;
  int RGB3B = 24;
  
//**********************************************************  
void LichtKonfiguration()
{
  if (null == (spi = new SPI(SPI.list()[1])) || Windows == true || Lichtansteuerung == 0)
    FehlerLicht = true;
  if (FehlerLicht == false)
  {
    spi.settings(500000, SPI.MSBFIRST, SPI.MODE0);
    //für CS SPI Pin
    GPIO.pinMode(5, GPIO.OUTPUT);
    GPIO.pinMode(6, GPIO.OUTPUT);
    //für einfache Ansteurung des Mosfet
    GPIO.pinMode(RGB2R, GPIO.OUTPUT);
    GPIO.pinMode(RGB2G, GPIO.OUTPUT);
    GPIO.pinMode(RGB2B, GPIO.OUTPUT);
    GPIO.pinMode(RGB1R, GPIO.OUTPUT);
    GPIO.pinMode(RGB1G, GPIO.OUTPUT);
    GPIO.pinMode(RGB1B, GPIO.OUTPUT);
    GPIO.pinMode(RGB3R, GPIO.OUTPUT);
    GPIO.pinMode(RGB3G, GPIO.OUTPUT);
    GPIO.pinMode(RGB3B, GPIO.OUTPUT);
    
    
    GPIO.digitalWrite(5,GPIO.HIGH);
    GPIO.digitalWrite(6,GPIO.HIGH);
    
  }
  else
    println("Lichtansteuerung wird nich ausgeführt!");
}

//**********************************************************
void AussenLicht (int Rot, int Gruen, int Blau)
{
  //Integer Werte nur von 0-255 akzeptabel
  if (FehlerLicht == false)
  {
      //R______________________________________
      //KanalB DAC2
      GPIO.digitalWrite(5,GPIO.LOW);
      value = Rot;
      value_left = value >> 4;
      value_right = ((value << 4) & 0xf0);
      config = 0x90;
      value_left = config | value_left;
      DAC_OUT[0] = byte(value_left);
      DAC_OUT[1] = byte(value_right);
      spi.transfer(DAC_OUT);
      GPIO.digitalWrite(5,GPIO.HIGH);
      //ENDE___________________________________
      
      //G______________________________________
      //KanalB DAC1
      GPIO.digitalWrite(6,GPIO.LOW);
      value = Gruen;
      value_left = value >> 4;
      value_right = ((value << 4) & 0xf0);
      config = 0x90;
      value_left = config | value_left;
      DAC_OUT[0] = byte(value_left);
      DAC_OUT[1] = byte(value_right);
      spi.transfer(DAC_OUT);
      GPIO.digitalWrite(6,GPIO.HIGH);
      //ENDE___________________________________
      
      //B______________________________________
      //KanalA DAC2
      GPIO.digitalWrite(5,GPIO.LOW);
      value = Blau;
      value_left = value >> 4;
      value_right = ((value << 4) & 0xf0);
      config = 0x10;
      value_left = config | value_left;
      DAC_OUT[0] = byte(value_left);
      DAC_OUT[1] = byte(value_right);
      spi.transfer(DAC_OUT);
      GPIO.digitalWrite(5,GPIO.HIGH);
      //ENDE___________________________________
  }
}

//**********************************************************
void InnenLichtLinks(boolean Rot, boolean Gruen, boolean Blau)
{
  if(Rot == false)
    GPIO.pinMode(RGB1R, GPIO.HIGH);
  else
    GPIO.pinMode(RGB1R, GPIO.LOW);  
  if(Gruen == false)
    GPIO.pinMode(RGB1G, GPIO.HIGH);
  else
    GPIO.pinMode(RGB1G, GPIO.LOW);  
  if(Blau == false)
    GPIO.pinMode(RGB1B, GPIO.HIGH);
  else
    GPIO.pinMode(RGB1B, GPIO.LOW);
}

//**********************************************************
void InnenLichtRechts(boolean Rot, boolean Gruen, boolean Blau)
{
  if(Rot == false)
    GPIO.pinMode(RGB3R, GPIO.HIGH);
  else
    GPIO.pinMode(RGB3R, GPIO.LOW);  
  if(Gruen == false)
    GPIO.pinMode(RGB3G, GPIO.HIGH);
  else
    GPIO.pinMode(RGB3G, GPIO.LOW);  
  if(Blau == false)
    GPIO.pinMode(RGB3B, GPIO.HIGH);
  else
    GPIO.pinMode(RGB3B, GPIO.LOW);
}

//**********************************************************
void InnenLichtOben(boolean Rot, boolean Gruen, boolean Blau)
{
  if(Rot == false)
    GPIO.pinMode(RGB2R, GPIO.HIGH);
  else
    GPIO.pinMode(RGB2R, GPIO.LOW);  
  if(Gruen == false)
    GPIO.pinMode(RGB2G, GPIO.HIGH);
  else
    GPIO.pinMode(RGB2G, GPIO.LOW);  
  if(Blau == false)
    GPIO.pinMode(RGB2B, GPIO.HIGH);
  else
    GPIO.pinMode(RGB2B, GPIO.LOW);
}

//**********************************************************
void InnenLicht(boolean R, boolean G, boolean B)
{
  if (FehlerLicht == false)
  {
    InnenLichtLinks(R,G,B);
    InnenLichtRechts(R,G,B);
    InnenLichtOben(R,G,B);
  }
}
