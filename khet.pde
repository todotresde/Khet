import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Pantalla pantallaInicial;
Minim minim;
  
void setup(){
  size(500,400,P3D);
  minim = new Minim(this);
  pantallaInicial = new Pantalla();  
}

void draw(){
  background(200);
  pantallaInicial.dibujar();
}

void mousePressed(){
  pantallaInicial.click();
}

void keyPressed(){
  pantallaInicial.press();
}

void stop(){
  pantallaInicial.stop();
  minim.stop(); 
  super.stop();
}

