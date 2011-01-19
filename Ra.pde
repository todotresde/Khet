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
        return "O";
      }
      else{
        return "E";
      }
    }

    if(pdir == "N") {
      if(rot == 180 || rot == 0) {
        return "E";
      }
      else{
        return "O";
      }
    }

    if(pdir == "O") {
      if(rot == 90 || rot == 270) {
        return "N";
      }
      else{
        return "S";
      }
    }

    if(pdir == "E") {
      if(rot == 90 || rot == 270) {
        return "S";
      }
      else {
        return "N";
      }
    }

    return "";
  }
}

