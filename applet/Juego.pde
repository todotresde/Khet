class Juego{
  Tablero tablero;
  Pieza piezaSeleccionada,piezaLaserJugador1,piezaLaserJugador2;
  int turnoJugador;
  
  Juego(){
    tablero = new Tablero(this);
    turnoJugador = 1;
  }
  
  void dibujar(){
    tablero.dibujar();
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
    println("T" + turnoJugador);
    
    if(turnoJugador == 1){
      piezaLaserJugador1.disparar();
    }else{
      piezaLaserJugador2.disparar();
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
  
  void laserJugador1(Pieza ppieza){
    piezaLaserJugador1 = ppieza;
  }
  
  void laserJugador2(Pieza ppieza){
    piezaLaserJugador2 = ppieza;
  }
  
  void stop(){
    /*
    laserJugador1.stop();
    laserJugador2.stop();
    */
    tablero.stop();
  }
  
}
