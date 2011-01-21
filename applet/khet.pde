Pantalla pantallaInicial;

void setup(){
  size(500,400,P3D);
  pantallaInicial = new Pantalla();
}

void draw(){
  background(200);
  pantallaInicial.dibujar();
  //juego.dibujar();
}

void mousePressed(){
  pantallaInicial.click();
  //juego.click();
}

void keyPressed(){
  pantallaInicial.press();
  //juego.press();
}
