//float eyeY;

int strokeVar;
int strokeCol;
int gearCol;
int linkCol;
//rotation angle Y-axis
float alpha  = 0;
float[] q = new float[6]; //DEBUG

// coordinate floor
float xFloor = 3200;
float yFloor = 2200;
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


// gear 1
float g1s = c0r; //diametro
float g1h = 30; //altezza

// link1

float c1r = c0r+crOffset0;  //raggio cilindro
float c1h = g1h/2;  // altezza cilindro

float a1l = (2*c1r)/sqrt(2);
float a1h = 3*a1l/4;

float c1r2 = a1h/2;
float c1h2 = a1l;

float c1r3 = 3*c1r2/4;
float c1h3 = c1h2;

float g2s = c1r3; //diametro
float g2h = c1h2 + c1r3/2; //altezza














void setup() {
  fullScreen(P3D);


  strokeVar=2;
  strokeCol= #FFFFFF;

  stroke(strokeCol);
  strokeWeight(strokeVar);

  xBase = width/2;
  zBase = -width/2;
  yBase = 0;

  gearCol = #AFAFAF;
  linkCol = #EA9A18;

  smooth();

  /* DEBUG ANGOLI INIZIALI */
  for (int i=0; i<6; i++) {
    q[i] = 0;
  }
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

    /*DEBUG*/
    if (key == '1') {
      q[1] += rad(30);
    }
    if (key == '2') {
      q[2] += rad(30);
    }
    if (key == '3') {
      q[3] += rad(30);
    }
    if (key == '4') {
      q[4] += rad(30);
    }
    if (key == '5') {
      q[5] += rad(30);
    }
    if (key == '6') {
      q[6] += rad(30);
    }
    // q=reset
    if (key == 'q') {
      alpha = 0;

      xBase = width/2;
      zBase = -width/2;
      yBase = 0;

      for (int i=0; i<6; i++) {
        q[i] = 0;
      }
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
  box(xFloor, yFloor, zFloor);

  /* BASE(link0) */
  fill(linkCol);
  translate(0, 0, zFloor/2+a0z/2);
  box(a0x, a0y, a0z);  // First box

  translate((-a0x/2)+(b0x/2), 0, a0z/2+b0z/2);
  box(b0x, b0y, b0z);  // Second box

  translate(b0x/2+c0r+crOffset0, 0, chOffset0/2);
  //stroke(#EA9A18);
  drawCylinder(90, c0r, c0r, c0h);  // Cylinder

  /* DRAW AXYS */
  pushMatrix();
  translate(0, 0, -c0h/2-a0z);       // mi sposto per disegnare gli assi
  drawAxis(1000);
  popMatrix();

  /* Gear1 */
  //fill(#16B969);
  translate(0, 0, c0h/2+g1h/2);

  rotateZ(rad(q[1])); // rotazione 1

  drawGear(g1s, g1h, 10);
  //base cilindrica
  translate(0, 0, g1h/2+c1h/2);
  drawCylinder(90, c1r, c1r, c1h);
  //corpo link
  translate(0, 0, a1h/2+c1h/2);
  box(a1l, a1l, a1h);
  drawAxis(500);

  translate(-a1l/2, 0, 0);
  rotateY(rad(90));
  rotateX(rad(-90));
  drawCylinder(90, c1r2, c1r2, c1h2); // cilidro davanti
  translate(0, -a1l, 0);
  box(g2h-c1h3, c1h3, c1h3);
  translate(0, -c1r3, +g2h-c1h3);
  drawCylinder(90, c1r3, c1r3, c1h3); // cilidro davanti
  
  rotateZ(rad(q[2])); // rotazione 2 (in realtà rotateY)
  
  drawGear(g2s,g2h,10);
  rotateY(rad(-90));
  rotateX(rad(90));
  
  
}








void drawAxis(float lineLenght) {
  strokeWeight(4);
  stroke(255, 0, 0);
  line(0, 0, 0, lineLenght, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, lineLenght, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, lineLenght);
  strokeWeight(strokeVar);
  stroke(strokeCol);
}












// Convertitore da gradi a radianti
float rad(float degree) {
  return degree * PI/180.0;
}










void drawGear(float side, float h, int nGear) {
  fill(gearCol);
  int angle = floor(360/nGear);
  for (int i = 0; i<nGear; i++) {

    box(side, side, h);
    rotateZ(rad(angle));
  }
  fill(linkCol);
  //stroke(255);
  //strokeWeight(strokeVar);
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
  noStroke();
  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i < sides + 1; i++) {
    float x1 = cos( radians( i * angle ) ) * r1;
    float y1 = sin( radians( i * angle ) ) * r1;
    float x2 = cos( radians( i * angle ) ) * r2;
    float y2 = sin( radians( i * angle ) ) * r2;
    vertex( x1, y1, -halfHeight);
    vertex( x2, y2, halfHeight);
  }
  stroke(strokeCol);
  endShape(CLOSE);
}
