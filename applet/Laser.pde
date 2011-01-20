class Laser {
  MiniLaser [] miniLasers;
  int cantMiniLasers, actualMiniLaser;
  int posX, posY;
  boolean disparar;
  Tablero tablero;
  String originalDir;
  Juego juego;

  Laser(int pposX, int pposY, String pdir, Juego pjuego) {
    miniLasers = new MiniLaser[1000];
    disparar = false;
    agregarMiniLaser(pposX,pposY,pdir);
    originalDir = pdir;
    posX = pposX;
    posY = pposY;
    juego = pjuego;
  }

  void dibujar(Tablero ptablero) {
    tablero = ptablero;
    if(disparar) {
      for(int i=0; i<cantMiniLasers;i++) {
        miniLasers[i].dibujar();
      }

      Pieza pieza = ptablero.hayPieza(miniLasers[actualMiniLaser].pX,miniLasers[actualMiniLaser].pY);
      if(pieza != null) {
        if(pieza.rebotaLaser(miniLasers[actualMiniLaser].dir)){
          rebote(pieza.direccion(miniLasers[actualMiniLaser].dir));
        }else{
          ptablero.quitarPieza(pieza);
          limpiarLaser();
          juego.cambiarTurnoJugador();
        }
      }else{
        if(ptablero.salio(miniLasers[actualMiniLaser].pX,miniLasers[actualMiniLaser].pY)){
          limpiarLaser();
          juego.cambiarTurnoJugador();
          println("Fin Turno");  
        }
      }
    }
    
    
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
    agregarMiniLaser(miniLasers[cantMiniLasers-1].pX, miniLasers[cantMiniLasers-1].pY, pdir);
  }
  
  void disparar(){
    disparar = true;
  }
  
  void limpiarLaser(){
    for(int i=0; i<cantMiniLasers;i++) {
        miniLasers[i] = null;
    }
    
    disparar = false;
    cantMiniLasers = 0;
    actualMiniLaser = 0;
    
    agregarMiniLaser(posX,posY,originalDir);
  }
}

