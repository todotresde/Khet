class Piramide extends Pieza {

  Piramide(int ptipo) {
    super(ptipo);
  }

  Piramide(int pposX, int pposY) {
    super(pposX,pposY);
  }

  Piramide(int pposX, int pposY, int prot) {
    super(pposX,pposY,prot);
  }

  void definirImagen() {    
    imageMode(CENTER);
    imagenPieza = loadImage("piramide.png");
  }
  
}

