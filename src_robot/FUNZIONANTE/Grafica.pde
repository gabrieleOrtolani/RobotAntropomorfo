void drawBall(){
  
  noStroke();
  fill(ballCol);
  translate(Ball[0],Ball[1]-15,Ball[2]-c0h/2-a0z);
  sphere(30);
  translate(-Ball[0],-Ball[1],-Ball[2]+c0h/2+a0z);
  stroke(strokeCol);
}



void drawRobot(){
  
  /* L0 (base) */
  fill(linkCol);
  translate(0, 0, zFloor/2+a0z/2);
  box(a0x, a0y, a0z);
  translate((-a0x/2)+(b0x/2), 0, a0z/2+b0z/2);
  box(b0x, b0y, b0z);
  translate(b0x/2+c0r+crOffset0, 0, chOffset0/2);
  drawCylinder(90, c0r, c0r, c0h);

  drawBall();

  /* DRAW AXYS L0 */
  pushMatrix();
  translate(0, 0, -c0h/2-a0z); // mi sposto per disegnare gli assi
  drawAxis(1000);
  popMatrix();



  /* Gear1 */
  fill(#16B969);
  translate(0, 0, c0h/2+g1h/2);
  rotateZ((-theta[0]+rad(90))); // -----------> Rotazione 1
  drawGear(g1s, g1h, 10);



  /* L1 (base ruotabile) */
  translate(0, 0, g1h/2+c1h/2);
  drawCylinder(90, c1r, c1r, c1h);
  translate(0, 0, a1h/2+c1h/2);
  box(a1l, a1l, a1h);
  translate(a1l/2, a1l/2+g21h/2, 0);
  rotateY(rad(90));
  rotateX(rad(-90));
  rotateZ(-theta[1]-rad(10));
  drawGear(g21s, g21h, 20);  // ingranaggio sul box grosso
  rotateZ(theta[1]+rad(10));
  translate(0, a1l, -a1l/2-g21h/2);
  drawCylinder(90, c1r2, c1r2, c1h2); // cilidro dietro
  translate(0, -a1l, 0);
  box(2*c1r3, 2*c1r3, c1h3);
  translate(0, -c1r3, 0);
  drawCylinder(90, c1r3, c1r3, c1h3); // cilidro davanti



  /* DRAW AXYS L1 */
  pushMatrix();
  rotateZ(rad(180));
  drawAxis(500);
  popMatrix();
  


  /* Gear2 */
  rotateZ((-theta[1]+rad(90))); // -----------> Rotazione 2 (in realtà rotateY)
  drawGear(g2s, g2h, 20); // attuato dal gear g12s
  translate(0, 0, -g2h/2-a2z/2);
  drawCylinder(90, c2r1, c2r1, c2h);



  /* L2 (braccio) */
  translate(-a2x/2, 0, 0);
  box(a2x, a2y, a2z);
  translate(-a2x/2, 0, 0);
  drawCylinder(90, c2r1, c2r1, c2h);



  /* Gear3 */
  translate(0, 0, g3h/2 + c2h/2);
  drawGear(g3s, g3h, 20);
  translate(0, 0, GAP);
  
  
  
  /* DRAW AXYS L2 */
  pushMatrix();
  rotateZ(rad(90));
  drawAxis(500);
  popMatrix();

  
  
  /* DRAW AXYS L3 */
  rotateZ(-theta[2]+rad(90));  // -----------> Rotazione 3
  pushMatrix();
  rotateY(rad(-90));
  drawAxis(500);
  popMatrix();



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



  /* Gear motore1 */
  pushMatrix();
  translate(a3x-sqrt(2)*g3s/2-sqrt(2)*g3s2/2, 0, -(-g3h/2+a3z/2)); //lasciare cosi 34/42
  drawCylinder(90, c3r2, c3r2, c3h2);
  rotateZ(theta[2]*0.8);
  drawGear(g3s2, g3h2, 24);
  rotateZ(-theta[2]*0.8);
  popMatrix();



  /* Gear motore2 */
  translate(0, 0, -(-g3h/2+a3z/2));
  rotateY(rad(90));
  drawCylinder(90, c3r3, c3r3, c3h3);
  box(a3x2, a3y2, a3z2);



  /* Gear4 */
  translate(0, 0, -g3h3/2);
  rotateZ(theta[3]);  // -----------> Rotazione 4
  drawGear(g3s3, g3h3, 20);



  /* L4 (braccio3) */
  translate(0, 0, -c3r);
  drawCylinder(90, c4r, c4r, c4h);
  rotateY(rad(-90));
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
  
  
  
  /* L5 (sfera) */
  translate(0, 0, c4r);
  rotateZ(rad(90));
  rotateZ(-theta[4]);    // -----------> Rotazione 5
  noStroke();
  sphere(s5);
  stroke(strokeCol);
  rotateX(rad(90));
  
  
  
  /* DRAW AXYS L4 */  
  pushMatrix();
  rotateX(rad(-90));
  rotateZ(rad(-90));
  drawAxis(500);
  popMatrix();

  
  
  /* DRAW AXYS L5 */  
  pushMatrix();
  rotateX(rad(180));
  rotateZ(rad(-90));
  drawAxis(500);
  popMatrix();  
  
  
  
  translate(0,0,-c4r);
  rotateZ(theta[5]);  // -----------> Rotazione 6
  drawGear(c4r/2,c4r*2, 20);
  translate(0,0,-c4r);



  /* DRAW AXYS L6 */
  pushMatrix();
  rotateX(rad(180));
  rotateZ(rad(-90));
  drawAxis(500);
  popMatrix();
}



void drawAxis(float lineLenght) {
  strokeWeight(4); //ricorda-->4
  
  stroke(0, 255, 0);
  fill(0, 255, 0);
  
  pushMatrix();
  line(0, 0, 0, lineLenght, 0, 0); // y = green
  translate(lineLenght, 0, 0);
  rotateY(rad(90));
  drawCylinder(30, 15, 0, 30);
  popMatrix();
  
  stroke(255, 0, 0);
  fill(255, 0, 0);
 
  pushMatrix();
  line(0, 0, 0, 0, lineLenght, 0); // x = red
  translate(0, lineLenght, 0);
  rotateX(rad(-90));
  drawCylinder(30, 15, 0, 30);
  popMatrix();
  
  stroke(0, 0, 255);
  fill(0, 0, 255);
  
  pushMatrix();
  line(0, 0, 0, 0, 0, lineLenght); // z = blue
  translate(0, 0, lineLenght);
  drawCylinder(30, 15, 0, 30);
  popMatrix();
  
  strokeWeight(strokeVar);
  stroke(strokeCol);
  fill(linkCol);
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



/* funzione che disegna cilindri/coni */
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
