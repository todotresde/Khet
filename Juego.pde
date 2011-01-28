class Juego{
  Laser laserJugador1,laserJugador2;
  Tablero tablero;
  Pieza piezaSeleccionada;
  int turnoJugador;
  
  Juego(){
    tablero = new Tablero();
    laserJugador1 = new Laser();
    laserJugador2 = new Laser();
    turnoJugador = 1;
  }
  
  void dibujar(){
    tablero.dibujar();
    
    laserJugador1.dibujar(tablero);
    laserJugador2.dibujar(tablero);
  }
  
  void click(){
    piezaSeleccionada = tablero.click();
  }
  
  void press(){
    if(key == 's' || key == 'S' ){
      dispararLaser();
    }
    
    if(piezaSeleccionada != null){
      if(keyCode == UP){
        tablero.moverPieza(piezaSeleccionada,"N");  
      }
      if(keyCode == DOWN){
        tablero.moverPieza(piezaSeleccionada,"S");  
      }
      if(keyCode == LEFT){
        tablero.moverPieza(piezaSeleccionada,"O");
      }
      if(keyCode == RIGHT){
        tablero.moverPieza(piezaSeleccionada,"E");
      }
      if(key == 'z' || key == 'Z' ){
        piezaSeleccionada.rotar(1);  
      }
      if(key == 'x' || key == 'X' ){
        piezaSeleccionada.rotar(-1);  
      }
      
    }
  }
  
  void dispararLaser(){
    if(turnoJugador == 1){
      laserJugador1.disparar(tablero.tamCelda/2,0,"S",this);
    }else{
      laserJugador2.disparar(tablero.cantFilas * tablero.tamCelda - tablero.tamCelda/2,tablero.cantCols * tablero.tamCelda,"N",this);
    }
  }
  
  int cambiarTurnoJugador(){
    if(turnoJugador == 1){
      turnoJugador = 2;
    }else{
      turnoJugador = 1;
    }
    return turnoJugador;
  }
  
  void iniciar(int tipoJuego){
    tablero.resetear();
    if(tipoJuego == 1){
      tablero.configuracion1();
    }
  }
  
  void stop(){
    laserJugador1.stop();
    laserJugador2.stop();
    tablero.stop();
  }
  
}
