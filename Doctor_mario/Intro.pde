class Intro extends PApplet {

  //Metodo constructor de la interfaz incial o intro. 
  public void settings() {
    fullScreen();
    playerIM.trigger();
    mario.resize(1940, 1080);
  }

  //Metodo que dibuja todos los elementos en la ventana.
  public  void draw() {
    background(255, 255, 255);
    image(mario, 0, 0);

    fill(0);
    textSize(60);
    textFont(font1);

    text("Presiona Enter", 680, y);

    vy += gravity*dt;
    y += vy*dt;
    if (y > 1039) {
      y = 1040;
      vy *= -restitution;
    }
  }

  //Metodo que cambia la ventana de intro a la del menu al precionar la tecla ENTER.
  //Mute la musica del intro y unmute la musica del menu. 
  public void startG()
  {
    while (mySerial.available()>0) {
      myString = mySerial.readString();
      if (myString!=null)
      {
        val = myString;
        if (val.equals("Enter")) {
          playerIM.mute();
          playerMM.unmute();
          menu.getSurface().setVisible(true);
          getSurface().setVisible(false);
        }
      }
    }
  }  
}
  
