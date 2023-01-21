/*
  Componenti del gruppo: Andrea Andreoli, Gabriele Ortolani, Gabriele Iacovacci, Simone Arcari;
  
  Manuale d'uso:
    - FRECCIA SU = avvicinarsi al robot 
    - FRECCIA GIU = allontanarsi dal robot
    - FRECCIA SINISTRA = ruotare l'ambiente verso sinistra
    - FRECCIA DESTRA = ruotare l'ambiente verso destra
    - 0 = ruotare l'ambiente verso l'alto
    - s = cambia segno per tutte le vabiabili (x/X, y/Y, z/Z ,k/K etc...)
    - q = per ripristinare il robot e l'interfaccia alla posizione iniziale
    - x/X = varia la x desiderata in base al segno scelto
    - y/Y = varia la y desiderata in base al segno scelto
    - z/Z = varia la z desiderata in base al segno scelto
    - + = imposta gomito alto
    - - = imposta gomito basso
    - a/A = variazione dell'angolo alpha
    - b/B = variazione dell'angolo beta
    - t/T = variazione dell'angolo theta
    - m = modalità cinematica diretta (per DEBUG)
    - c/C = modalità automatica (inseguimento moto pallina)
*/
// per macOS
import com.jogamp.opengl.GLProfile;
{
  GLProfile.initSingleton();
}


/* General variables for stroke/color */
int strokeVar = 1;
int strokeCol = #9D9654;
int gearCol = #A0A0A0;
int ballCol =#EA0CE0;
int linkCol = #FFED24; 
int floorCol = #858B77;



/* Rotation angle Y-axis */
float alpha  = 0;
float beta = 0;
int segno = -1;


/* Floor coordinates */
float xFloor = 4200;
float yFloor = 3200;
float zFloor = 10;


/* Window x,y,z */
float xBase;
float yBase;
float zBase;
float baseDeep = -2500;


/* L0 (base) */
float a0x = 420;              // a = rettangoloBase
float a0y = 320;
float a0z = 35;
float b0x = a0x-a0y;          // b = rettangolo
float b0y = a0y;
float b0z = 215;
float chOffset0 = 20;         // c = cilindro
float crOffset0 = 20;
float c0r = a0y/2-crOffset0;  // raggio cilindro
float c0h = b0z+chOffset0;    // altezza cilindro


/* Gear1 */
float g1s = c0r;              // diametro
float g1h = 30;               // altezza
// cilindro sopra il G1
float c1r = c0r+crOffset0;    // raggio cilindro
float c1h = g1h/2;            // altezza cilindro


/* L1 */
float a1l = (2*c1r)/sqrt(2);
float a1h = 3*a1l/4;
float c1r2 = a1h/2;           // cilindro posteriore
float c1h2 = a1l;
float c1r3 = 3*c1r2/4;        // cilindro anteriore
float c1h3 = c1h2;
//ingranaggio 1 esterno "attuato da ingranaggio 2"
float g2s = 0.8*c1r3;         // diametro
float g2h = c1h2 + c1r3/2;    // altezza
//ingranaggio 2 interno
float g21s = g2s;             // diametro
float g21h = (g2h-c1h3)/2;    // altezza
float GAP = (g2h-c1h3)/2;     // gap tra cilindro posterioree ingranaggio


/* L2 */
float a2x  = 800;
float a2y = 2*0.9*c1r2;
float a2z = 40;
float c2r1 = a2y/2;           // cilindri estremi di L2
float c2h = a2z;


/* GEAR3 */
float c2r2 = c1r3;            // cilindro di giunto
float c2h2 = c1h3/2 + a2z;
float g3h = c1h3-(g2h-c1h3)/2;  // ingranaggio
float g3s = g2s;


/* L3 */
float a3y = 2*c2r2;
float a3x  = a2x/2 - c1r3-a3y ;
float a3z = 20;
//cilindri estremi di L2
float c3r = a3y/2;
float c3h = a3z;
//gear attuante su gear3
float g3h2 = g1h*2;
float g3s2 = g2s*1.5;
//cilindro motore 1
float c3r2 = g3s2*0.3;
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
float g3s3 = 0.7*c3r3;


/* L4 */
//aggancio per rotazione
float c4r = c3r3*0.7;
float c4h = c3h3*0.7;
//box braccio
float a4y = 0.6*a3y;
float a4x  = 0.8*a3x ;
float a4z = 20;
//cilidri finali
float c4r2 = a4y/2;
float c4h2 = c3h;


