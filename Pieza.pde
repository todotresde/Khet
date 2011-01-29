class Pieza {
  int posX, posY, rot, posXTablero, posYTablero;
  int centroX, centroY;
  int tam;
  PImage imagenPieza;
  int tipo;
  boolean seleccionada;
  
  AudioPlayer audioMoverPieza;
  
  Pieza(int ptipo) {
    tipo = ptipo;
    definirImagen();
    definirAudio();
  }

  Pieza(int pposX, int pposY) {
    posXTablero = pposX;
    posYTablero = pposY;
    posX = pposX * 50;
    posY = pposY * 50;
    definirCentro();
    definirImagen();
    definirAudio();
  }

  Pieza(int pposX, int pposY, int prot) {
    posXTablero = pposX;
    posYTablero = pposY;
    posX = pposX * 50;
    posY = pposY * 50;
    rot = prot;
    definirCentro();
    definirImagen();
    definirAudio();
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
    
    if(seleccionada){ 
      audioMoverPieza.play(3);
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
  
  void setColor(){
    if(tipo == 1){
      if(!seleccionada){
        fill(0,0,0,0);
      }else{
        fill(0,255,255,100);
      }
    }else{
      if(!seleccionada){
        fill(255,0,0,100);
      }else{
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

  void rotar(int sentido) {
    rot = rot + sentido * 90;
    if(rot == 360) {
      rot = 0;
    }
    if(rot == -90) {
      rot = 270;
    }
    audioMoverPieza.play(3);
  }
  
  void seleccionar(){
     seleccionada = true;
  }
  
  void deseleccionar(){
    seleccionada = false;
  }
  
  void quitar(){
    stop();
  }
  
  void definirAudio(){
    audioMoverPieza = minim.loadFile("pieza.wav");
  }
  
  void stop(){
    //audioMoverPieza.close();
  }
  
  String getDireccion(){
    if(rot == 0){
      return "O";
    }
    if(rot == 90){
      return "N";
    }
    if(rot == 180){
      return "E";
    }
    if(rot == 270){
      return "S";
    }
    return "";
  }
}

