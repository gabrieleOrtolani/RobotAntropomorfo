//float eyeY;

// general variables for stroke 
int strokeVar;
int strokeCol;
int gearCol;
int linkCol;

//rotation angle Y-axis
float alpha  = 0;
float beta = 0;
float[] q = new float[6]; //DEBUG

// floor coordinates
float xFloor = 3200;
float yFloor = 2200;
float zFloor = 10;


// x,y,z window
float xBase;
float yBase;
float zBase;

// L0 (base)

// a = rettangoloBase
float a0x = 420;
float a0y = 320;
float a0z = 35;

//b = rettangolo
float b0x = a0x-a0y;
float b0y = a0y;
float b0z = 215;

// c = cilindro
float chOffset0 = 20;
float crOffset0 = 20;
float c0r = a0y/2-crOffset0;  //raggio cilindro
float c0h = b0z+chOffset0;  // altezza cilindro


// G1

//gear
float g1s = c0r; //diametro
float g1h = 30; //altezza

// cilindro sopra il G1
float c1r = c0r+crOffset0;  //raggio cilindro
float c1h = g1h/2;  // altezza cilindro


// L1

// box
float a1l = (2*c1r)/sqrt(2);
float a1h = 3*a1l/4;

//cilindro posteriore
float c1r2 = a1h/2;
float c1h2 = a1l;

//cilindro anteriore
float c1r3 = 3*c1r2/4;
float c1h3 = c1h2;

// box anteriore servito a coprire il cilindro anteriore
// lato = 2*c1r3

//ingranaggio 1 esterno "attuato da ingranaggio 2"
float g2s = 0.8*c1r3; //diametro
float g2h = c1h2 + c1r3/2; //altezza

//ingranaggio 2 interno
float g21s = g2s;            //diametro
float g21h = (g2h-c1h3)/2;   //altezza



// L2

//cilindri estremi di L2
float c2r1 = c1r2*0.9;
float c2h = g1h;

//braccio 2
float a2x  = 700;
float a2y = 2*c2r1;
float a2z = 30;

//GEAR3
//cilindro di giunto

float c2r2 = c1r3;
float c2h2 = c1h3/2 + a2z;


//ingranaggio

float g3h = c2h2+(g2h-c1h3);
float g3s = g2s;

//L3

float a3x  = 700;
float a3y = 2*c2r2;
float a3z = 30;
 









/*  SETUP  */

void setup() {
  // create window
  fullScreen(P3D);

  strokeVar=2;
  strokeCol= #FFFFFF;

  stroke(strokeCol);
  strokeWeight(strokeVar);

  // x,y,z base 
  xBase = width/2;
  zBase = -width/2; //per centrare
  yBase = -1000;

 
  gearCol = #AFAFAF;
  linkCol = #EA9A18;

  smooth();

  /* DEBUG ANGOLI INIZIALI */
  for (int i=0; i<6; i++) {
    q[i] = 0;
  }
}










/*  DRAW  */

void draw() {
  
  background(40);
  lights();  
  
  // camera((width/2.0), height/2 - eyeY, (height/2.0) / tan(PI*60.0 / 360.0), width/2.0, height/2.0, 0, 0, 1, 0);
  if (mousePressed) {
    xBase = mouseX;
    zBase = -mouseY;
  }

  /* ENV CONTROL */
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
    if(key == '0') {
       beta -= rad(1); 
    }
    /* END ENV CONTROL*/
    
    /* ANGLE CONTROL */
    if (key == '1') {
      q[1] += rad(30);
    }
    if (key == '2') {
      q[2] -= rad(30);
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
      beta = 0;

      xBase = width/2;
      zBase = -width/2;
      yBase = 0;

      for (int i=0; i<6; i++) {
        q[i] = 0;
      }
    }
  }
  /* END ANGLE CONTROL */
  
  
  /* PRINTING */
  textSize(20);
  /*
  text
  text
  text
  */
  /* END PRINTING */


  /* SETTING ENV */
  rotateX(rad(90));

  /* FLOOR */
  fill(#858B77);
  translate(xBase, yBase, zBase);
  rotateZ(alpha);
  rotateX(beta);
  box(xFloor, yFloor, zFloor);

  /*  L0 (base) */
  
  // a0
  fill(linkCol);
  translate(0, 0, zFloor/2+a0z/2);
  box(a0x, a0y, a0z);  
  
  // b0
  translate((-a0x/2)+(b0x/2), 0, a0z/2+b0z/2);
  box(b0x, b0y, b0z);  
  
  // c0
  translate(b0x/2+c0r+crOffset0, 0, chOffset0/2);
  //stroke(#EA9A18);
  drawCylinder(90, c0r, c0r, c0h);  

  /* DRAW AXYS L0*/
  pushMatrix();
  translate(0, 0, -c0h/2-a0z);       // mi sposto per disegnare gli assi
  drawAxis(1000);
  popMatrix();

  /* Gear1 */
  fill(#16B969);
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
  

  translate(a1l/2, a1l/2+g21h/2, 0);
  rotateY(rad(90));
  rotateX(rad(-90));
  
  rotateZ(rad(-q[2])-rad(10));
  drawGear(g21s,g21h,20);  // ingranaggio sul box grosso
  rotateZ(rad(+q[2])+rad(10));
  
  translate(0,a1l,-a1l/2-g21h/2);
  drawCylinder(90, c1r2, c1r2, c1h2); // cilidro davanti
  translate(0, -a1l, 0);
  box(2*c1r3, 2*c1r3, c1h3);
  translate(0, -c1r3, 0);
  drawCylinder(90, c1r3, c1r3, c1h3); // cilidro davanti
  
  
  
  rotateZ(rad(q[2])); // rotazione 2 (in realtà rotateY)
  
  drawGear(g2s,g2h,20); // attuato dal gear g12s
  translate(0,0,-g2h/2-15);
  drawCylinder(90, c2r1, c2r1, c2h);
  
  
  //braccio L2
  translate(-a2x/2,0,0);
  box(a2x,a2y,a2z);
  
  //Cilindro finale
  translate(-a2x/2,0,0);
  drawCylinder(90, c2r1, c2r1, c2h);
  
  
  
  //Cilindro giunto per gear3
  translate(0,0,(g2h-c1h3)+c2h2/2);
  drawCylinder(90, c2r2, c2r2, c2h2);
  
  
 //Gear3 
  translate(0,0,a2z/2-(g2h-c1h3)/2);
  drawGear(g3s,g3h,20);
  
  
  rotateZ(rad(q[3]));
  
  //braccio3
  translate(-a3x/2,0,g3h/2-a3z);
  box(a3x,a3y,a3z);
  
  
  
  
  
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
