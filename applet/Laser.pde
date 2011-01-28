class Laser {
  MiniLaser [] miniLasers;
  int cantMiniLasers, actualMiniLaser;
  int posX, posY;
  boolean disparar;
  Tablero tablero;
  String originalDir;
  Juego juego;

  AudioPlayer laser;

  Laser(int pposX, int pposY, String pdir, Juego pjuego) {
    miniLasers = new MiniLaser[1000];
    disparar = false;
    agregarMiniLaser(pposX,pposY,pdir);
    juego = pjuego;
    setLaser(pposX,pposY,pdir);
    laser = minim.loadFile("laser.wav");
  }
  
  void setLaser(int pposX, int pposY, String pdir){
    originalDir = pdir;
    posX = pposX + juego.tablero.tamCelda/2;
    posY = pposY + juego.tablero.tamCelda/2;
  }

  int dibujar(Tablero ptablero) {
    Pieza pieza;
    Pieza ultimaPieza = null;
    tablero = ptablero;

    if(disparar) {
      for(int i=0; i<cantMiniLasers;i++) {
        miniLasers[i].dibujar();
      }

      for(int i=0; i<cantMiniLasers;i++) {

        pieza = ptablero.hayPieza(miniLasers[i].pX,miniLasers[i].pY);
        if((!miniLasers[i].estaCompleto && pieza!=ultimaPieza) || (ptablero.salio(miniLasers[i].pX,miniLasers[i].pY))) {          
          println(i + "---" + pieza);
          if(pieza != null) {
            if(pieza.rebotaLaser(miniLasers[i].dir)) {
              rebote(pieza.direccion(miniLasers[i].dir));
              ultimaPieza = pieza;
              return 1;
            }
            else {
              ptablero.quitarPieza(pieza);
              limpiarLaser();
              juego.cambiarTurnoJugador();
              return 1;
            }
          }
          else {
            if(ptablero.salio(miniLasers[i].pX,miniLasers[i].pY)) {
              limpiarLaser();
              juego.cambiarTurnoJugador();
              println("Fin Turno");
              return 1;
            }
          }
        }
      }
    }
    
    return 1;
  }

  void agregarMiniLaser(int pposX, int pposY, String dir) {
    MiniLaser miniLaser = new MiniLaser(pposX,pposY,dir);
    miniLasers[cantMiniLasers] = miniLaser;

    if(cantMiniLasers > 0) {
      miniLasers[cantMiniLasers-1].completo();
    }
    actualMiniLaser = cantMiniLasers;
    cantMiniLasers++;
  }

  void rebote(String pdir) {
    String [] direcciones = splitTokens(pdir);
    if(direcciones.length == 1) { 
      agregarMiniLaser(miniLasers[cantMiniLasers-1].pX, miniLasers[cantMiniLasers-1].pY, direcciones[0]);
    }
    else {
      agregarMiniLaser(miniLasers[cantMiniLasers-1].pX, miniLasers[cantMiniLasers-1].pY, direcciones[0]);
      agregarMiniLaser(miniLasers[cantMiniLasers-1].pX, miniLasers[cantMiniLasers-1].pY, direcciones[1]);
    }
  }

  void disparar() {
    disparar = true;
    laser.play(3);
  }

  void limpiarLaser() {
    for(int i=0; i<cantMiniLasers;i++) {
      miniLasers[i] = null;
    }

    disparar = false;
    cantMiniLasers = 0;
    actualMiniLaser = 0;
    
    agregarMiniLaser(posX,posY,originalDir);
  }
  
  void stop(){
    laser.close();
  }
}

