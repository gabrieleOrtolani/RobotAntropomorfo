/*
Questo sketch illustra come effettuare in ambiente Processing le operazioni matriciali con delle funzioni appositamente create e riportate in fondo. 
*/

float[][] M1 = {{1, 2, 3},{4, 5, 6},{7, 8, 9}}; // matrice 3x3 inizializzata nella dichiarazione
float[][] M2 = idMat(3,2); // matrice 3x3 inizializzata usando la funzione idMat (riportata sotto), che genera matrici identità moltiplicate per una costante 
float[][] M3 = new float[3][3]; // matrice 3x3 dichiarata ma non inizializzata
float[][] R1 = new float[3][3]; // matrice 3x3 dichiarata ma non inizializzata
float[][] R2 = new float[3][3]; // matrice 3x3 dichiarata ma non inizializzata
float[][] R3 = new float[3][3]; // matrice 3x3 dichiarata ma non inizializzata
float[][] invM2,invM3 = new float[3][3]; // dichiaro 2 matrici 3x3 in un colpo solo


void setup() 
{
  size(1250,950);
  
  // Inizializzo la matrice M3 con numeri random tra 0 e 1
  for (int i=0; i<3; i++)
  {
    for (int j=0; j<3; j++)
    {
      M3[i][j] = random(0,1);
    }
  }
  
}

void draw() 
{
  
  background(0);

  R1 = mProd(M1,M2); // Faccio il prodotto tra M1 e M2 e lo assegno a R1

  R2 = mSum(M1,M2); // Faccio la somma tra M1 e M2 e la assegno a R2
  
  R3 = trasposta(M1); // Faccio la trasposta di M1 e la assegno a R3
  
  
  // Se premo il mouse cambio M3 sempre generando una matrice con numeri random tra 0 e 1  
  if (mousePressed)
  {
    for (int i=0; i<3; i++)
    {
      for (int j=0; j<3; j++)
      {
        M3[i][j] = random(0,1);
      }
    }
  }


  if (det(M2) != 0) // Se M2 è invertibile ne calcolo l'inversa altrimenti scrivo che non è invertibile
  {
    invM2 = invMat(M2); // Calcolo l'inversa di M2
    scriviMatrice("invM2 = ",invM2,10,380);
  }
  else
  {
    text("M2 non è invertibile",10,380);
  }

  if (det(M3) != 0) // Se M3 è invertibile ne calcolo l'inversa altrimenti scrivo che non è invertibile
  {
    invM3 = invMat(M3); // Calcolo l'inversa di M3
    scriviMatrice("invM3 = ",invM3,400,380);    
  }
  else
  {
    text("M3 non è invertibile",400,380);
  }
  
  scriviMatrice("M1 = ",M1,10,20);
  scriviMatrice("M2 = ",M2,400,20);
  scriviMatrice("M3 = ",M3,710,20);
  
  scriviMatrice("R1 = ",R1,10,200);
  scriviMatrice("R2 = ",R2,400,200);
  scriviMatrice("R3 = ",R3,710,200);
    
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
  

/********************************************************
/********************************************************
 DA QUI IN POI CI SONO LE FUNZIONI DI CALCOLO MATRICIALE 
/********************************************************
/********************************************************/

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


float[][] minore(float[][] A, int i, int j) // Determina il minore (i,j) di una matrice A
{
  int nA = A.length;
  float[][] C = new float[nA-1][nA-1];
  
  for (int iM = 0; iM < i; iM++)
  {
    for (int jM = 0; jM < j; jM++)
    {
      C[iM][jM] = A[iM][jM];
    } 
    for (int jM = j; jM < nA-1; jM++)
    {
      C[iM][jM] = A[iM][jM+1];
    } 
  }
  for (int iM = i; iM < nA-1; iM++)
  {
    for (int jM = 0; jM < j; jM++)
    {
      C[iM][jM] = A[iM+1][jM];
    } 
    for (int jM = j; jM < nA-1; jM++)
    {
      C[iM][jM] = A[iM+1][jM+1];
    } 
  }
  return C;
}


float det(float[][] A) // Calcola il determinante di A
{
  int nA = A.length;
  float determinante = 0;
  
  if (nA == 1)
  {
    determinante = A[0][0];
  }
  else
  {
    for (int j=0; j < nA; j++) 
    {
      determinante = determinante + A[0][j]*pow(-1,j)*det(minore(A,0,j));
    }
  }
  return determinante;
}


float[][] invMat(float[][] A) // Calcola l'inversa di una matrice A
{
  int nA = A.length;
  float[][] C = new float[nA][nA];
  float detA = det(A);

  if (nA == 1)
  {
    C[0][0] = 1/detA;
  }
  else
  {
    for (int i=0; i < nA; i++) 
    {
      for (int j=0; j < nA; j++) 
      {
        C[j][i] = pow(-1,i+j)*det(minore(A,i,j))/detA;
      }
    }
  }
  return C;
}

float[][] idMat(int nA, float sigma) // Assegna una matrice identità di ordine nA moltiplicata per una costante sigma
{
  float[][] I = new float[nA][nA]; 

  for (int i=0; i < nA; i++) 
  {
    for (int j=0; j < nA; j++) 
    {  
      I[i][j] = 0;
    }
    I[i][i] = sigma;
  }
  return I;
}