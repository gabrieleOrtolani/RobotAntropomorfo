//float eyeY;

import com.jogamp.opengl.GLProfile;
{
  GLProfile.initSingleton();
}

// general variables for stroke
int strokeVar;
int strokeCol;
int gearCol;
int linkCol;
float[] q = new float[6]; //DEBUG

//rotation angle Y-axis
float alpha  = 0;
float beta = 0;
int segno = -1;


// floor coordinates
float xFloor = 4200;
float yFloor = 3200;
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


float GAP = (g2h-c1h3)/2;


// L2
//braccio 2
float a2x  = 800;
float a2y = 2*0.9*c1r2;
float a2z = 40;
//cilindri estremi di L2
float c2r1 = a2y/2;
float c2h = a2z;


//GEAR3
//cilindro di giunto
float c2r2 = c1r3;
float c2h2 = c1h3/2 + a2z;
//ingranaggio
float g3h = c1h3-(g2h-c1h3)/2;
float g3s = g2s;


//L3
float a3y = 2*c2r2;
float a3x  = a2x/2 - c1r3-a3y ;
float a3z = 20;
//cilindri estremi di L2
float c3r = a3y/2;
float c3h = a3z;
//gear attuante su gear3
float g3h2 = g1h*2;
float g3s2 = g2s*2.1;
//cilindro motore 1
float c3r2 = g3s2*0.5;
float c3h2 = 2*(g3h/2-2*GAP+a3z/2);
//cilindro motore 2
float c3r3 = c3h2/2+a3z/2;
float c3h3 = c3r;
//box per contornare
float a3y2 = a3y;
float a3x2  = 2*(g3h/2-2*GAP+a3z/2)+2;
float a3z2 = c3h3;
//gear attuante su gear4
float g3h3 = 2*c3h3;
float g3s3 = 0.8*c3r3;

//L4
//aggancio per rotazione
float c4r = c3r3*0.7;
float c4h = c3h3*0.7;
//box braccio
float a4y = 0.6*a3y;
float a4x  = 0.7*a3x ;
float a4z = 20;
//cilidri finali
float c4r2 = a4y/2;
float c4h2 = c3h;

//L5
float s5 = c4r-a4z/2;












/*  SETUP  */

void setup() {
  // create window
  
  //String os = osSetup();
  
  //fullScreen(P3D);
  size(1500,1200,P3D);
  strokeVar=1;
  //strokeCol= #FFFFFF;
  strokeCol= #6A4811;

  stroke(strokeCol);
  strokeWeight(strokeVar);

  // x,y,z base
  xBase = width/2;
  zBase = -width/2; //per centrare
  yBase = -1500;


  //gearCol = #AFAFAF;
  linkCol = #EA9A18;
  gearCol= 150;
  //linkCol = #FFED24;

  smooth();

  /* DEBUG ANGOLI INIZIALI */
  //for (int i=0; i<6; i++) {
  //  q[i] = 60;
  //}
}










/*  DRAW  */

