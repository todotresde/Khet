class Tablero {
  Celda [][] tablero;
  int cantFilas = 10;
  int cantCols = 8;
  int tamCelda = 50;
  Pieza piezaSeleccionada;
  Juego juego;
  AudioPlayer explosion;
  
  Tablero(Juego pjuego) {
    juego = pjuego;
    tablero = new Celda [cantFilas][cantCols];

    for(int i=0; i<cantFilas;i++) {
      for(int j=0; j<cantCols;j++) {
        tablero[i][j] = new Celda(i,j,tamCelda);
      }
    }
    explosion = minim.loadFile("explosion.wav");
  }

  void dibujar() {
    for(int i=0; i<cantFilas;i++) {
      for(int j=0; j<cantCols;j++) {
        tablero[i][j].dibujar();
      }
    }
  }

  Pieza hayPieza(int pposX, int pposY) {
    for(int i=0; i<cantFilas;i++) {
      for(int j=0; j<cantCols;j++) {
        Celda celda = tablero[i][j];
        Pieza pieza = celda.pieza;

        if(pieza != null) {
          if(pieza.centro(pposX,pposY)) {
            return pieza;
          }
        }
      }
    }
    return null;
  }

  Pieza click() {
    for(int i=0; i<cantFilas;i++) {
      for(int j=0; j<cantCols;j++) {
        Celda celda = tablero[i][j];
        if(celda.click(mouseX,mouseY)) {
          if(celda.pieza != null){
            seleccionarPieza(celda.pieza);
            return piezaSeleccionada;
          }else{
            piezaSeleccionada.deseleccionar();
          }
        }
      }
    }
    return null;
  }

  void moverPieza(Pieza ppieza, String pdir) {
    Celda celda = tablero[ppieza.posXTablero][ppieza.posYTablero];

    if(pdir == "N") {
      if(celda.posYTablero > 0 && tablero[ppieza.posXTablero][ppieza.posYTablero-1].pieza == null) {
        tablero[ppieza.posXTablero][ppieza.posYTablero].quitarPieza();
        tablero[ppieza.posXTablero][ppieza.posYTablero-1].ponerPieza(ppieza,ppieza.rot);
      }
    }

    if(pdir == "S") {
      if(celda.posYTablero < cantCols-1 && tablero[ppieza.posXTablero][ppieza.posYTablero+1].pieza == null) {
        tablero[ppieza.posXTablero][ppieza.posYTablero].quitarPieza();
        tablero[ppieza.posXTablero][ppieza.posYTablero+1].ponerPieza(ppieza,ppieza.rot);
      }
    }

    if(pdir == "E") {
      if(celda.posXTablero < cantFilas-1 && tablero[ppieza.posXTablero+1][ppieza.posYTablero].pieza == null) {
        tablero[ppieza.posXTablero][ppieza.posYTablero].quitarPieza();        
        tablero[ppieza.posXTablero+1][ppieza.posYTablero].ponerPieza(ppieza,ppieza.rot);
      }
    }

    if(pdir == "O") {
      if(celda.posXTablero > 0 && tablero[ppieza.posXTablero-1][ppieza.posYTablero].pieza == null) {
        tablero[ppieza.posXTablero][ppieza.posYTablero].quitarPieza();
        tablero[ppieza.posXTablero-1][ppieza.posYTablero].ponerPieza(ppieza,ppieza.rot);
      }
    }
  }

  void quitarPieza(Pieza ppieza) {
    tablero[ppieza.posXTablero][ppieza.posYTablero].quitarPieza();
    explosion.play(1);
  }

  void configuracion1() {
    Pieza piezaLaser1 = new Esfinge(1,juego);
    juego.laserJugador1(piezaLaser1);
    tablero[0][0].ponerPieza(piezaLaser1,270);
    
    tablero[0][3].ponerPieza(new Piramide(1),90);
    tablero[0][4].ponerPieza(new Piramide(1),180);
    tablero[2][3].ponerPieza(new Piramide(2),270);
    tablero[2][4].ponerPieza(new Piramide(2),0);

    tablero[2][1].ponerPieza(new Piramide(1),270);
    tablero[3][2].ponerPieza(new Piramide(2),0);

    tablero[4][0].ponerPieza(new Obelisco(1),180);
    tablero[5][0].ponerPieza(new Faraon(1),180);
    tablero[6][0].ponerPieza(new Obelisco(1),180);

    tablero[7][0].ponerPieza(new Piramide(1),180);

    tablero[4][3].ponerPieza(new Anubis(1),90);
    tablero[5][3].ponerPieza(new Anubis(1),0);

    tablero[9][3].ponerPieza(new Piramide(2),0);
    tablero[9][4].ponerPieza(new Piramide(2),270);
    tablero[7][3].ponerPieza(new Piramide(1),180);
    tablero[7][4].ponerPieza(new Piramide(1),90);

    tablero[6][5].ponerPieza(new Piramide(1),180);
    tablero[7][6].ponerPieza(new Piramide(2),90);

    tablero[3][7].ponerPieza(new Obelisco(2),0);
    tablero[4][7].ponerPieza(new Faraon(2),0);
    tablero[5][7].ponerPieza(new Obelisco(2),0);

    tablero[2][7].ponerPieza(new Piramide(2),0);

    tablero[4][4].ponerPieza(new Anubis(2),0);
    tablero[5][4].ponerPieza(new Anubis(2),90);
    
    Pieza piezaLaser2 = new Esfinge(2,juego);
    juego.laserJugador2(piezaLaser2);
    tablero[9][7].ponerPieza(piezaLaser2,90);
  }

  boolean salio(int pposX, int pposY) {
    return(pposX > cantFilas*tamCelda || pposX < 0 || pposY > cantCols*tamCelda || pposY < 0);
  }

  void seleccionarPieza(Pieza ppieza) {
    if(piezaSeleccionada != null) {
      piezaSeleccionada.deseleccionar();
    }
    piezaSeleccionada = ppieza;
    piezaSeleccionada.seleccionar();
  }
  
  void resetear(){
    for(int i=0; i<cantFilas;i++) {
      for(int j=0; j<cantCols;j++) {
        Celda celda = tablero[i][j];
        celda.quitarPieza();
      }
    }
  }
  
  void stop(){
    explosion.close();
  }
}

