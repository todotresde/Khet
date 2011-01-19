class Celda {
  Pieza pieza;
  int posX, posY, tam, posXTablero, posYTablero;

  Celda(int pposX, int pposY, int ptam) {
    posXTablero = pposX;
    posYTablero = pposY;
    posX = pposX * ptam;
    posY = pposY * ptam;
    tam = ptam;
  }

  void dibujar() {
    if(pieza == null) {
      stroke(0);
      strokeWeight(1);
      fill(255,255,255);
      rect(posX,posY,tam,tam);
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
  
  boolean click(float pposX, float pposY){
    return(posX < pposX && posX+tam > pposX && posY < pposY && posY+tam > pposY );
  }
}