/* L5 */
float s5 = c4r-a4z/2;


/* MATEMATICA*/
float d1 = a0z + c0h + g1h + c1h + a1h/2;  //OK
float l1 = a1l/2 + c1r3;                   //OK
float l2 = a2x;                            //OK
float d4 = a3x + g3h3 + a4x;               //OK
float d6 = c4r*2;                          //OK

float theta[] = new float[6];
float Pw[][] =  new float[3][1];    // matrice 3x1 non inizializzata
float R36[][] = new float[3][3];
float[] angles = new float[3];     // angles[0]=alpha....
float Pe[][] = {{0}, {0}, {0}};
float Re[][] = new float[3][3];
float[][] Rz_alfa = new float[3][3];
float[][] Ry = new float[3][3];
float[][] Rz_theta = new float[3][3];

float[] Ball = new float[3];        // coordinate pallina puntatore
float initB0 = 1000;
float initB1 = 100;
float initB2 = 500;

boolean [] angleGap = new boolean [2];
boolean manualControl = false;
boolean control_move;
float[] q = new float[6];  //stati degli angoli attuali
float kp;
int gomito = 1;
int axisId = 0;


void setup() {
  /* Create Window */
  size(1500, 800, P3D);
  smooth(8);  // 8x anti-aliasing

  stroke(strokeCol);
  strokeWeight(strokeVar);

  /* x,y,z base */
  xBase = width/2;
  zBase = -width/2;
  yBase = baseDeep;

  Ball[0] = initB0;
  Ball[1] = initB1;
  Ball[2] = initB2;
  
  
   q[0] = 0;
   q[1] = rad(90);
   q[2] = rad(-90);
   q[3] = 0;
   q[4] = rad(180);
   q[5] = 0;
  
  control_move = true;
  
  kp = 1;
}



void draw() {
  background(40);
  lights();

  if(segno==-1){
    textSize(100);
    fill(220,0,0);
    textAlign(CENTER);
    text("-",width/2,70);
    textSize(20);
    textAlign(LEFT);
  }
  if(segno==1){
    textSize(100);
    fill(0,220,0);
    textAlign(CENTER);
    text("+",width/2,70);
    textSize(20);
    textAlign(LEFT);
  }
  
  if(gomito==-1){
    fill(255);
    text("Gomito: ", width/2-100, 92);
    textSize(100);
    fill(220,0,0);
    textAlign(CENTER);
    text("-",width/2,120);
    textSize(20);
    textAlign(LEFT);
  }
  if(gomito==1){
    fill(255);
    text("Gomito: ", width/2-100, 92);
    textSize(100);
    fill(0,220,0);
    textAlign(CENTER);
    text("+",width/2,120);
    textSize(20);
    textAlign(LEFT);
  }
  
  
  fill(255);
  text("K  =",20,100);
  text("p",30,105);
  text(kp, 50,100);
  
    

  Pe[0][0] = Ball[1];
  Pe[1][0] = Ball[0];
  Pe[2][0] = Ball[2];
  
 

  if (manualControl == false) {
    IK();  // Calcolo cinematica inversa
    
    if(control_move == false){
      int t = millis();                      //cinematica pallina
      Ball[0] = 1200*cos(rad(t/60*3.5));
      Ball[1] = -1200*sin(rad(t/60*3.5));
 
    }
  }
  
  if (manualControl == true) {
    fill(255);
    
    text("Theta[0]:", 30, 200);
    text(truncate(theta[0]*180/PI)+"°",110, 200); 
    
    text("Theta[1]:", 30, 220);
    text(truncate(theta[1]*180/PI)+"°", 110, 220); 
    
    text("Theta[2]:", 30, 240);
    text(truncate(theta[2]*180/PI)+"°", 110, 240);
    
    text("Theta[3]:", 30, 260);
    text(truncate(theta[3]*180/PI)+"°", 110, 260);
    
    text("Theta[4]:", 30, 280);
    text(truncate(theta[4]*180/PI)+"°", 110, 280);
    
    text("Theta[5]:", 30, 300);
    text(truncate(theta[5]*180/PI)+"°", 110, 300);
  }
  
  events(); // Pressione tasti e mouse

  /* SETTING ENV */
  rotateX(rad(90));

  /* FLOOR */
  fill(floorCol);
  translate(xBase, yBase, zBase);
  rotateZ(alpha);
  rotateX(beta);
  box(xFloor, yFloor, zFloor);
  
  move();
  drawRobot();
}



