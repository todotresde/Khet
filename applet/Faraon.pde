class Faraon extends Pieza {

  Faraon(int ptipo) {
    super(ptipo);
  }

  Faraon(int pposX, int pposY) {
    super(pposX,pposY);
  }

  Faraon(int pposX, int pposY, int prot) {
    super(pposX,pposY,prot);
  }
  
  void definirImagen() {    
    imageMode(CENTER);
    imagenPieza = loadImage("faraon.png");
  }
  
  String direccion(String pdir) { 
    return "";
  }
}

