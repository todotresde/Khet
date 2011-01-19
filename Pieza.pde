class Pieza {
  int posX, posY, rot, posXTablero, posYTablero;
  int centroX, centroY;
  int tam;
  PImage imagenPieza;
  int tipo;
  
  Pieza(int ptipo) {
    tipo = ptipo;
    definirImagen();
  }

  Pieza(int pposX, int pposY) {
    posXTablero = pposX;
    posYTablero = pposY;
    posX = pposX * 50;
    posY = pposY * 50;
    definirCentro();
    definirImagen();
  }

  Pieza(int pposX, int pposY, int prot) {
    posXTablero = pposX;
    posYTablero = pposY;
    posX = pposX * 50;
    posY = pposY * 50;
    rot = prot;
    definirCentro();
    definirImagen();
  }

  void setPieza(int pposX, int pposY, int prot, int ptam) {
    posXTablero = pposX;
    posYTablero = pposY;
    posX = pposX * ptam;
    posY = pposY * ptam;
    rot = prot;
    tam = ptam;
    definirCentro();
    definirImagen();
  }

  void dibujar() {
    
    noStroke();
     /*
     fill(0,255,0);
     rect(posX+1,posY+1,tam-2,tam-2);
     
     pushMatrix();
     translate(posX, posY);
     rotate(radians(rot));
     stroke(0,0,0);
     strokeWeight(2);
     line(0,tam,tam,0);
     popMatrix();
     */
    
    pushMatrix();
    translate(posX+tam/2, posY+tam/2);
    rotate(radians(rot));
    image(imagenPieza, 0, 0, tam, tam);
    setColor();
    popMatrix();
    
  }
  
  void setColor(){
    if(tipo == 1){
      fill(0,0,255,100);
    }else{
      fill(255,0,0,100);
    }
    rect(-tam/2,-tam/2,tam,tam);
  }

  String direccion(String pdir) {
    if(pdir == "S") {
      if(rot == 0) {
        return "O";
      }
      else if(rot == 90) {
        return "E";
      }
    }

    if(pdir == "N") {
      if(rot == 180) {
        return "E";
      }
      else if(rot == 270) {
        return "O";
      }
    }

    if(pdir == "O") {
      if(rot == 90) {
        return "N";
      }
      else if(rot == 180) {
        return "S";
      }
    }

    if(pdir == "E") {
      if(rot == 270) {
        return "S";
      }
      else if(rot == 0) {
        return "N";
      }
    }

    return "";
  }
  
  boolean rebotaLaser(String pdir){
    return (direccion(pdir) != "");
  }

  void definirCentro() {
    centroX = posX + round(tam/2);
    centroY = posY + round(tam/2);
  }

  void definirImagen() {    
    imageMode(CENTER);
    imagenPieza = loadImage("piramide.png");
  }

  boolean centro(int pposX, int pposY) {
    //println(rot+"---"+pposX+"---"+centroX+"---"+pposY+"---"+centroY);
    return (pposX == centroX && pposY == centroY);
  }

  void mover(String pdir) {
    if(pdir == "N"){
      setPieza(posX,posY-1,rot,tam);
    }
    if(pdir == "S"){
      setPieza(posX,posY+1,rot,tam);
    }
    if(pdir == "E"){
      setPieza(posX+1,posY,rot,tam);
    }
    if(pdir == "O"){
      setPieza(posX-1,posY,rot,tam);
    }
  }

  void rotar() {
    rot += 90;
    if(rot == 360) {
      rot = 0;
    }
  }
  
}
