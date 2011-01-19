class MiniLaser {
  int posXIni, posYIni, posXFin, posYFin;
  int pX, pY;
  String dir;
  boolean estaCompleto;

  MiniLaser(int pposXIni, int pposYIni, String pdir) {
    posXIni = pposXIni;
    posYIni = pposYIni;
    pX = posXIni;
    pY = posYIni;
    dir = pdir;
    estaCompleto = false;
  }

  void dibujar() {
    stroke(255,0,0);
    strokeWeight(5);

    if(!estaCompleto) {
      calcularDireccion();
      line(posXIni,posYIni,pX,pY);
    }
    else {
      line(posXIni,posYIni,posXFin,posYFin);
    }
    //println(pX + "--" + pY);
  }

  void calcularDireccion() {
    if(dir == "N") {
      pY--;
    }
    if(dir == "S") {
      pY++;
    }
    if(dir == "E") {
      pX++;
    }
    if(dir == "O") {
      pX--;
    }
  }

  void completo() {
    estaCompleto = true;
    posXFin = pX;
    posYFin = pY;
  }
}

