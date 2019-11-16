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

//colores de las bacterias
int colorBacterias[59][2];

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
void titilarBacterias(int i, int color) {
  if (color == 1) {
    pixels.setPixelColor(i, pixels.Color(255, 0, 0));
    delay(25);
    pixels.show();
    pixels.setPixelColor(i, pixels.Color(0, 0, 0));
    delay(25);
    pixels.show();
  }
  if (color == 2) {
    pixels.setPixelColor(i, pixels.Color(0, 255, 0));
    delay(25);
    pixels.show();
    pixels.setPixelColor(i, pixels.Color(0, 0, 0));
    delay(25);
    pixels.show();
  }
  if (color == 3) {
    pixels.setPixelColor(i, pixels.Color(0, 0, 255));
    delay(25);
    pixels.show();
    pixels.setPixelColor(i, pixels.Color(0, 0, 0));
    delay(25);
    pixels.show();
  }
  if (color == 4) {
    pixels.setPixelColor(i, pixels.Color(0, 0, 0));
    delay(100);
    pixels.show();
  }
}

// crea bacterias en posiciones aleatorias

void generadorBacteria(int CantidadBacterias) {

  for (int i = 0; i <= CantidadBacterias; i++) {
    int bacteria = random(0, 60);
    myPins[bacteria] = 1;
  }

  for (int i = 0; i <= 59; i++) {
    if (myPins[i] == 1) {
      pixels.setPixelColor(i, pixels.Color(0, 255, 0));
      delay(100);
      pixels.show();
      int colores = random(1, 4);
      colorBacterias[i][colores] = colores;
    }

  }
}

//Revisa la posicion de las bacterias y titila
void titilar(){
   for (int j = 0; j <= 59; j++) {
    for (int h = 1; h <= 3; h++) {
      if (myPins[j] == 1) {
        if (h > 0) {
          titilarBacterias(j, colorBacterias[j][h]);
        }
      }
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
    generadorBacteria(10);
  }
 
titilar();

}
