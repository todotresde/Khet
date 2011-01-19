class Celda {
  Pieza pieza;
  int posX, posY, tam, posXTablero, posYTablero, tipoCelda;
  PImage imagenCelda;

  Celda(int pposX, int pposY, int ptam) {
    posXTablero = pposX;
    posYTablero = pposY;
    posX = pposX * ptam;
    posY = pposY * ptam;
    tam = ptam;
    tipoCelda = 0;
    definirImagen();
  }

  Celda(int pposX, int pposY, int ptam, int ptipoCelda) {
    posXTablero = pposX;
    posYTablero = pposY;
    posX = pposX * ptam;
    posY = pposY * ptam;
    tam = ptam;
    tipoCelda = ptipoCelda;
    definirImagen();
  }

  void dibujar() {
    if(pieza == null) {  
      pushMatrix();
      translate(posX+tam/2, posY+tam/2);
      image(imagenCelda, 0, 0, tam, tam);
      popMatrix();
    }
    else {
      pieza.dibujar();
    }
  }

  void ponerPieza(Pieza ppieza,int prot) {
    pieza = ppieza;
    pieza.setPieza(posXTablero,posYTablero,prot,tam);
  }

  void quitarPieza() {
    pieza = null;
  }

  boolean click(float pposX, float pposY) {
    return(posX < pposX && posX+tam > pposX && posY < pposY && posY+tam > pposY );
  }

  void definirImagen() {    
    imageMode(CORNER);
    if(tipoCelda == 0) {
      imagenCelda = loadImage("celda-neutral.png");
    }
    else if(tipoCelda == 1) {
      imagenCelda = loadImage("celda-roja.png");
    }
    else {
      imagenCelda = loadImage("celda-azul.png");
    }
  }
}

