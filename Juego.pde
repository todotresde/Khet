class Juego{
  Laser laserJugador1,laserJugador2;
  Tablero tablero;
  Pieza piezaSeleccionada;
  int turnoJugador;
  
  Juego(){
    tablero = new Tablero();
    laserJugador1 = new Laser(15,0,"S",this);
    laserJugador2 = new Laser(tablero.cantFilas * tablero.tamCelda - 15,tablero.cantCols * tablero.tamCelda,"N",this);
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
      if(key == 'r' || key == 'R' ){
        piezaSeleccionada.rotar();  
      }
      
    }
  }
  
  void dispararLaser(){
    println("T" + turnoJugador);
    if(turnoJugador == 1){
      laserJugador1.disparar();
    }else{
      laserJugador2.disparar();
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
  
}
