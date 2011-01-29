class Pantalla {
  PFont font;
  Boton botonJ1, botonJ2, botonJ3, botonReglas, botonCreditos, botonVolver;
  boolean activoBotonJ1, activoBotonJ2, activoBotonJ3, activoBotonReglas, activoBotonCreditos, activoBotonVolver;
  Juego juego;
  PImage imagenTop;
  
  Pantalla() {
    font = loadFont("Arial-BoldMT-24.vlw");
    botonJ1 = new Boton("- Classic",200, 170);
    botonJ2 = new Boton("- Imhotep",200, 200);
    botonJ3 = new Boton("- Dynasty",200, 230);
    botonReglas = new Boton("Reglas",200, 320);
    botonCreditos = new Boton("Creditos",200, 350);
    botonVolver = new Boton("Volver", 400, 370);
   
    imagenTop = loadImage("top.png");

    resetearEstadoBotones();
    juego = new Juego();
  }

  void dibujar() {
    if(activoBotonJ1 || activoBotonJ2 || activoBotonJ3) {
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
    if(!activoBotonJ1 && !activoBotonJ2 && !activoBotonJ3) {
      if(botonJ1.click()) {
        activoBotonJ1 = true;
        juego.iniciar(1);
      }
      if(botonJ2.click()) {
        activoBotonJ2 = true;
        juego.iniciar(2);
      }
      if(botonJ3.click()) {
        activoBotonJ3 = true;
        juego.iniciar(3);
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
    if((activoBotonJ1 || activoBotonJ2 || activoBotonJ3) && ((key == 'r') || (key == 'R'))) {
      resetearEstadoBotones();
    }
    else { 
      if(activoBotonJ1 || activoBotonJ2 || activoBotonJ3) {
        juego.press();
      }
    }
  }

  void pantalla1() {
    tituloJuego();
    botonJ1.dibujar();
    botonJ2.dibujar();
    botonJ3.dibujar();
    botonReglas.dibujar();
    botonCreditos.dibujar();
  }

  void pantalla3() {
    tituloJuego();
    textFont(font, 12); 
    text("* Se debe seleccionar la Esfinge en cada turno, y con la 'S' dispara el laser.",40,150,450, 400);
    textFont(font, 12);
    text("* Con el mouse se selecciona la ficha que se desea mover.", 40, 190,450, 400);
    textFont(font, 12);
    text("* Con 'Z' y 'X' se rota la ficha seleccionada.", 40, 210,450, 400);
    textFont(font, 12);
    text("* Con las flechas del teclado se mueve la ficha seleccionada.", 40, 230, 450, 400);
    textFont(font, 12);
    text("* Con la 'R' durante el juego, vuelve al menu principal.", 40, 250, 450, 400);
    textFont(font, 12); 
    text("* La Esfinge solo debe rotar en el lugar de inicio. La misma nunca muere.",40,270,450, 400);
    textFont(font, 12); 
    text("* La pieza Obelisco no muere si el laser le pega de frente.",40,310,450, 400);
    botonVolver.dibujar();
  }

  void pantalla4() {
    tituloJuego();
    textFont(font, 20); 
    text("Creditos!!!!", 50, 150,450,400);
    botonVolver.dibujar();
  }

  void tituloJuego() {
    //textFont(font, 52); 
    //text("Khet", 150, 80);
    imageMode(CORNER);
    image(imagenTop, 0, 0,width,100);
  }

  void resetearEstadoBotones() {
    activoBotonJ1 = false;
    activoBotonJ2 = false;
    activoBotonJ3 = false;
    activoBotonReglas = false;
    activoBotonCreditos = false;
    activoBotonVolver = false;
  }
  
  void stop(){
    juego.stop();
  }
}

