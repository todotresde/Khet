class Obelisco extends Pieza {

  Obelisco(int ptipo) {
    super(ptipo);
  }

  Obelisco(int pposX, int pposY) {
    super(pposX,pposY);
  }

  Obelisco(int pposX, int pposY, int prot) {
    super(pposX,pposY,prot);
  }
  
  void definirImagen() {    
    imageMode(CENTER);
    imagenPieza = loadImage("obelisco.png");
  }
  
  String direccion(String pdir) { 
    return "";
  }
  
  boolean remover(String pdir){
    if(pdir == getDireccionOpuesta()){
      return false;
    }
    return true;
  }
}

