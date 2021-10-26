
import g4p_controls.*; //Für Slider
GCustomSlider cam1,cam2,cam3; //Simulation für Kamera

void SliderInit()
{
  
 G4P.setSliderFont("Courier", G4P.BOLD, 10);
  // Simple default slider,
  // constructor is `Parent applet', the x, y position and length
  textSize(50);
  text("CAM1",80,90);
  cam1 = new GCustomSlider(this, 80, 100, 400, 100, null);
  // show          opaque  ticks value limits
  cam1.setShowDecor(true, true, true, true);
  cam1.setNbrTicks(10);
  cam1.setLimits(0, -400, 400);
  textSize(50);
  text("CAM2",80,290);
  cam2 = new GCustomSlider(this, 80, 300, 400, 100, null);
  // show          opaque  ticks value limits
  cam2.setShowDecor(true, true, true, true);
  cam2.setNbrTicks(10);
  cam2.setLimits(0, -400, 400);
  textSize(50);
  text("CAM3",80,490);
  cam3 = new GCustomSlider(this, 80, 500, 400, 100, null);
  // show          opaque  ticks value limits
  cam3.setShowDecor(true, true, true, true);
  cam3.setNbrTicks(10);
  cam3.setLimits(0, -400, 400);
  cam3.getValueI();
}


void handleSliderEvents(GCustomSlider slider) {
  println("integer value:" + slider.getValueI() + " float value:" + slider.getValueF());
  
}
