//Importacion de las bibliotecas requeridas.
import ddf.minim.*;
import processing.serial.*;
import processing.awt.PSurfaceAWT;
import g4p_controls.*;
import gifAnimation.*;
import processing.awt.PSurfaceAWT;
import processing.serial.*;

//Objetos que hacen la funcion de reproducir musica.
Minim minin;
AudioSample playerIM;
AudioSample playerMM;

//Objeto que genera un Slider para definir la dificultad del juego.
GCustomSlider sdr;

Gif DrMario;
Gif Virus;

//Puerto Serial para la conexion con arduino.
Serial mySerial;

String myString=null;
String val;

//Objeto para poner una imagen en la interfaz
PImage mario;

//fuente usada en la interfaz
PFont font1;

//Señal de inicio del juego
int empieza;

//numero de viruses.
int n;

//Variables para la animacion.
float y = 40;
float vy = 0;
float dt = 1.0/30.0;
float gravity = 3000;
float restitution = .7;

//puntaje del jugador.
String puntaje;

//Objeto que funciona para crear la interfaz inicial.
Intro intro;

//Objeto que funciona para crear la interfaz del menu del juego. 
Menu menu;

//Objeto que funciona para crear la interfaz del gameplay.
animation ani;

//metodo que inicializa los objetos anteriores.
//Tambien inicializa las interfaces y oculta el menu.
//Crear el slider que va ir ubicado en la interfaz del menu.
void setup() {
  minin = new Minim(this);
  playerIM = minin.loadSample("1 - Title Theme.mp3");

  playerMM = minin.loadSample("2 - Select.mp3");
  font1 = createFont("ARCADECLASSIC.TTF", 80);
  mario=loadImage("mainpng.jpg");
  
  String myPort=Serial.list()[1];
  mySerial=new Serial(this, myPort,9600);


  intro=new Intro();
  runSketch(new String[]{"Intro"}, intro); 
  intro.getSurface().setVisible(true);

  menu=new Menu();
  runSketch(new String[]{"Menu"}, menu);
  menu.getSurface().setVisible(false);
 



  DrMario = new Gif(this, "DrMario.gif");
  DrMario.loop();
  Virus = new Gif(this, "Virus.gif");
  Virus.loop();
  ani = new animation();
  runSketch(new String[]{"Gameplay"}, ani);
  ani.getSurface().setVisible(false);
}

//metodo que dibuja y actualiza lo ocurrido en pantalla.
void draw() {
  

  if (((PSurfaceAWT.SmoothCanvas) intro.getSurface().getNative()).getFrame().isVisible()==true) {
    intro.startG();
  } else if (((PSurfaceAWT.SmoothCanvas) menu.getSurface().getNative()).getFrame().isVisible()==true) {
    menu.startGa();
  } else if (((PSurfaceAWT.SmoothCanvas) ani.getSurface().getNative()).getFrame().isVisible()==true) {
    ani.puntaje();
  }
}
