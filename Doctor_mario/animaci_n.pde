class animation extends PApplet {

  
  
  public void settings() {
    fullScreen();
    
    puntaje =100;
  }

  public void draw() {
    background (0);
    
    image(loopingGif, 1400, 40);
    
    textSize(100);
    text("Score:", 100, 400);
    text(puntaje, 400, 400);
  }
}
