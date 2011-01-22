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
    String dir = "";
    println("ACA !!!" + pdir + "-"); 
    if(pdir.equals("S")) {
      if(rot == 0 || rot == 180) {
        dir = "S O";
      }
      else{
        dir = "S E";
      }
    }

    if(pdir.equals("N")) {
      if(rot == 180 || rot == 0) {
        dir = "N E";
      }
      else{
        dir = "N O";
      }
    }

    if(pdir.equals("O")) {
      if(rot == 90 || rot == 270) {
        dir = "O N";
      }
      else{
        dir = "O S";
      }
    }

    if(pdir.equals("E")) {
      if(rot == 90 || rot == 270) {
        dir = "E S";
      }
      else {
        dir = "E N";
      }
    }
    println("ACA2 !!!" + rot);
    return dir;
  }
}

