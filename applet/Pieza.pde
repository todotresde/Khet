class Pieza {
  int posX, posY, rot, posXTablero, posYTablero;
  int centroX, centroY;
  int tam;
  PImage imagenPieza;
  int tipo;
  boolean seleccionada;
  Juego juego;

  //AudioPlayer audioMoverPieza;

  Pieza(int ptipo) {
    tipo = ptipo;
    definirImagen();
    //definirAudio();
  }
  
  Pieza(int ptipo,Juego pjuego) {
    tipo = ptipo;
    juego = pjuego;
    definirImagen();
    //definirAudio();
  }

  Pieza(int pposX, int pposY) {
    setPieza(pposX,pposY);
  }
  
  Pieza(int pposX, int pposY, Juego pjuego) {
    juego = pjuego;
    setPieza(pposX,pposY);
  }

  Pieza(int pposX, int pposY, int prot, Juego pjuego) {
    juego = pjuego;
    rot = prot;
    setPieza(pposX,pposY);
  }

  Pieza(int pposX, int pposY, int prot) {
    rot = prot;
    setPieza(pposX,pposY);
  }

  void setPieza(int pposX, int pposY) {
    posXTablero = pposX;
    posYTablero = pposY;
    posX = pposX * 50;
    posY = pposY * 50;
    definirCentro();
    definirImagen();
    //definirAudio();
  }
  
  void setPieza(int pposX, int pposY, int prot, int ptam) {
    rot = prot;
    tam = ptam;

    setPieza(pposX,pposY);

    if(seleccionada) { 
      //audioMoverPieza.play();
    }
  }

  void dibujar() {
    noStroke();
    pushMatrix();
    translate(posX+tam/2, posY+tam/2);
    rotate(radians(rot));
    image(imagenPieza, 0, 0, tam, tam);
    setColor();
    popMatrix();
  }

  void setColor() {
    if(tipo == 1) {
      if(!seleccionada) {
        fill(0,0,255,100);
      }
      else {
        fill(0,255,255,100);
      }
    }
    else {
      if(!seleccionada) {
        fill(255,0,0,100);
      }
      else {
        fill(255,255,0,100);
      }
    }
    rect(-tam/2,-tam/2,tam,tam);
  }

  String direccion(String pdir) {
    String direccion = "";

    if(pdir == "S") {
      if(rot == 0) {
        direccion = "O";
      }
      else if(rot == 90) {
        direccion = "E";
      }
    }

    if(pdir == "N") {
      if(rot == 180) {
        direccion = "E";
      }
      else if(rot == 270) {
        direccion = "O";
      }
    }

    if(pdir == "O") {
      if(rot == 90) {
        direccion = "N";
      }
      else if(rot == 180) {
        direccion = "S";
      }
    }

    if(pdir == "E") {
      if(rot == 270) {
        direccion = "S";
      }
      else if(rot == 0) {
        direccion = "N";
      }
    }

    return direccion;
  }

  boolean rebotaLaser(String pdir) {
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
    return (pposX == centroX && pposY == centroY);
  }

  void mover(String pdir) {

    if(pdir == "N") {
      setPieza(posX,posY-1,rot,tam);
    }
    if(pdir == "S") {
      setPieza(posX,posY+1,rot,tam);
    }
    if(pdir == "E") {
      setPieza(posX+1,posY,rot,tam);
    }
    if(pdir == "O") {
      setPieza(posX-1,posY,rot,tam);
    }
    println("XXX: " + posX + " YYY: " + posY);
  }

  void rotar(int sentido) {
    rot = rot + sentido * 90;
    if(rot == 360) {
      rot = 0;
    }
    if(rot == -90) {
      rot = 270;
    }
  }

  void seleccionar() {
    seleccionada = true;
  }

  void deseleccionar() {
    seleccionada = false;
  }

  void quitar() {
    stop();
  }

  void definirAudio() {
    //if(audioMoverPieza == null){
    //  audioMoverPieza = minim.loadFile("pieza.wav");
    //}
  }

  void stop() {
    //audioMoverPieza.close();
  }
  
  void disparar(){}
  
  int setDirToDegree(String pdir){
    if(pdir == "O") {
      return 0;
    }
    if(pdir == "E") {
      return 180;
    }
    if(pdir == "N") {
      return 90;
    }
    if(pdir == "S") {
      return 270;
    }
    return 0;
  }
  
  String setDegreeToDir(int pdegree){
    if(pdegree == 0) {
      return "O";
    }
    if(pdegree == 180) {
      return "E";
    }
    if(pdegree == 90) {
      return "N";
    }
    if(pdegree == 270) {
      return "S";
    }
    return "N";
  }
}

