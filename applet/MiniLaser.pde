class MiniLaser {
  int posXIni, posYIni, posXFin, posYFin;
  int pX, pY;
  String dir;
  boolean estaCompleto;
  int velocidad;

  MiniLaser(int pposXIni, int pposYIni, String pdir) {
    posXIni = pposXIni;
    posYIni = pposYIni;
    pX = posXIni;
    pY = posYIni;
    dir = pdir;
    estaCompleto = false;
    velocidad = 5;
  }

  void dibujar() {
    if(!estaCompleto) {
      calcularDireccion();
      stroke(255,0,0,100);
      strokeWeight(5);
      line(posXIni,posYIni,pX,pY);
      stroke(255,0,0);
      strokeWeight(1);
      line(posXIni,posYIni,pX,pY);
    }
    else {
      stroke(255,0,0,100);
      strokeWeight(5);
      line(posXIni,posYIni,posXFin,posYFin);
      stroke(255,0,0);
      strokeWeight(1);
      line(posXIni,posYIni,posXFin,posYFin);
    }
  }

  void calcularDireccion() {
    if(dir == "N") {
      pY-=velocidad;
    }
    if(dir == "S") {
      pY+=velocidad;
    }
    if(dir == "E") {
      pX+=velocidad;
    }
    if(dir == "O") {
      pX-=velocidad;
    }
  }

  void completo() {
    estaCompleto = true;
    posXFin = pX;
    posYFin = pY;
  }
}