void events() {
  /* ENV CONTROL */
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
      yBase += 30;
    }
    if (keyCode == DOWN)
    {
      yBase -= 30;
    }
    if (key == '0') {
      beta -= rad(1);
    }
    if(key == 'c' || key == 'C') {
      control_move = !control_move;
      delay(200);
    }
    /* END ENV CONTROL*/


    /* POSIZIONE DESIDERATA */
    if (key == 'x' || key == 'X') {
      Ball[1] += segno*10;
    }
    if (key == 'y' || key == 'Y') {
      Ball[0] += segno*10;
    }
    if (key == 'z' || key == 'Z') {
      Ball[2] += segno*10;
    }
    /* END POSIZIONE DESIDERATA */


    /* CONTROLLO ALPHA BETA E THETA */
    if (key == 'a' || key == 'A') {
      angles[0] += segno*rad(5);
    }
    if (key == 'b' || key == 'B') {
      angles[1] += segno*rad(5);
    }
    if (key == 't' || key == 'T') {
      angles[2] += segno*rad(5);
    }
    /* CONTROLLO ALPHA BETA E THETA */


    /*LEGGE DI CONTROLLO DELLA VELOCITA*/
    if ((key == 'K' || key == 'k')) {
      kp += segno*.01;
      if (kp<0.0) kp = 0.0;
      if (kp>1.0) kp = 1.0;

    }
    /*LEGGE DI CONTROLLO DELLA VELOCITA*/


    /* GOMITO */
    if (key == '+') {
      gomito = 1;
    }
    if (key == '-') {
      gomito = -1;
    }
    /* END GOMITO */
    
    
    /* AXIS */
    if (key == '9') {
      axisId = (++axisId)%3;
      delay(200);
    }
    /* END AXIS */


    /* MANUAL/AUTOMATIC */
    if (key == 'm' || key == 'M') {
      manualControl = !manualControl;
      delay(200);
    }
    /* END MANUAL/AUTOMATIC */


    /* ENV RESET */
    if (key == 'q' || key == 'Q') {
      alpha = 0;
      beta = 0;

      xBase = width/2;
      zBase = -width/2;
      yBase = baseDeep;


      if (manualControl == true) {
        for (int i=0; i<6; i++)
          theta[i] = 0;
      }

      Ball[0] = initB0;
      Ball[1] = initB1;
      Ball[2] = initB2;
    }


    /* ANGLE CONTROL */
    if (manualControl == true) {
      if (key == '1') {
        theta[0] += segno*rad(1);
      }
      if (key == '2') {
        theta[1] -= segno*rad(1);
      }
      if (key == '3') {
        theta[2] += segno*rad(1);
      }
      if (key == '4') {
        theta[3] += segno*rad(1);
      }
      if (key == '5') {
        theta[4] += segno*rad(1);
      }
      if (key == '6') {
        theta[5] += segno*rad(1);
      }
    }
    /* END ANGLE CONTROL */

    /* SEGNO */
    if (key == 's' || key == 'S') {
      segno = -1*segno;
      delay(200);
    }
    /* END SEGNO */
  }
}


void move(){

  angleGap[0] = false;
  if (abs(theta[0]-q[0])>rad(180)){
    angleGap[0] = true;
  }
  
  if (angleGap[0] == true){
    q[0]=theta[0]+rad(360);
  }else{
    q[0]=theta[0];
  }
  
  /*TESTING*/
    angleGap[1] = false;
  if (abs(theta[4]-q[4])>rad(180)){
    angleGap[0] = true;
  }
  
  if (angleGap[0] == true){
    q[0]=theta[0]+rad(360);
  }else{
    q[0]=theta[0];
  }
  /*TESTING*/
  
  
  if (kp ==1){
    for(int i = 1; i < 6; i++){
      if(q[i]>theta[i]){
        q[i]= theta[i];
      }
      if(q[i]<theta[i]){
        q[i]= theta[i];
      }
    }
  }
  else {
    for(int i = 1; i < 6; i++){
      if(q[i]>theta[i]){
        q[i]-= rad(kp*exp( abs(q[i]-theta[i])));
      }
      if(q[i]<theta[i]){
        q[i]+= rad(kp*exp( abs(q[i]-theta[i])));
      }
    }
  }
}
