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
   
   void dibujar(){
     //fill(255,0,0,50);
     //rect(posX,posY-tamY,tamX,tamY);
     textFont(font, fontSize); 
     text(texto, posX, posY);
   }
   
   boolean click(){
     //println(mouseX + "-" + mouseY + ":" + posX + "-" + posY + "-" + (posX+tamX) + "-" + (posY-tamY));
     //println(posX < mouseX && posX+tamX > mouseX && posY-tamY < mouseY && posY > mouseY);
     return(posX < mouseX && posX+tamX > mouseX && posY-tamY < mouseY && posY > mouseY);
   }

}
