/*

 Completar la información para cada ilusión implementada
 
 Ilusión 8: Spinning Mask Grid 
 Author: Rupert Russell, October 2, 2010
 Implementado desde cero, adaptado o transcripción literal: Transcripción literal
 del código encontrado acá: https://www.openprocessing.org/sketch/26605
 Etiquetas (que describen la ilusión, como su categoría, procedencia, etc.): ilusión psicológica, rejilla, Hermann
 
 */
 
 PShape obj;
 float angle = 0;
 boolean active = true;
 
 void setup(){
   size(800, 600, P3D);
   smooth(4);
   //obj = loadShape("car.obj");
   obj = loadShape("3d-model.obj");
 }
 
 void draw(){
   pushMatrix();
   
   background(128);
   fill(255);
   translate(width/2, height/2);
   if(active)
   directionalLight(255, 255, 255,0,0,-1);
   
   rotateZ(PI);
   rotateY(angle);
   //lights();
   scale(3);
   //stroke(0);
   shape(obj, 0, 0);
   angle += 0.01;
   
   popMatrix();
 }
 
 void keyPressed() {
  if (key == 'a')
    active = !active;
}