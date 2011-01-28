class Esfinge extends Pieza {
  Laser laser;
  
  Esfinge(int ptipo, Juego pjuego) {
    super(ptipo,pjuego);
    definirLaser(super.posX,super.posY,pjuego);
  }

  Esfinge(int pposX, int pposY, Juego pjuego) {
    super(pposX,pposY,pjuego);
    definirLaser(pposX,pposY,juego);
  }

  Esfinge(int pposX, int pposY, int prot, Juego pjuego) {
    super(pposX,pposY,prot,pjuego);
    definirLaser(pposX,pposY,juego);
  }

  void definirImagen() {    
    imageMode(CENTER);
    imagenPieza = loadImage("esfinge.png");
  }

  String direccion(String pdir) { 
    return "";
  }

  void dibujar() { 
    laser.setLaser(posX,posY,setDegreeToDir(rot));
    laser.dibujar(juego.tablero);
    super.dibujar();
  }
  
  void definirLaser(int pposX, int pposY, Juego pjuego){
    laser = new Laser(pposX,pposY,setDegreeToDir(rot),pjuego);
  }
  
  void disparar(){
    println("Px" + posX + " - PY" + posY);
    laser.disparar();
  }
  
}

