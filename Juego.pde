class Juego{
  Laser laserJugador1,laserJugador2;
  Tablero tablero;
  Pieza piezaSeleccionada;
  int turnoJugador;
  Esfinge esfingeJugador1,esfingeJugador2;
  
  Juego(){
    tablero = new Tablero();
    laserJugador1 = new Laser();
    laserJugador2 = new Laser();
    turnoJugador = 1;
    esfingeJugador1 = new Esfinge(1);
    esfingeJugador2 = new Esfinge(2);
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
      laserJugador1.disparar(esfingeJugador1,this);
    }else{
      laserJugador2.disparar(esfingeJugador2,this);
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
      tablero.configuracion1(esfingeJugador1,esfingeJugador2);
    }
    if(tipoJuego == 2){
      tablero.configuracion2(esfingeJugador1,esfingeJugador2);
    }
    if(tipoJuego == 3){
      tablero.configuracion3(esfingeJugador1,esfingeJugador2);
    }
  }
  
  void stop(){
    laserJugador1.stop();
    laserJugador2.stop();
    tablero.stop();
  }
  
}
