//float eyeY;
//rotation angle Y-axis
float alpha  = 0;

// coordinate floor
float xFloor = 1200;
float yFloor = 800;
float zFloor = 10;

// coordinate del sistema di riferimento della finestra
float xBase;
float yBase;
float zBase;

// base
// a = rettangoloBase, b = rettangolo, c = cilindro
float a0x = 420;
float a0y = 320;
float a0z = 35;

float b0x = a0x-a0y;
float b0y = a0y;
float b0z = 215;


float chOffset0 = 20;
float crOffset0 = 20;
float c0r = a0y/2-crOffset0;  //raggio cilindro
float c0h = b0z+chOffset0;  // altezza cilindro


// link 1
float x = 100;
float y = 100;
float z = 100;

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
  /*
  text
  text
  text
  */
  
  
  /* SETTING ENV */
  rotateX(rad(90));
  
  /* FLOOR */
  fill(#858B77);
  translate(xBase, yBase, zBase);
  rotateZ(alpha);
  box(xFloor,yFloor,zFloor);
 
  /* BASE(link0) */
  fill(#EA9A18);  
  translate(0,0,zFloor/2+a0z/2);
  box(a0x,a0y,a0z);  // First box
  
  translate((-a0x/2)+(b0x/2),0,a0z/2+b0z/2);
  box(b0x,b0y,b0z);  // Second box
  
  translate(b0x/2+c0r+crOffset0,0,chOffset0/2);  
  stroke(#EA9A18);
  drawCylinder(60,c0r,c0r,c0h);  // Cylinder
  
  /* DRAW AXYS */
  pushMatrix();
  translate(0,0,-c0h/2-a0z);       // mi sposto per disegnare gli assi
  drawAxis(500);
  stroke(255);
  strokeWeight(2);
  popMatrix();
  
  /* NAME(link1) */
  fill(#16B969);
  translate(0,0,c0h/2+50);
  box(x,y,z);
  rotateZ(rad(60));
  box(x,y,z);
  rotateZ(rad(60));
  box(x,y,z);
  rotateZ(rad(60));
  box(x,y,z);
  rotateZ(rad(60));
  box(x,y,z);
  rotateZ(rad(60));
  box(x,y,z);
  rotateZ(rad(60));
  
  
  
  
  
  
  
  
  
  
}
void drawAxis(float lineLenght){
   strokeWeight(4);
   stroke(255,0,0);
   line(0,0,0,lineLenght,0,0);
   stroke(0,255,0);
   line(0,0,0,0,lineLenght,0);
   stroke(0,0,255);
   line(0,0,0,0,0,lineLenght);
   
   
  
}
// Convertitore da gradi a radianti
float rad(float degree) {
  return degree * PI/180.0;
}

//funzione che disegna cilindri/coni
void drawCylinder( int sides, float r1, float r2, float h)
{
    float angle = 360 / sides;
    float halfHeight = h / 2;
    // top
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r1;
        float y = sin( radians( i * angle ) ) * r1;
        vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);
    // bottom
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r2;
        float y = sin( radians( i * angle ) ) * r2;
        vertex( x, y, halfHeight);
    }
    endShape(CLOSE);
    // draw body
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x1 = cos( radians( i * angle ) ) * r1;
        float y1 = sin( radians( i * angle ) ) * r1;
        float x2 = cos( radians( i * angle ) ) * r2;
        float y2 = sin( radians( i * angle ) ) * r2;
        vertex( x1, y1, -halfHeight);
        vertex( x2, y2, halfHeight);
    }
    endShape(CLOSE);
}