void draw() {
  //noStroke();
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
    if (key == '0') {
      beta -= rad(1);
    }
    /* END ENV CONTROL*/

    /* ANGLE CONTROL */
    if (key == '1') {
      q[0] += segno*rad(30);
    }
    if (key == '2') {
      q[1] -= segno*rad(30);
    }
    if (key == '3') {
      q[2] += segno*rad(30);
    }
    if (key == '4') {
      q[3] += segno*rad(30);
    }
    if (key == '5') {
      q[4] += segno*rad(30);
    }
    if (key == '6') {
      q[5] += segno* rad(30);
    }
    if (key == 's') {
      segno = -1*segno;
    }
    // q=reset
    if (key == 'q') {
      alpha = 0;
      beta = 0;

      xBase = width/2;
      zBase = -width/2;
      yBase = -1500;

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
  
  drawRobot(q);

}


void events(){
}


void drawRobot(float[] q){
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




  rotateZ(rad(q[0])); // rotazione 1


  /*  L1 (base ruotabile) */

  drawGear(g1s, g1h, 10);

  //base cilindrica
  translate(0, 0, g1h/2+c1h/2);
  drawCylinder(90, c1r, c1r, c1h);
  //corpo link
  translate(0, 0, a1h/2+c1h/2);
  box(a1l, a1l, a1h);



  translate(a1l/2, a1l/2+g21h/2, 0);
  rotateY(rad(90));
  rotateX(rad(-90));

  rotateZ(rad(-q[2])-rad(10));
  drawGear(g21s, g21h, 20);  // ingranaggio sul box grosso
  rotateZ(rad(+q[2])+rad(10));

  translate(0, a1l, -a1l/2-g21h/2);
  drawCylinder(90, c1r2, c1r2, c1h2); // cilidro davanti
  translate(0, -a1l, 0);
  box(2*c1r3, 2*c1r3, c1h3);
  translate(0, -c1r3, 0);
  drawCylinder(90, c1r3, c1r3, c1h3); // cilidro davanti

  /* DRAW AXYS L1*/

  pushMatrix();
  rotateY(PI);
  rotateZ(-PI/2);
  drawAxis(500);
  popMatrix();


  rotateZ(rad(q[1])); // rotazione 2 (in realtà rotateY)

  /* Gear2 */
  drawGear(g2s, g2h, 20); // attuato dal gear g12s
  translate(0, 0, -g2h/2-a2z/2);
  drawCylinder(90, c2r1, c2r1, c2h);




  /*  L2 (braccio) */

  //braccio L2
  translate(-a2x/2, 0, 0);
  box(a2x, a2y, a2z);

  //Cilindro finale
  translate(-a2x/2, 0, 0);
  drawCylinder(90, c2r1, c2r1, c2h);

  /* Gear3 */

  translate(0, 0, g3h/2 + c2h/2);
  drawGear(g3s, g3h, 20);


  translate(0, 0, GAP);
  /* DRAW AXYS L1*/
  pushMatrix();
  rotateY(PI);
  rotateZ(-PI/2);
  drawAxis(500);
  popMatrix();

  rotateZ(rad(q[2]));


  /*  L3 (braccio2) */

  translate(0, 0, g3h/2-GAP+a3z/2);
  drawCylinder(90, c3r, c3r, c3h);

  translate(0, 0, 2*(-g3h/2+a3z/2));
  drawCylinder(90, c3r, c3r, c3h);

  translate(-a3x/2, 0, 0);
  box(a3x, a3y, a3z);

  translate(0, 0, -2*(-g3h/2+a3z/2));
  box(a3x, a3y, a3z);

  translate(-a3x/2, 0, 0);
  drawCylinder(90, c3r, c3r, c3h);


  translate(0, 0, 2*(-g3h/2+a3z/2));
  drawCylinder(90, c3r, c3r, c3h);

  //draw gear motore1
  pushMatrix();

  translate(a3x-sqrt(2)*g3s/2-sqrt(2)*g3s2/2, 0, -(-g3h/2+a3z/2)); //lasciare cosi 34/42
  drawCylinder(90, c3r2, c3r2, c3h2);

  rotateZ(rad(q[2]*0.7));
  drawGear(g3s2, g3h2, 24);
  rotateZ(-rad(q[2]*0.7));

  popMatrix();
  //end gear motore1

  /*draw gear motore2*/
  translate(0, 0, -(-g3h/2+a3z/2));
  rotateY(PI/2);

  drawCylinder(90, c3r3, c3r3, c3h3);
  box (a3x2, a3y2, a3z2);

  /*end gear motore2*/


  /* Gear4 */
  translate(0, 0, -g3h3/2);
  rotateZ(rad(q[3]));

  drawGear(g3s3, g3h3, 20);

/*  L4 (braccio3) */

  translate(0, 0, -c3r);
  drawCylinder(90, c4r, c4r, c4h);
  
  rotateY(-PI/2);
  
  
  //box(c4r, 2*c4r, c4h);
  translate(0, 0, c4r);
  drawCylinder(90, c4r2, c4r2, c4h2);
  
  translate(0, 0,-2*(c4r));
  drawCylinder(90, c4r2, c4r2, c4h2);
  
  translate(-a4x/2, 0, 0);
  
  box(a4x, a4y, a4z);

  translate(0, 0, 2*c4r);
  box(a4x, a4y, a4z);
  
  
  translate(-a4x/2, 0, 0);
  drawCylinder(90, c4r2, c4r2, c4h2);
  
  translate(0, 0, -2*c4r);
  drawCylinder(90, c4r2, c4r2, c4h2);
  
/*  L5 (sfera) */
  translate(0, 0, c4r);
  rotateZ(rad(q[4])+PI/2);
  noStroke();
  sphere(s5);
  stroke(strokeCol);
  
  rotateX(PI/2);
  translate(0,0,-c4r/2);
  
/* DRAW AXYS L5*/  
  pushMatrix();
  rotateY(PI/2);
  rotateZ(-PI/2);
  drawAxis(500);
  popMatrix();
  
  
  
  rotateZ(rad(q[5]));
  drawGear(c4r*0.5,c4r*2, 20);

/* DRAW AXYS L5*/
  pushMatrix();
  rotateY(PI/2);
  rotateZ(-PI/2);
  drawAxis(500);
  popMatrix();
}








void drawAxis(float lineLenght) {
  strokeWeight(4);
  stroke(255, 0, 0);
  line(0, 0, 0, lineLenght, 0, 0); // x = r
  stroke(0, 255, 0);
  line(0, 0, 0, 0, lineLenght, 0); // y = g
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, lineLenght); // z = b
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
  //noStroke();
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
  //noStroke();
  endShape(CLOSE);
}
