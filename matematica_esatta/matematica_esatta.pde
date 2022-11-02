float []theta  = new float[3];
float Pe[][] = {{35}, {0}, {90}};
float Re[][] = new float[3][3];
float[][] Rz_alfa = new float[3][3];
float[][] Ry = new float[3][3];
float[][] Rz_theta = new float[3][3];
float d1 = 50;
float l1 = 8;
float l2 = 60;
float d4 = 60;
float d6 = 20;
float Pw[][] =  new float[3][1];    // matrice 3x1 non inizializzata
void setup(){

  size(800,800);
  
}
void draw(){
    IK();

}
void IK(){
  float vetCol[][] = new float[3][1];
  float A1 = 0, A2 = 0;
  Rz_alfa = Rz_calc(90);
  Rz_theta = Rz_calc(90);
  Ry = Ry_calc(90);
  Re = mProd(Rz_alfa,Ry);
  Re = mProd(Re,Rz_theta);
  scriviMatrice("R_e", Re, 500, 200);
  vetCol = CalcoloPw(Pe, Re, d6);
  scriviVettoreCol("d6*a_e:", vetCol, 100, 200);
  
  Pw = mSum(Pe, vetCol);
  scriviVettoreCol("Pw:", Pw, 100, 350);
  
  // calcolo di theta1
  theta[0] = atan2(Pw[1][0], Pw[0][0]);
  textSize(20);
  fill(255);
  text("Theta0:", 100, 500);
  text(theta[0], 100, 530);
  
  A1 = Pw[0][0]*cos(theta[0]) + Pw[1][0]*sin(theta[0]) - l1;
  A2 = d1 - Pw[2][0];
  
  text("A1, A2:", 100, 600);
  text(A1, 100, 630);
  text(A2, 100, 660);
  
  // calcolo di theta3
  theta[2] = calcoloTheta3(A1, A2);
  text("Theta3:", 200, 300);
  text(theta[2]*180/PI, 200, 330);
  
  // calcolo di theta2
  theta[1] = atan2(d4*cos(theta[2])*A1 - (d4*sin(theta[2])+l2)*A2, (d4*sin(theta[2])+l2)*A1 + d4*cos(theta[2])*A2);
  text("Theta2:", 200, 400);
  text(theta[1]*180/PI, 200, 430);  
 

}
float[][] Rz_calc(float angle){
  float[][] my_Rz = {{cos(angle),-sin(angle),0},
                     {sin(angle),cos(angle),0},
                     {0,0,1}};
  return my_Rz;                   
}
float[][] Ry_calc(float angle){
  float[][] my_Ry = {{cos(90-angle),0,sin(90-angle)},
                     {0,1,0},
                     {-sin(90-angle),0,cos(90-angle)}};
  return my_Ry;                   
} 


float calcoloTheta3(float A1, float A2){
  float arg = 0;
  
  arg = pow(A1, 2) + pow(A2, 2) - pow(d4, 2) - pow(l2, 2);
  arg /= (2*l2*d4);
  

  return asin(arg);
}

float[][] mProd(float[][] A,float[][] B) // Calcola prodotto di due matrici A e B
{
  int nA = A.length;
  int nAB = A[0].length;
  int nB = B[0].length;
  
  float[][] C = new float[nA][nB]; 

  for (int i=0; i < nA; i++) 
  {
    for (int j=0; j < nB; j++) 
    {  
      for (int k=0; k < nAB; k++) 
      {
        C[i][j] += A[i][k] * B[k][j];
      }
    }
  }
  return C;
}
float[][] CalcoloPw(float[][] Pe, float[][] Re, float d6){
  float res[][] = new float[3][1];
  
  for(int i=0; i<3; i++){
    res[i][0] = d6 * Re[i][2];
    res[i][0] *= -1;
  }
    
  return res;
}

void scriviVettoreCol(String s, float[][] M, int x, int y) // Scrive una matrice a partire dal punto (x,y)
{
  textSize(20);
  fill(255);
  text(s,x,y); 
  text(M[0][0],x,y+30);
  text(M[1][0],x,y+60);  
  text(M[2][0],x,y+90);
}

void scriviMatrice(String s, float[][] M, int x, int y) // Scrive una matrice a partire dal punto (x,y)
{
  textSize(20);
  fill(255);
  text(s,x,y); 
  text(M[0][0],x,y+30); text(M[0][1],x+90,y+30); text(M[0][2],x+180,y+30);
  text(M[1][0],x,y+60); text(M[1][1],x+90,y+60); text(M[1][2],x+180,y+60); 
  text(M[2][0],x,y+90); text(M[2][1],x+90,y+90); text(M[2][2],x+180,y+90);
}  

float[][] mSum(float[][] A,float[][] B) // Calcola la somma di due matrici A e B
{
  int nA = A.length;
  int nB = A[0].length;
  
  float[][] C = new float[nA][nB]; 

  for (int i=0; i < nA; i++) 
  {
    for (int j=0; j < nB; j++) 
    {  
      C[i][j] = A[i][j] + B[i][j];
    }
  }
  return C;
}

float[][] trasposta(float[][] A) // Calcola la trasposta di una matrice A
{
  int nR = A.length;
  int nC = A[0].length; 
  
  float[][] C = new float[nC][nR]; 

  for (int i=0; i < nC; i++) 
  {
    for (int j=0; j < nR; j++) 
    {  
      C[i][j] = A[j][i];
    }
  }
  return C;
}
