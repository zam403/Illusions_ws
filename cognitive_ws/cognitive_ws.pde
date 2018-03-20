/*

 Completar la información para cada ilusión implementada
 
 Ilusión 1: Scintillating Grid 
 Author: Rupert Russell, October 2, 2010
 Implementado desde cero, adaptado o transcripción literal: Transcripción literal
 del código encontrado acá: https://www.openprocessing.org/sketch/26605
 Etiquetas (que describen la ilusión, como su categoría, procedencia, etc.): ilusión psicológica, rejilla, Hermann

 Ilusión 2: Color Gradient
 Author: Sergio Cabezas, Febrero 24, 2016
 Implementado desde cero
 Etiquetas: ilusión fisiológica, gradiente, grises
 
 Ilusión 3: Reverse Spoke Ilusion
 Author: Sergio Cabezas, Febrero 26, 2016
 Implementado desde cero
 Etiquetas: Reverse, grises, Ilusión de movimiento
 
 Ilusión 4:  Hinton's Lilac Chaser
 Author: Sergio Cabezas, Febrero 26, 2016
 Implementado desde cero
 Etiquetas: Lilac´s Chaser, Hinton
 
 Ilusión 5: Munker-White Illusion
 Author: Sergio Cabezas, Febrero 26, 2016
 Implementado dede cero
 Etiquietas: Munker-White, trasfondo, ilusión cognitiva
 
 Ilusión 6: Motion Binding
 Author: Sergio Cabezas, Febrero 26, 2016
 Implementado dede cero
 Etiquetas: Cuadrilateros, ilusión de movimiento, lineas por par
 
 Ilusión 7: Bulging Checkerboard
 Author: Sergio Cabezas, Febrero 26, 2016
 Implementado desde cero
 Etiquetas: Tablero de ajedrez, acombamiento, ilusión geométrica 
 */

int illusions = 7;
int current = 1;
boolean active = true;
float spinStep = 2*PI/width;
float spin = 0;
float invLilacDot = 0;

void setup() {
  size(800, 600, P2D);
  frameRate(8);
  //smooth(32);
}

void draw() {
  background(255);
  pushStyle();
  switch(current) {
  case 1:
    scintillating();
    break;
    // implement from here. Don't forget to add break for each case
  case 2:
    setGradient();
    break;
    
  case 3:
    spiralGradient();
    break;
    
  case 4:
    lilacChaser();
    break;
    
  case 5:
    munkerWhite();
    break;
    
  case 6:
    motionBinding();
    break; 
    
  case 7:
    bulgingCheck();
    break;
    //println("implementation is missed!");
  }
  
  popStyle();
}

// switch illusion using the spacebar
void keyPressed() {
  if (key == ' ')
    current = current < illusions ? current+1 : 1;
  if (key == 'a')
    active = !active;
}

// illusions
void scintillating() {
  background(0);          // black background

  //style
  strokeWeight(3);        // medium weight lines 
  smooth();               // antialias lines
  stroke(100, 100, 100);  // dark grey colour for lines

  int step = 25;          // grid spacing

  //vertical lines
  for (int x = step; x < width; x = x + step) {
    line(x, 0, x, height);
  }

  //horizontal lines
  for (int y = step; y < height; y = y + step) {
    line(0, y, width, y);
  }

  // Circles
  if (active) {
    ellipseMode(CENTER);
    stroke(255, 255, 255);  // white circles
    for (int i = step; i < width -5; i = i + step) {
      for (int j = step; j < height -15; j = j + step) {
        strokeWeight(6); 
        point(i, j);
        strokeWeight(3);
      }
    }
  }
}

void setGradient() {
/*
  noFill();
  
  // Left to right gradient
  if(active){
  for (int i = 0; i <= width; i++)
   {
    float inter = map(i, 0, width, 0, 1);
    color c = lerpColor(color(255), color(0), inter);
    stroke(c);
    line(i, 0, i, height);
   }
  }
    
  //Central grey bar  
  for(int var = (height/2)-20; var <= (height/2)+20; var++)
    {
      stroke(192);
      line(70, var, width - 70, var);
    }
    */
    rect(0,0,width, height);
    
    if(active){
      pushMatrix();
      beginShape(QUADS);
      fill(255);
      vertex(0,0);
      vertex(0,height);
      fill(0);
      vertex(width,height);
      vertex(width,0);
      endShape(CLOSE);
      popMatrix();
    }
    
    noStroke();
    fill(192);
    rect(70, (height/2)-20, width - 140, 40);
}

void spiralGradient()
{
  background(180);
  translate(width/2, height/2);
  smooth();
  float rad = width/4 - 2;
  for(float i = 0; i<=width/2; i++)
  {
    strokeWeight(3);
    float step = map(i, 0, width/2, 0, 1);
    color c = lerpColor(color(255), color(0), step);
    stroke(c);
    float par = map(i, 0, width/2, 0, PI);
    line(cos(par+(8*spin))*rad, sin(par+(8*spin))*rad, 0, 0);
    line(cos(-par+(8*spin))*rad, sin(-par+(8*spin))*rad, 0, 0);
    //arc(width/2, height/2, width/2, height/2, PI, TWO_PI);
  }
  spin = active == true ? spin+=spinStep : spin;
  stroke(128);
  strokeWeight(2);
  for(int i=0; i<7; i++)
  {
    float par = map(i, 0, 7, 0, PI);
    line(cos(par)*rad, sin(par)*rad, -cos(par)*rad, -sin(par)*rad);    
  }
  stroke(180);
  noFill();
  ellipse(0, 0 , width/2, width/2);
}

