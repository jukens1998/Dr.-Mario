class animation extends PApplet {


  public void settings() {
    fullScreen();

    puntaje ="";
  }

  public void draw() {
    background (0,128,0);

    image(DrMario, 1450, 40);
    
    image(Virus,50,550);
    
    textFont(font1);
    textSize(100);
    text("Score:", 100, 350);
    text(puntaje, 100, 450);
  }
  public void puntaje()
  {
    while (mySerial.available()>0) {
      myString = mySerial.readString();

      if (myString!=null) {
        puntaje = myString;
      }
    }
  }
}
