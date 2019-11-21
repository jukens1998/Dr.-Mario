#include <Adafruit_Circuit_Playground.h>

// NeoPixel Ring simple sketch (c) 2013 Shae Erisson
// Released under the GPLv3 license to match the rest of the
// Adafruit NeoPixel library

#include <Adafruit_NeoPixel.h>
#ifdef AVR
#include <avr/power.h>
#endif

#define PIN        6

#define NUMPIXELS 60

Adafruit_NeoPixel pixels(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

#define DELAYVAL 500
//Variable que empieza el juego
int empiezaJuego;

//colores de los elementos
int azul[3] = {0, 0, 255};

// mapa de dr mario
int numeroPixeles = 59;
bool crear = true;
int myPins[60];
void setup() {
  Serial.begin(9600);

#if defined(AVR_ATtiny85) && (F_CPU == 16000000)
  clock_prescale_set(clock_div_1);
#endif
  pixels.begin();
}



// Crear mapa
void crearMapa() {
  // llena el vector del mapa con ceros
  for (int i = 0; i <= numeroPixeles ; i++) {
    myPins[i] = 0;
  }
  delay(2000);
}

//Titilar bacterias
void titilarBacterias() {
  Serial.print("entra");
  for (int i = 0; i <= 59; i++) {
    if (myPins[i] == 1) {
      int aleatorio = random(1, 4);
      delay(1000);
      //genera aleatorio enre 1 y 3 donde 1 es rojo 2 es verde y 3 es azul
      Serial.println(aleatorio);
      if (aleatorio == 1) {
        pixels.setPixelColor(i, pixels.Color(255, 0, 0));
        delay(1000);
        pixels.show();
        delay(1000);
      }
      else if (aleatorio == 2) {
        pixels.setPixelColor(i, pixels.Color(0, 255, 0));
        delay(1000);
        pixels.show();
      }
      else if (aleatorio == 3) {
        pixels.setPixelColor(i, pixels.Color(0, 0, 255));
        delay(1000);
        pixels.show();
      }
      else if (aleatorio == 4) {
        pixels.setPixelColor(i, pixels.Color(0, 0, 0));
        delay(1000);
        pixels.show();
      }

    }
  }
}

// crea bacterias en posiciones aleatorias

void generadorBacteria(int CantidadBacterias) {
  for (int i = 0; i <= CantidadBacterias; i++) {
    int bacteria = random(0, 59);
    myPins[bacteria] = 1;
  }

  for (int i = 0; i <= 59; i++) {
    if (myPins[i] == 1) {
      Serial.println(i);
      pixels.setPixelColor(i, pixels.Color(0, 0, 255));
      delay(100);
      pixels.show();
    }
  }
}


//Verifica Si hay pildoras y virus del mismo color continuas.
void verificar()
{
  //Verifica horizontalmente

  for (int j = 0; j < 23; j++) {
    int a = myPins[j];
    int colorA = pixels.getPixelColor(j);
    int b = myPins[j + 12];
    int colorB = pixels.getPixelColor(j + 12);
    int c = myPins[j + 24];
    int colorC = pixels.getPixelColor(j + 24);
    int d = myPins[j + 36];
    int colorD = pixels.getPixelColor(j + 36);
    //En esta parte se comparan los colores
    if (colorA == colorB && colorA == colorC && colorA == colorD) {
      myPins[j] = 0;
      pixels.setPixelColor(j, pixels.Color(0, 0, 0));
      myPins[j + 12] = 0;
      pixels.setPixelColor(j + 12, pixels.Color(0, 0, 0));
      myPins[j + 24] = 0;
      pixels.setPixelColor(j + 24, pixels.Color(0, 0, 0));
      myPins[j + 36] = 0;
      pixels.setPixelColor(j + 36, pixels.Color(0, 0, 0));
    }
  }

  //Verificar verticalmente

  for (int j = 0; j < 57; j++) {

    int a = myPins[j];
    int colorA = pixels.getPixelColor(j);
    int b = myPins[j + 1];
    int colorB = pixels.getPixelColor(j + 1);
    int c = myPins[j + 2];
    int colorC = pixels.getPixelColor(j + 2);
    int d = myPins[j + 3];
    int colorD = pixels.getPixelColor(j + 3);

    //En esta parte se comparan los colores
    if (colorA == colorB && colorA == colorC && colorA == colorD) {
      myPins[j] = 0;
      pixels.setPixelColor(j, pixels.Color(0, 0, 0));
      myPins[j + 1] = 0;
      pixels.setPixelColor(j + 1, pixels.Color(0, 0, 0));
      myPins[j + 2] = 0;
      pixels.setPixelColor(j + 2, pixels.Color(0, 0, 0));
      myPins[j + 3] = 0;
      pixels.setPixelColor(j + 3, pixels.Color(0, 0, 0));
    }

  }

}

void loop() {
  if (empiezaJuego < 2) {
    empiezaJuego = empiezaJuego + 1;
  }
  if (empiezaJuego == 1) {
    Serial.println("GOOOOO");
    crearMapa();
    generadorBacteria(4);
  }

  titilarBacterias();

}