void lilacChaser()
{
  float dist = width/4;
  background(240);
  //smooth();
  translate(width/2, height/2);
  line(-8, -8, 8, 8);
  line(8, -8, -8, 8);
  for(int i=0; i<12; i++)
  {
    float par = map(i, 0, 12, 0, TWO_PI);
    if (i != invLilacDot)
    {
      //stroke(255, 129, 243);
      noStroke();
      fill(255, 129, 243);
      ellipse(cos(par)*dist, sin(par)*dist, 20, 20);
      for(int j=10; j<30; j++)
      {
        float colorStep = map(j, 10, 30, 0, 1);
        color c = lerpColor(color(255, 118, 242), color(255), colorStep);
        stroke(c);
        noFill();
        ellipse(cos(par)*dist, sin(par)*dist, 2*j, 2*j);
        
      }
    }
  }
  invLilacDot = active == true ? (++invLilacDot)%12 : invLilacDot;
}

void munkerWhite()
{
  background(255);
  float barHeight = height/36;
  float barWidth = width/7;
  for(int i=0; i<36; i++)
  {
    if(i%2==0 && active==true)
    {
      stroke(0);
      fill(0);
      rect(0, i*barHeight, width, barHeight);
    } 
    else if(i%2!=0)
    {
      fill(0, 255, 0);
      stroke(0, 255, 0);
      rect(4*barWidth, i*barHeight+1, 2*barWidth, barHeight);
    }
    if(i%2==0)
    {
      fill(0, 255, 0);
      stroke(0, 255, 0);
      rect(barWidth, i*barHeight, 2*barWidth, barHeight);
    }
  }
  
}

void motionBinding()
{
  background(170);  
  translate(width/2, 0);
  rotate(PI/4);
  rectMode(CORNERS);
  stroke(0, 0, 255);
  strokeWeight(8);
  noFill();
  rect((cos(10*spin)*30)+50, (sin(10*spin)*30)+50, (cos(10*spin)*30)+(50+(height/2-100)), (sin(10*spin)*30)+(50+(height/2-100)));
  spin = spin+=spinStep;
  
  rectMode(CORNER);
  noStroke();
  
  if(active!=true)
    fill(0, 255, 0);
  else
    fill(170);
  
  rect(0, 0, 100, 100);
  rect(height/2-100, 0, 100, 100);
  rect(0, height/2-100, 100, 100);
  rect(height/2-100, height/2-100, 100, 100);
}

void bulgingCheck()
{
  background(200);
  float squareSize = width/10;
  float dotSize = squareSize/4;
  color black = color(0);
  color white = color(255);
  boolean isBlack = false;
  noStroke();
  translate(height/4, width/4);
  for(int i=0; i<5; i++)
  {
    for(int j=0; j<5; j++)
    {
      if(i%2==0 && j%2==0)
      {
        fill(white);
        isBlack = false;
      }
      else if(i%2!=0 && j%2!=0)
      {
        fill(white);
        isBlack = false;
      }
      else
      {
        fill(black);
        isBlack = true;
      }
      rect(i*squareSize, j*squareSize, squareSize, squareSize);
      
      if(active && (i==j && i!=2))
      {
        fill(black);
        rect(i*squareSize+1, j*squareSize+(3*dotSize-1), dotSize, dotSize);
        rect(i*squareSize+(3*dotSize-1), j*squareSize+1, dotSize, dotSize);
      }
      
      if(active && (i+j==4 && i!=2))
      {
        fill(black);
        rect(i*squareSize+1, j*squareSize+1, dotSize, dotSize);
        rect(i*squareSize+(3*dotSize-1), j*squareSize+(3*dotSize-1), dotSize, dotSize);
      }
      
      if(active && (i==2 && j<2))
      {
        fill(white);
        if (!isBlack)
          fill(black);
        rect(i*squareSize+1, j*squareSize+(3*dotSize-1), dotSize, dotSize);
        rect(i*squareSize+(3*dotSize-1), j*squareSize+(3*dotSize-1), dotSize, dotSize);
      }
      
      if(active && (i==2 && j>2))
      {
        fill(white);
        if (!isBlack)
          fill(black);
        rect(i*squareSize+1, j*squareSize+1, dotSize, dotSize);
        rect(i*squareSize+(3*dotSize-1), j*squareSize+1, dotSize, dotSize);
      }
      
      if(active && (j==2 && i<2))
      {
        fill(white);
        if (!isBlack)
          fill(black);
        rect(i*squareSize+(3*dotSize-1), j*squareSize+1, dotSize, dotSize);
        rect(i*squareSize+(3*dotSize-1), j*squareSize+(3*dotSize-1), dotSize, dotSize);
      }
      
      if(active && (j==2 && i>2))
      {
        fill(white);
        if (!isBlack)
          fill(black);
        rect(i*squareSize+1, j*squareSize+1, dotSize, dotSize);
        rect(i*squareSize+1, j*squareSize+(3*dotSize-1), dotSize, dotSize);
      }
      
      if(active && (j+i==1 || j+i==7))
      {
        fill(white);
        if (!isBlack)
          fill(black);
        rect(i*squareSize+(3*dotSize-1), j*squareSize+1, dotSize, dotSize);
        rect(i*squareSize+1, j*squareSize+(3*dotSize-1), dotSize, dotSize);
      }
      
      if(active && (abs(j-i)==3))
      {
        fill(white);
        if (!isBlack)
          fill(black);
        rect(i*squareSize+1, j*squareSize+1, dotSize, dotSize);
        rect(i*squareSize+(3*dotSize-1), j*squareSize+(3*dotSize-1), dotSize, dotSize);
      }
    }
  }
}