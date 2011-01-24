import processing.core.*; 
import processing.xml.*; 

import ddf.minim.*; 
import ddf.minim.signals.*; 
import ddf.minim.analysis.*; 
import ddf.minim.effects.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class khet extends PApplet {






Pantalla pantallaInicial;
Minim minim;
  
public void setup(){
  size(500,400,P3D);
  minim = new Minim(this);
  pantallaInicial = new Pantalla();  
}

public void draw(){
  background(200);
  pantallaInicial.dibujar();
}

public void mousePressed(){
  pantallaInicial.click();
}

public void keyPressed(){
  pantallaInicial.press();
}

public void stop(){
  pantallaInicial.stop();
  minim.stop(); 
  super.stop();
}

class Anubis extends Pieza {

  Anubis(int ptipo) {
    super(ptipo);
  }

  Anubis(int pposX, int pposY) {
    super(pposX,pposY);
  }

  Anubis(int pposX, int pposY, int prot) {
    super(pposX,pposY,prot);
  }

  public void definirImagen() {    
    imageMode(CENTER);
    imagenPieza = loadImage("anubis.png");
  }
  
  public String direccion(String pdir) {
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

class Boton{
   String texto;
   int posX, posY, tamX, tamY, fontSize;
   PFont font;
   
   
   Boton(String ptexto,int pposX,int pposY){
     font = loadFont("Purisa-Bold-32.vlw");
     texto = ptexto;
     posX = pposX;
     posY = pposY;
     fontSize = 20;
     tamX = round(textWidth(texto)) * 2;
     tamY = fontSize;
   }
   
   public void dibujar(){
     textFont(font, fontSize); 
     text(texto, posX, posY);
   }
   
   public boolean click(){
     return(posX < mouseX && posX+tamX > mouseX && posY-tamY < mouseY && posY > mouseY);
   }

}
class Celda {
  Pieza pieza;
  int posX, posY, tam, posXTablero, posYTablero, tipoCelda;
  PImage imagenCelda;

  Celda(int pposX, int pposY, int ptam) {
    posXTablero = pposX;
    posYTablero = pposY;
    posX = pposX * ptam;
    posY = pposY * ptam;
    tam = ptam;
    tipoCelda = 0;
    definirImagen();
  }

  Celda(int pposX, int pposY, int ptam, int ptipoCelda) {
    posXTablero = pposX;
    posYTablero = pposY;
    posX = pposX * ptam;
    posY = pposY * ptam;
    tam = ptam;
    tipoCelda = ptipoCelda;
    definirImagen();
  }

  public void dibujar() {
    if(pieza == null) {  
      pushMatrix();
      translate(posX+tam/2, posY+tam/2);
      image(imagenCelda, 0, 0, tam, tam);
      popMatrix();
    }
    else {
      pieza.dibujar();
    }
  }

  public void ponerPieza(Pieza ppieza,int prot) {
    pieza = ppieza;
    pieza.setPieza(posXTablero,posYTablero,prot,tam);
  }

  public void quitarPieza() {
    if(pieza != null){
      pieza.quitar();
      pieza = null;
    }
  }

  public boolean click(float pposX, float pposY) {
    return(posX < pposX && posX+tam > pposX && posY < pposY && posY+tam > pposY );
  }

  public void definirImagen() {    
    imageMode(CORNER);
    if(tipoCelda == 0) {
      imagenCelda = loadImage("celda-neutral.png");
    }
    else if(tipoCelda == 1) {
      imagenCelda = loadImage("celda-roja.png");
    }
    else {
      imagenCelda = loadImage("celda-azul.png");
    }
  }
}

class Direcciones {
  String [] direcciones = new String [4]; 

  Direcciones() {
    direcciones[0] = "N";
    direcciones[1] = "S";
    direcciones[2] = "E";
    direcciones[3] = "O";
  }
}

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
  
  public void definirImagen() {    
    imageMode(CENTER);
    imagenPieza = loadImage("faraon.png");
  }
  
  public String direccion(String pdir) { 
    return "";
  }
}

class Juego{
  Laser laserJugador1,laserJugador2;
  Tablero tablero;
  Pieza piezaSeleccionada;
  int turnoJugador;
  
  Juego(){
    tablero = new Tablero();
    laserJugador1 = new Laser(tablero.tamCelda/2,0,"S",this);
    laserJugador2 = new Laser(tablero.cantFilas * tablero.tamCelda - tablero.tamCelda/2,tablero.cantCols * tablero.tamCelda,"N",this);
    turnoJugador = 1;
  }
  
  public void dibujar(){
    tablero.dibujar();
    
    laserJugador1.dibujar(tablero);
    laserJugador2.dibujar(tablero);
  }
  
  public void click(){
    piezaSeleccionada = tablero.click();
  }
  
  public void press(){
    if(key == 's' || key == 'S' ){
      dispararLaser();
    }
    
    if(piezaSeleccionada != null){
      if(keyCode == UP){
        tablero.moverPieza(piezaSeleccionada,"N");  
      }
      if(keyCode == DOWN){
        tablero.moverPieza(piezaSeleccionada,"S");  
      }
      if(keyCode == LEFT){
        tablero.moverPieza(piezaSeleccionada,"O");
      }
      if(keyCode == RIGHT){
        tablero.moverPieza(piezaSeleccionada,"E");
      }
      if(key == 'z' || key == 'Z' ){
        piezaSeleccionada.rotar(1);  
      }
      if(key == 'x' || key == 'X' ){
        piezaSeleccionada.rotar(-1);  
      }
      
    }
  }
  
  public void dispararLaser(){
    println("T" + turnoJugador);
    if(turnoJugador == 1){
      laserJugador1.disparar();
    }else{
      laserJugador2.disparar();
    }
  }
  
  public int cambiarTurnoJugador(){
    if(turnoJugador == 1){
      turnoJugador = 2;
    }else{
      turnoJugador = 1;
    }
    return turnoJugador;
  }
  
  public void iniciar(int tipoJuego){
    tablero.resetear();
    if(tipoJuego == 1){
      tablero.configuracion1();
    }
  }
  
  public void stop(){
    laserJugador1.stop();
    laserJugador2.stop();
    tablero.stop();
  }
  
}
class Laser {
  MiniLaser [] miniLasers;
  int cantMiniLasers, actualMiniLaser;
  int posX, posY;
  boolean disparar;
  Tablero tablero;
  String originalDir;
  Juego juego;

  AudioPlayer laser;

  Laser(int pposX, int pposY, String pdir, Juego pjuego) {
    miniLasers = new MiniLaser[1000];
    disparar = false;
    agregarMiniLaser(pposX,pposY,pdir);
    originalDir = pdir;
    posX = pposX;
    posY = pposY;
    juego = pjuego;

    laser = minim.loadFile("laser.wav");
  }

  public int dibujar(Tablero ptablero) {
    Pieza pieza;
    Pieza ultimaPieza = null;
    tablero = ptablero;

    if(disparar) {
      for(int i=0; i<cantMiniLasers;i++) {
        miniLasers[i].dibujar();
      }

      for(int i=0; i<cantMiniLasers;i++) {

        pieza = ptablero.hayPieza(miniLasers[i].pX,miniLasers[i].pY);
        if((!miniLasers[i].estaCompleto && pieza!=ultimaPieza) || (ptablero.salio(miniLasers[i].pX,miniLasers[i].pY))) {          
          println(i + "---" + pieza);
          if(pieza != null) {
            if(pieza.rebotaLaser(miniLasers[i].dir)) {
              rebote(pieza.direccion(miniLasers[i].dir));
              ultimaPieza = pieza;
              return 1;
            }
            else {
              ptablero.quitarPieza(pieza);
              limpiarLaser();
              juego.cambiarTurnoJugador();
              return 1;
            }
          }
          else {
            if(ptablero.salio(miniLasers[i].pX,miniLasers[i].pY)) {
              limpiarLaser();
              juego.cambiarTurnoJugador();
              println("Fin Turno");
              return 1;
            }
          }
        }
      }
    }
    
    return 1;
  }

  public void agregarMiniLaser(int pposX, int pposY, String dir) {
    MiniLaser miniLaser = new MiniLaser(pposX,pposY,dir);
    miniLasers[cantMiniLasers] = miniLaser;

    if(cantMiniLasers > 0) {
      miniLasers[cantMiniLasers-1].completo();
    }
    actualMiniLaser = cantMiniLasers;
    cantMiniLasers++;
  }

  public void rebote(String pdir) {
    String [] direcciones = splitTokens(pdir);
    if(direcciones.length == 1) { 
      agregarMiniLaser(miniLasers[cantMiniLasers-1].pX, miniLasers[cantMiniLasers-1].pY, direcciones[0]);
    }
    else {
      agregarMiniLaser(miniLasers[cantMiniLasers-1].pX, miniLasers[cantMiniLasers-1].pY, direcciones[0]);
      agregarMiniLaser(miniLasers[cantMiniLasers-1].pX, miniLasers[cantMiniLasers-1].pY, direcciones[1]);
    }
  }

  public void disparar() {
    disparar = true;
    laser.play(3);
  }

  public void limpiarLaser() {
    for(int i=0; i<cantMiniLasers;i++) {
      miniLasers[i] = null;
    }

    disparar = false;
    cantMiniLasers = 0;
    actualMiniLaser = 0;
    
    agregarMiniLaser(posX,posY,originalDir);
  }
  
  public void stop(){
    laser.close();
  }
}

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

  public void dibujar() {

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
    //println(pX + "--" + pY);
  }

  public void calcularDireccion() {
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

  public void completo() {
    estaCompleto = true;
    posXFin = pX;
    posYFin = pY;
  }
}

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
  
  public void definirImagen() {    
    imageMode(CENTER);
    imagenPieza = loadImage("obelisco.png");
  }
  
  public String direccion(String pdir) { 
    return "";
  }
}

class Pantalla {
  PFont font;
  Boton botonJ1, botonJ2, botonReglas, botonCreditos, botonVolver;
  boolean activoBotonJ1, activoBotonJ2, activoBotonReglas, activoBotonCreditos, activoBotonVolver;
  Juego juego;

  Pantalla() {
    font = loadFont("Purisa-Bold-32.vlw");
    botonJ1 = new Boton("1 Jugador",200, 230);
    botonJ2 = new Boton("2 Jugadores",200, 260);
    botonReglas = new Boton("Reglas",200, 290);
    botonCreditos = new Boton("Creditos",200, 320);
    botonVolver = new Boton("Volver", 400, 370);

    resetearEstadoBotones();
    juego = new Juego();
  }

  public void dibujar() {
    if(activoBotonJ1) {
      pantalla2();
    }
    else if(activoBotonJ2) {
      juego.dibujar();
    }
    else if(activoBotonReglas) {
      pantalla3();
    }
    else if(activoBotonCreditos) {
      pantalla4();
    }

    else {
      pantalla1();
    }
  }

  public void click() {
    if(!activoBotonJ2) {
      if(botonJ1.click()) {
        activoBotonJ1 = true;
      }
      if(botonJ2.click()) {
        activoBotonJ2 = true;
        juego.iniciar(1);
      }
      if(botonReglas.click()) {
        activoBotonReglas = true;
      }
      if(botonCreditos.click()) {
        activoBotonCreditos = true;
      }
      if(botonVolver.click()) {
        resetearEstadoBotones();
        activoBotonVolver = true;
      }
    }
    else {
      juego.click();
    }
  }

  public void press() {
    if(activoBotonJ2 && ((key == 'r') || (key == 'R'))) {
      resetearEstadoBotones();
    }
    else { 
      if(activoBotonJ2) {
        juego.press();
      }
    }
  }

  public void pantalla1() {
    tituloJuego();
    botonJ1.dibujar();
    botonJ2.dibujar();
    botonReglas.dibujar();
    botonCreditos.dibujar();
  }

  public void pantalla2() {
    tituloJuego();
    textFont(font, 20); 
    text("Se ve que no tenes muchos amigos y queres jugar solo. Mejor buscate mas amigos y juga de a dos!!", 50, 150,450,200);
    botonVolver.dibujar();
  }

  public void pantalla3() {
    tituloJuego();
    textFont(font, 15); 
    text("* Con la 'S' dispara el laser.",50,150);
    textFont(font, 15);
    text("* Con el mouse se selecciona la ficha.", 50, 190);
    textFont(font, 15);
    text("* Con 'Z' y 'X' se rota la ficha.", 50, 230);
    textFont(font, 15);
    text("* Con las flechas del teclado se mueve la ficha.", 50, 270, 450, 400);
    textFont(font, 15);
    text("* Con la 'R' durante el juego, vuelve al menu principal.", 50, 310, 450, 400);
    botonVolver.dibujar();
  }

  public void pantalla4() {
    tituloJuego();
    textFont(font, 20); 
    text("Creditos!!!!", 50, 150,450,400);
    botonVolver.dibujar();
  }

  public void tituloJuego() {
    textFont(font, 52); 
    text("Khet", 150, 80);
  }

  public void resetearEstadoBotones() {
    activoBotonJ1 = false;
    activoBotonJ2 = false;
    activoBotonReglas = false;
    activoBotonCreditos = false;
    activoBotonVolver = false;
  }
  
  public void stop(){
    juego.stop();
  }
}

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

  public void setPieza(int pposX, int pposY, int prot, int ptam) {
    posXTablero = pposX;
    posYTablero = pposY;
    posX = pposX * ptam;
    posY = pposY * ptam;
    rot = prot;
    tam = ptam;
    definirCentro();
    definirImagen();
    
    if(seleccionada){ 
      audioMoverPieza.play(1);
    }
  }

  public void dibujar() {
      
    noStroke();
    pushMatrix();
    translate(posX+tam/2, posY+tam/2);
    rotate(radians(rot));
    image(imagenPieza, 0, 0, tam, tam);
    setColor();
    popMatrix();
    
  }
  
  public void setColor(){
    if(tipo == 1){
      if(!seleccionada){
        fill(0,0,255,100);
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

  public String direccion(String pdir) {
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
  
  public boolean rebotaLaser(String pdir){
    return (direccion(pdir) != "");
  }

  public void definirCentro() {
    centroX = posX + round(tam/2);
    centroY = posY + round(tam/2);
  }

  public void definirImagen() {    
    imageMode(CENTER);
    imagenPieza = loadImage("piramide.png");
  }

  public boolean centro(int pposX, int pposY) {
    return (pposX == centroX && pposY == centroY);
  }

  public void mover(String pdir) {
    
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

  public void rotar(int sentido) {
    rot = rot + sentido * 90;
    if(rot == 360) {
      rot = 0;
    }
    if(rot == -90) {
      rot = 270;
    }
  }
  
  public void seleccionar(){
     seleccionada = true;
  }
  
  public void deseleccionar(){
    seleccionada = false;
  }
  
  public void quitar(){
    stop();
  }
  
  public void definirAudio(){
    audioMoverPieza = minim.loadFile("pieza.wav");
  }
  
  public void stop(){
    //audioMoverPieza.close();
  }
}

class Piramide extends Pieza {

  Piramide(int ptipo) {
    super(ptipo);
  }

  Piramide(int pposX, int pposY) {
    super(pposX,pposY);
  }

  Piramide(int pposX, int pposY, int prot) {
    super(pposX,pposY,prot);
  }

  public void definirImagen() {    
    imageMode(CENTER);
    imagenPieza = loadImage("piramide.png");
  }
}

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

  public void definirImagen() {    
    imageMode(CENTER);
    imagenPieza = loadImage("ra.png");
  }
  
  public String direccion(String pdir) {
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

class Tablero {
  Celda [][] tablero;
  int cantFilas = 10;
  int cantCols = 8;
  int tamCelda = 50;
  Pieza piezaSeleccionada;
  
  AudioPlayer explosion;

  Tablero() {
    tablero = new Celda [cantFilas][cantCols];

    for(int i=0; i<cantFilas;i++) {
      for(int j=0; j<cantCols;j++) {
        tablero[i][j] = new Celda(i,j,tamCelda);
      }
    }
    explosion = minim.loadFile("explosion.wav");
  }

  public void dibujar() {
    for(int i=0; i<cantFilas;i++) {
      for(int j=0; j<cantCols;j++) {
        tablero[i][j].dibujar();
      }
    }
  }

  public Pieza hayPieza(int pposX, int pposY) {
    for(int i=0; i<cantFilas;i++) {
      for(int j=0; j<cantCols;j++) {
        Celda celda = tablero[i][j];
        Pieza pieza = celda.pieza;

        if(pieza != null) {
          if(pieza.centro(pposX,pposY)) {
            return pieza;
          }
        }
      }
    }
    return null;
  }

  public Pieza click() {
    for(int i=0; i<cantFilas;i++) {
      for(int j=0; j<cantCols;j++) {
        Celda celda = tablero[i][j];
        if(celda.click(mouseX,mouseY)) {
          if(celda.pieza != null){
            seleccionarPieza(celda.pieza);
            return piezaSeleccionada;
          }
        }
      }
    }
    return null;
  }

  public void moverPieza(Pieza ppieza, String pdir) {
    Celda celda = tablero[ppieza.posXTablero][ppieza.posYTablero];
    println(ppieza.posXTablero + " " + ppieza.posYTablero);
    if(pdir == "N") {
      if(celda.posYTablero > 0 && tablero[ppieza.posXTablero][ppieza.posYTablero-1].pieza == null) {
        tablero[ppieza.posXTablero][ppieza.posYTablero].quitarPieza();
        tablero[ppieza.posXTablero][ppieza.posYTablero-1].ponerPieza(ppieza,ppieza.rot);
      }
    }

    if(pdir == "S") {
      if(celda.posYTablero < cantCols-1 && tablero[ppieza.posXTablero][ppieza.posYTablero+1].pieza == null) {
        tablero[ppieza.posXTablero][ppieza.posYTablero].quitarPieza();
        tablero[ppieza.posXTablero][ppieza.posYTablero+1].ponerPieza(ppieza,ppieza.rot);
      }
    }

    if(pdir == "E") {
      if(celda.posXTablero < cantFilas-1 && tablero[ppieza.posXTablero+1][ppieza.posYTablero].pieza == null) {
        tablero[ppieza.posXTablero][ppieza.posYTablero].quitarPieza();        
        tablero[ppieza.posXTablero+1][ppieza.posYTablero].ponerPieza(ppieza,ppieza.rot);
      }
    }

    if(pdir == "O") {
      if(celda.posXTablero > 0 && tablero[ppieza.posXTablero-1][ppieza.posYTablero].pieza == null) {
        tablero[ppieza.posXTablero][ppieza.posYTablero].quitarPieza();
        tablero[ppieza.posXTablero-1][ppieza.posYTablero].ponerPieza(ppieza,ppieza.rot);
      }
    }
  }

  public void quitarPieza(Pieza ppieza) {
    tablero[ppieza.posXTablero][ppieza.posYTablero].quitarPieza();
    explosion.play(1);
  }

  public void configuracion1() {
    tablero[0][3].ponerPieza(new Piramide(1),90);
    tablero[0][4].ponerPieza(new Piramide(1),180);
    tablero[2][3].ponerPieza(new Piramide(2),270);
    tablero[2][4].ponerPieza(new Piramide(2),0);

    tablero[2][1].ponerPieza(new Piramide(1),270);
    tablero[3][2].ponerPieza(new Piramide(2),0);

    tablero[4][0].ponerPieza(new Obelisco(1),180);
    tablero[5][0].ponerPieza(new Faraon(1),180);
    tablero[6][0].ponerPieza(new Obelisco(1),180);

    tablero[7][0].ponerPieza(new Piramide(1),180);

    tablero[4][3].ponerPieza(new Anubis(1),90);
    tablero[5][3].ponerPieza(new Anubis(1),0);

    tablero[9][3].ponerPieza(new Piramide(2),0);
    tablero[9][4].ponerPieza(new Piramide(2),270);
    tablero[7][3].ponerPieza(new Piramide(1),180);
    tablero[7][4].ponerPieza(new Piramide(1),90);

    tablero[6][5].ponerPieza(new Piramide(1),180);
    tablero[7][6].ponerPieza(new Piramide(2),90);

    tablero[3][7].ponerPieza(new Obelisco(2),0);
    tablero[4][7].ponerPieza(new Faraon(2),0);
    tablero[5][7].ponerPieza(new Obelisco(2),0);

    tablero[2][7].ponerPieza(new Piramide(2),0);

    tablero[4][4].ponerPieza(new Anubis(2),0);
    tablero[5][4].ponerPieza(new Anubis(2),90);
  }

  public boolean salio(int pposX, int pposY) {
    return(pposX > cantFilas*tamCelda || pposX < 0 || pposY > cantCols*tamCelda || pposY < 0);
  }

  public void seleccionarPieza(Pieza ppieza) {
    if(piezaSeleccionada != null) {
      piezaSeleccionada.deseleccionar();
    }
    piezaSeleccionada = ppieza;
    piezaSeleccionada.seleccionar();
  }
  
  public void resetear(){
    for(int i=0; i<cantFilas;i++) {
      for(int j=0; j<cantCols;j++) {
        Celda celda = tablero[i][j];
        celda.quitarPieza();
      }
    }
  }
  
  public void stop(){
    explosion.close();
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#DFDFDF", "khet" });
  }
}
