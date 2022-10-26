//float eyeY;
//rotation angle Y-axis
float alpha  = 0;

// coordinate floor
float xFloor = 600;
float yFloor = 400;
float zFloor = 10;

// coordinate del sistema di riferimento della finestra
float xBase;
float yBase;
float zBase;

// link 0
// a = quadrato, b = rettangolo, c = cilindro
float a1x = 0;
float a1y = 0;
float a1z = 0;

float b1x = 0;
float b1y = 0;
float b1z = 0;

float c1x = 0;
float c1y = 0;
float c1z = 0;

// link 1


void setup() {
  size(1400, 1000, P3D);
  stroke(255);
  strokeWeight(2);

  xBase = width/2;
  zBase = -width/2;
  yBase = 0;

  smooth();
}

void draw() {
  background(40);
  lights();
  // camera((width/2.0), height/2 - eyeY, (height/2.0) / tan(PI*60.0 / 360.0), width/2.0, height/2.0, 0, 0, 1, 0);

  if (mousePressed) {
    xBase = mouseX;
    zBase = -mouseY;
  }

  if (keyPressed) {
    if (keyCode == RIGHT)
    {
      alpha += rad(1);
    }
    if (keyCode == LEFT)
    {
      alpha -= rad(1);
    }
    if (keyCode == UP)
    {
      yBase += 5;
    }
    if (keyCode == DOWN)
    {
      yBase -= 5;
    }
  }
  //printing
  textSize(20);
  
  
  
  //setting env
  rotateX(rad(90));
  
  //floor
  fill(#5FF256);
  translate(xBase, yBase, zBase);
  rotateZ(alpha);
  box(xFloor, yFloor, zFloor);
 
  // draw axis
  translate(0, 0, zFloor/2+1);
  
  drawAxis(100);
  
  
}
void drawAxis(float lineLenght){
   line(0,0,0,lineLenght,0,0);
   line(0,0,0,0,lineLenght,0);
   line(0,0,0,0,0,lineLenght);
  
}
// Convertitore da gradi a radianti
float rad(float degree) {
  return degree * PI/180.0;
}
