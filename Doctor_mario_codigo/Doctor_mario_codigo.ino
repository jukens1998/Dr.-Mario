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

//Contador de giro
int contadorGiro;

///
int prueba;

//Variable que empieza el juego
int empiezaJuego;

//colores de las bacterias
int colorBacterias[59][2];

// color de las pildoras
double colorPildoras[59][2];

// mapa de dr mario
int numeroPixeles = 59;
bool crear = true;
int myPins[60];

//pastillas
int pastilla1;
int pastilla2;
void setup() {
  Serial.begin(9600);

#if defined(AVR_ATtiny85) && (F_CPU == 16000000)
  clock_prescale_set(clock_div_1);
#endif
  pixels.begin();
}


//graficar elementos en la matriz;
void graficar(int a, int b) {

  pixels.setPixelColor(a, pixels.Color(0, 255, 0));
  pixels.setPixelColor(b, pixels.Color(0, 255, 0));
  delay(200);
  pixels.show();
}



// funcion pastillas
void pastas(bool movimientoPastilla) {
  pastilla1 = 12;
  pastilla2 = 24;
  while (movimientoPastilla) {

    for (int i = 0; i < 12; i++) {


      /// Funcion de movimiento izquierda derecha
      int izquierdaControl = digitalRead(5);
      int derechaControl = digitalRead(4);


      if (myPins[pastilla1 + 1] == 1 || myPins[pastilla2 + 1] == 1 ) {
        myPins[pastilla1] = 1;
        if (contadorGiro > 1) {
          myPins[pastilla2+1] = 1;
        }else{
          myPins[pastilla2] = 1;
        }

        movimientoPastilla = false;
        i = 12;
        contadorGiro = 0;
      }
      if (derechaControl == 1) {
        if (pastilla2 <= 59) {
          pixels.setPixelColor(pastilla1, pixels.Color(0, 0, 0));
          pastilla1 = pastilla1 + 12;
          pastilla2 = pastilla2 + 12;
        }
      }
      if (izquierdaControl == 1) {
        if (pastilla1 >= 12) {
          pixels.setPixelColor(pastilla2, pixels.Color(0, 0, 0));
          pastilla1 = pastilla1 - 12;
          pastilla2 = pastilla2 - 12;
        }
      }
      /// Funcion de movimiento izquierda derecha

      /// funcion de girar
      int giroControl = digitalRead(10);
      Serial.println(giroControl);
      delay(200);
      if (giroControl == 1) {
        contadorGiro = contadorGiro + 1;
        delay(200);
        if (contadorGiro >= 3) {
          contadorGiro = 0;
        }
        switch (contadorGiro) {
          case 1:
            pastilla2 = pastilla2 - 13;

            Serial.println("esta en el 1");
            Serial.println(contadorGiro);
            break;
          case 2:
            pastilla2 = pastilla2 + 13;
            Serial.println("esta en el 2");
            break;

          default:
            // if nothing else matches, do the default
            // default is optional
            break;
        }
      }


      /// funcion de girar

      pixels.setPixelColor(pastilla1, pixels.Color(0, 255, 0));
      pixels.setPixelColor(pastilla2, pixels.Color(0, 255, 0));
      delay(200);
      pixels.show();
      pixels.setPixelColor(pastilla1, pixels.Color(0, 0, 0));
      pixels.setPixelColor(pastilla2, pixels.Color(0, 0, 0));

      pastilla1++;
      pastilla2++;

      pixels.setPixelColor(pastilla1, pixels.Color(0, 255, 0));
      pixels.setPixelColor(pastilla2, pixels.Color(0, 255, 0));
      delay(200);
      pixels.show();
      pixels.setPixelColor(pastilla1, pixels.Color(0, 0, 0));
      pixels.setPixelColor(pastilla2, pixels.Color(0, 0, 0));


    }
    graficar(pastilla1, pastilla2);

  }
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
void titilar() {
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
    generadorBacteria(4);
  }

  titilar();

    pastas(true);

}
