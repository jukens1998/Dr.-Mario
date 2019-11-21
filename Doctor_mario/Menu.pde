class Menu extends PApplet { //<>// //<>//

  //Varaibles booleanas que hacen referencia a los botones de la interfaz, que cambian de estado si el cursor esta encima o no.
  boolean music1Over;
  boolean music2Over;
  boolean offOver;
  boolean estado;
  boolean selectlevel;
  boolean selectMus;

  //Metodo que crear la ventana, reproduce la musica y le hace Mute.
  public void settings() {
    fullScreen();
    playerMM.trigger();
    playerMM.mute();
    music1Over=false;
    music2Over=false;
    offOver= false;
    estado=false;
    selectlevel=true;
    selectMus=false;
    n=5;
  }

  //Metodo que dibuja todos los elementos de la ventana.
  public void draw() {

    textSize(60);
    textFont(font1);
    fondo();
    contenido();
    numeroDeV();
    menu();
  }

  //Metodo para generar el fondo de la ventana.
  void fondo() {
    for (int i=0; i<width; i+=60) {

      for (int j=0; j<width; j+=60) {

        noStroke();
        fill(250, 196, 45);
        rect(i, j, 30, 30);
        rect(i+30, j+30, 30, 30);
        fill(255, 0, 100);
        rect(i+30, j, 30, 30);
        rect(i, j+30, 30, 30);
      }
    }

    fill(0);
    strokeWeight(11);
    stroke(240, 152, 10);
    beginShape();
    rect(450, 60, 1020, 30, 20, 20, 0, 0);
    rect(360, 90, 1200, 900, 20, 20, 20, 20);
    fill(0);
    strokeWeight(9);
    strokeJoin(ROUND);
    strokeCap(ROUND);
    stroke(255, 0, 100);
    beginShape();
    vertex(370, 100);
    vertex(460, 100);
    vertex(460, 70);
    vertex(1460, 70);
    vertex(1460, 100);
    vertex(1550, 100);
    vertex(1550, 980);
    vertex(370, 980);
    endShape(CLOSE);
  }

  //Metodo que genera el contenido que va a tener la ventana, eso se refiera a etiquetas y botonoes.
  public void contenido() {
    textSize(60);
    fill(255);
    text("Player Game", 800, 125);

    noFill();
    strokeWeight(3);
    stroke(255, 0, 100);
    triangle(1020, 390, 1150, 440, 1020, 490);
    triangle(860, 390, 730, 440, 860, 490);
    beginShape();
    vertex(840,440);
    vertex(800,440);
    endShape();
    
    beginShape();
    vertex(1040,440);
    vertex(1080,440);
    endShape();

    beginShape();
    vertex(1060,420);
    vertex(1060,460);
    endShape();



    if (selectlevel)
      stroke(253, 135, 135);
    else
      stroke(255, 0, 100);
    text("Virus Level", 400, 300);
    strokeWeight(2);
    noFill();
    rect(390, 245, 350, 70);

    if (selectMus)
      stroke(253, 135, 135);
    else
      stroke(255, 0, 100);
    text("Music Type", 400, 600);
    strokeWeight(2);
    noFill();
    rect(390, 545, 350, 70);

    if (music1Over)
      stroke(253, 135, 135);
    else
      stroke(255, 0, 100);
    text("music 1", 410, 800);
    strokeWeight(2);
    noFill();
    rect(400, 745, 340, 70);

    if (music2Over)
      stroke(253, 135, 135);
    else
      stroke(255, 0, 100);
    text("music 2", 810, 800);
    strokeWeight(2);
    noFill();
    rect(800, 745, 340, 70);

    if (offOver)
      stroke(253, 135, 135);
    else
      stroke(255, 0, 100);
    text("Off", 1210, 800);
    strokeWeight(2);
    noFill();
    rect(1200, 745, 300, 70);
  }

  void changeLevel()
  {
    // while (mySerial.available()>0) {
    // myString = mySerial.readString();

    if (myString!=null) {
      val = myString;
      if (val.equals("Left") && n>0 )
      {
        n--;
      }
      if (val.equals("Right") && n<11 )
      {
        n++;
      }
    }
    //}
  }

  //Metodo que imprime el valor del estado del Slider.
  public void numeroDeV() {

    textSize(150);
    text(n, 900, 490);
    strokeWeight(2);
    stroke(0, 255, 100);
    noFill();
    rect(890, 385, 100, 105);
  }

  void menu()
  {
    while (mySerial.available()>0) {
      myString = mySerial.readString();
      if (selectlevel) {
        changeLevel();
        print(myString);
        if (myString!=null) {
          val = myString;
          if (val.equals("Enter")) {
            selectMus=true;
            selectlevel=false;
            music2Over=true;
          }
        }
      }
      if (selectMus) {
        selectMusic();
        mySerial.write(n);
      }
    }
  }

  void selectMusic()
  {
    // while (mySerial.available()>0) {
    // myString = mySerial.readString();

    if (myString!=null) {
      val = myString;
      if (val.equals("Right") && music1Over && !estado)
      {
        music1Over=false;
        music2Over=true;
        offOver=false;
        estado=true;
      } else if (val.equals("Right") && music2Over && !estado)
      {
        music2Over=false;
        offOver=true;
        estado=true;
        music1Over=false;
      } else if (val.equals("Left") && offOver &&!estado)
      {
        offOver=false;
        music2Over=true;
        music1Over=false;
        estado=true;
      } else if (val.equals("Left") && music2Over&& !estado)
      {
        music2Over=false;
        music1Over=true;
        offOver=false;
        estado=true;
      }
    }
    // }
    estado=false;
  }


  //Metodo para pasar a gameplay.
  public void startGa()
  {
    while (mySerial.available()>0) {
      myString = mySerial.readString();

      if (myString!=null) {
        val = myString;
        if (val.equals("Enter") && selectMus) {    
          if (music1Over) {
            playerMM.mute();
            playerIM.unmute();
          } else if (music2Over)
          {
          } else if (offOver)
          {
            playerMM.mute();
            playerIM.mute();
          }
          ani.getSurface().setVisible(true);
          selectMus=false;
          selectlevel=true;
          getSurface().setVisible(false);
          empieza=1;
          mySerial.write(empieza);
        }
      }
    }
  }
}
