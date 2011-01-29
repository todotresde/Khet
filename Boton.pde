class Boton{
   String texto;
   int posX, posY, tamX, tamY, fontSize;
   PFont font;
   
   
   Boton(String ptexto,int pposX,int pposY){
     font = loadFont("Arial-BoldMT-24.vlw");
     texto = ptexto;
     posX = pposX;
     posY = pposY;
     fontSize = 22;
     tamX = round(textWidth(texto)) * 2;
     tamY = fontSize;
   }
   
   void dibujar(){
     textFont(font, fontSize); 
     text(texto, posX, posY);
   }
   
   boolean click(){
     return(posX < mouseX && posX+tamX > mouseX && posY-tamY < mouseY && posY > mouseY);
   }

}
