import com.jogamp.opengl.GLProfile;
{
  GLProfile.initSingleton();
}


/* General variables for stroke/color */
int strokeVar = 1;
int strokeCol = #9D9654; //strokeCol = #6A4811;
int gearCol = #A0A0A0;
//int ballCol = #00FF39;
int ballCol =#EA0CE0;
int linkCol = #FFED24; //linkCol = #EA9A18; //linkCol = #F7B241;
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
float gomito = 1;
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

boolean manualControl = false;
float[] q = new float[6];  //stati degli angoli attuali
float kp;



void setup() {
  /* Create Window */
  //fullScreen(P3D);
  size(1500, 800, P3D); //fullScreen(P3D);
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
  
  kp = 0.4;
}



void draw() {
  background(40);
  lights();

  /*DEBUG*/
  /*
  for (int i = 0 ; i<3 ; i++) {
   Pe[i][0] = -Ball[i];// serve per inseguire la pallina
   theta[i+3] = rad(90);
   }
   */
 
  
  if(segno==-1){
    textSize(100);
    fill(220,0,0);
    text("-",width/2,70);
    textSize(20);
  }
  if(segno==1){
    textSize(100);
    fill(0,220,0);
    text("+",width/2,70);
    textSize(20);
  }  
  
      fill(255);
      text("K  =",20,100);
      text("p",30,105);
      text(kp, 50,100);
      
      
      
  Pe[0][0] = Ball[1];
  Pe[1][0] = Ball[0];
  Pe[2][0] = Ball[2];
  /* PRINTING */
  //textSize(20);
  /* END PRINTING */

  if (manualControl == false) {
    IK();  // Calcolo cinematica inversa
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

  /*
  theta[0] = rad(80);
   theta[1] = rad(30);
   theta[2] = rad(110);
   theta[3] = rad(-90);
   theta[4] = rad(-70);
   theta[5] = rad(90);
   */
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
    /* END ENV CONTROL*/


    /* POSIZIONE DESIDERATA */
    if (key == 'x' || key == 'X') {
      Ball[0] += segno*10;
    }
    if (key == 'y' || key == 'Y') {
      Ball[1] += segno*10;
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
    if (key == 'o' || key == 'O') {
      angles[2] += segno*rad(5);
    }
    /* CONTROLLO ALPHA BETA E THETA */


    /*LEGGE DI CONTROLLO DELLA VELOCITA*/
    if ((key == 'K' || key == 'k')) {
      kp += segno*.01;
      if (kp<0.0) kp = 0;
      if (kp>1.0) kp = 1.0;

    }
    /*LEGGE DI CONTROLLO DELLA VELOCITA*/


    /* GOMITO */
    if (key == '+') {
      gomito *= gomito;
    }
    if (key == '-') {
      gomito *= -gomito;
    }
    /* END GOMITO */


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
  for(int i = 0; i < 6; i++){
    if(q[i]>theta[i]){
      q[i]-= rad(kp*exp( abs(q[i]-theta[i])));
    }
    if(q[i]<theta[i]){
      q[i]+= rad(kp*exp( abs(q[i]-theta[i])));
    }
  }
}
