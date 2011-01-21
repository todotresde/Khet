class Ra extends Pieza {

  Ra(int ptipo) {
    super(ptipo);
  }

  Ra(int pposX, int pposY) {
    super(pposX,pposY);
  }

  Ra(int pposX, int pposY, int prot) {
    super(pposX,pposY,prot);
  }

  void definirImagen() {    
    imageMode(CENTER);
    imagenPieza = loadImage("ra.png");
  }
  
  String direccion(String pdir) {
    if(pdir == "S") {
      if(rot == 0 || rot == 180) {
        return "S O";
      }
      else{
        return "S E";
      }
    }

    if(pdir == "N") {
      if(rot == 180 || rot == 0) {
        return "N E";
      }
      else{
        return "N O";
      }
    }

    if(pdir == "O") {
      if(rot == 90 || rot == 270) {
        return "O N";
      }
      else{
        return "O S";
      }
    }

    if(pdir == "E") {
      if(rot == 90 || rot == 270) {
        return "E S";
      }
      else {
        return "E N";
      }
    }

    return "";
  }
}

