class Menu extends PApplet { //<>//

  //Varaibles booleanas que hacen referencia a los botones de la interfaz, que cambian de estado si el cursor esta encima o no.
  boolean music1Over;
  boolean music2Over;
  boolean offOver;

  //Metodo que crear la ventana, reproduce la musica y le hace Mute.
  public void settings() {
    fullScreen();
    playerMM.trigger();
    playerMM.mute();
  }

  //Metodo que dibuja todos los elementos de la ventana.
  public void draw() {

    textSize(60);
    textFont(font1);
    update(mouseX, mouseY);
    fondo();
    contenido();
    numeroDeV();
    
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



    text("Virus Level", 400, 300);
    strokeWeight(2);
    noFill();
    rect(390, 245, 350, 70);



    text("Music Type", 400, 600);
    strokeWeight(2);
    noFill();
    rect(390, 545, 350, 70);

    text("music 1", 410, 800);
    strokeWeight(2);
    noFill();
    rect(400, 745, 340, 70);

    text("music 2", 810, 800);
    strokeWeight(2);
    noFill();
    rect(800, 745, 340, 70);

    text("Off", 1210, 800);
    strokeWeight(2);
    noFill();
    rect(1200, 745, 300, 70);
  }

  //Metodo que imprime el valor del estado del Slider.
  public void numeroDeV() {

    text(n, 1300, 400);
    strokeWeight(2);
    stroke(0, 255, 100);
    noFill();
    rect(1290, 345, 90, 70);
  }

  //Metodo que cambia los valores de las variables boolenas, dependiendo de si el cursor esta encima del boton o no.
  void update(int x, int y) {
    if ( overM2(800, 745, 340, 70) ) {
      music2Over = true;
      music1Over = false;
      offOver = false;
    } else if ( overM1(400, 745, 340, 70) ) {
      music1Over = true;
      music2Over = false;
      offOver = false;
    } else if ( overOff(1200, 745, 300, 70) ) {
      music1Over = false;
      music2Over = false;
      offOver = true;
    } else {
      music1Over = music2Over = false;
    }
  }

  //Metodo que se encarga de saber si el mouse presiono un boton.
  void mousePressed() {
    if (music1Over) {
    }
    if (music2Over) {
    }
    if (offOver) {
    }
  }

  //Metodo que verifica si el cursor se encuentra sobre el boton Music1.
  //retorna true si lo esta, de lo contrario false.
  boolean overM1(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }

  //Metodo que verifica si el cursor se encuentra sobre el boton Music2.
  //retorna true si lo esta, de lo contrario false.
  boolean overM2(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }

  //Metodo que verifica si el cursor se encuentra sobre el boton Off.
  //retorna true si lo esta, de lo contrario false.
  boolean overOff(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }

  //Metodo para pasar a gameplay.
  public void startGa()
  {
    if (keyPressed) {
      if (key=='p') {    
        playerMM.mute();
        ani.getSurface().setVisible(true);
        getSurface().setVisible(false);
      }
    }
  }
}
