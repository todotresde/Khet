Juego juego;

void setup(){
  size(500,500,P3D);
  juego = new Juego();
}

void draw(){
  background(200);
  juego.dibujar();
}

void mousePressed(){
  juego.click();
}

void keyPressed(){
  juego.press();
}
