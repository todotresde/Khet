class Pantalla {
  PFont font;
  Boton botonJ1, botonJ2, botonReglas, botonCreditos, botonVolver;
  boolean activoBotonJ1, activoBotonJ2, activoBotonReglas, activoBotonCreditos, activoBotonVolver;
  Juego juego;

  Pantalla() {
    font = loadFont("Purisa-Bold-32.vlw");
    botonJ1 = new Boton("1 Jugador",200, 230);
    botonJ2 = new Boton("2 Jugadores",200, 260);
    botonReglas = new Boton("Reglas",200, 290);
    botonCreditos = new Boton("Creditos",200, 320);
    botonVolver = new Boton("Volver", 400, 370);

    resetearEstadoBotones();
    juego = new Juego();
  }

  void dibujar() {
    if(activoBotonJ1) {
      pantalla2();
    }
    else if(activoBotonJ2) {
      juego.dibujar();
    }
    else if(activoBotonReglas) {
      pantalla3();
    }
    else if(activoBotonCreditos) {
      pantalla4();
    }

    else {
      pantalla1();
    }
  }

  void click() {
    if(!activoBotonJ2) {
      if(botonJ1.click()) {
        activoBotonJ1 = true;
      }
      if(botonJ2.click()) {
        activoBotonJ2 = true;
      }
      if(botonReglas.click()) {
        activoBotonReglas = true;
      }
      if(botonCreditos.click()) {
        activoBotonCreditos = true;
      }
      if(botonVolver.click()) {
        resetearEstadoBotones();
        activoBotonVolver = true;
      }
    }
    else {
      juego.click();
    }
  }

  void press() {
    if(activoBotonJ2 && ((key == 'r') || (key == 'R'))) {
      resetearEstadoBotones();
    }
    else { 
      if(activoBotonJ2) {
        juego.press();
      }
    }
  }

  void pantalla1() {
    tituloJuego();
    botonJ1.dibujar();
    botonJ2.dibujar();
    botonReglas.dibujar();
    botonCreditos.dibujar();
  }

  void pantalla2() {
    tituloJuego();
    textFont(font, 20); 
    text("Se ve que no tenes muchos amigos y queres jugar solo. Mejor buscate mas amigos y juga de a dos!!", 50, 150,450,200);
    botonVolver.dibujar();
  }

  void pantalla3() {
    tituloJuego();
    textFont(font, 15); 
    text("* Con la 'S' dispara el laser.",50,150);
    textFont(font, 15);
    text("* Con el mouse se selecciona la ficha.", 50, 190);
    textFont(font, 15);
    text("* Con 'Z' y 'X' se rota la ficha.", 50, 230);
    textFont(font, 15);
    text("* Con las flechas del teclado se mueve la ficha.", 50, 270, 450, 400);
    textFont(font, 15);
    text("* Con la 'R' durante el juego, vuelve al menu principal.", 50, 310, 450, 400);
    botonVolver.dibujar();
  }

  void pantalla4() {
    tituloJuego();
    textFont(font, 20); 
    text("Creditos!!!!", 50, 150,450,400);
    botonVolver.dibujar();
  }

  void tituloJuego() {
    textFont(font, 52); 
    text("Khet", 150, 80);
  }

  void resetearEstadoBotones() {
    activoBotonJ1 = false;
    activoBotonJ2 = false;
    activoBotonReglas = false;
    activoBotonCreditos = false;
    activoBotonVolver = false;
  }
  
  void stop(){
    juego.stop();
  }
}

