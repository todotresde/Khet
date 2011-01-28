class Esfinge extends Pieza {

  Esfinge(int ptipo) {
    super(ptipo);
  }

  Esfinge(int pposX, int pposY) {
    super(pposX,pposY);
  }

  Esfinge(int pposX, int pposY, int prot) {
    super(pposX,pposY,prot);
  }
  
  void definirImagen() {    
    imageMode(CENTER);
    imagenPieza = loadImage("esfinge.png");
  }
  
  String direccion(String pdir) { 
    return "";
  }
}

