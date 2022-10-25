float eyeY = 0;
int giunto=0, segno;
int reset=0;
//base
float xBase, yBase;
float d0x = 170; // lungo x
float d0y = 30; // lungo y
float d0z = 130; // lungo z
//giunto 1
float d1x = 190; // lungo x
float d1y = 40; // lungo y
float d1z = 140; // lungo z
//giunto 2
float d2x = 45; // lungo x
float d2y = 25; // lungo y
float d2z = 190; // lungo z
//link 2
float d3x = 225; // lungo x
float d3y = 25; // lungo y
float d3z = 25; // lungo z
//giunto 3
float d4x = 45; // lungo x
float d4y = 25; // lungo y
float d4z = 90; // lungo z
//giunto 3
float d5x = 150; // lungo x
float d5y = 25; // lungo y
float d5z = 25; // lungo z
//giunto 3
float d6x = 80; // lungo x
float d6y = 25; // lungo y
float d6z = 25; // lungo z
//giunto 3
float d7x = 30; // lungo x
float d7y = 25; // lungo y
float d7z = 25; // lungo z

//float[] q = {0,-0.78,1,0}; 
float[] q = {0,0,0,0,0,0,0}; 
void setup(){
  size(1500,900, P3D);
  fill(255);
  xBase = width/2;
  yBase = height/2;


}

void draw(){
  background(230);
  camera((width/2.0), height/2 - eyeY, (height/2.0) / tan(PI*60.0 / 360.0), width/2.0, height/2.0, 0, 0, 1, 0);  

  if(mousePressed){
  xBase = mouseX;
  yBase = mouseY;
  }
  if (keyPressed)
  {
    // movimento camera
    if (keyCode == DOWN)
    {
      eyeY -= 5;
    }
    if (keyCode == UP)
    {
      eyeY += 5;
    }

    if (key == '1')
    {
      giunto = 0;
    }
    if (key == '2')
    {
      giunto = 1;
    }
    if (key == '3')
    {
      giunto = 2;
    }
    if (key == '4')
    {
      giunto = 3;
    }
    if (key == '5')
    {
      giunto = 4;
    }
    if (key == '6')
    {
      giunto = 5;
    }
    if (key == 'r')
    {
      for(int i=0;i<5;i++){
      q[i]=0;
    }
    }
    if (keyCode == LEFT)
    {
      segno = -1;
      muovi();
    }
    if (keyCode == RIGHT)
    {
      segno = 1;
      muovi();      
    }
  }
  pushMatrix();
  fill(255);
 // Link 0 (base)
 translate(xBase,yBase);
 box(d0x,d0y,d0z);
 //giunto 0(ruota su base)
 fill(202);
 rotateY(q[0]);
 translate(0,-(d0y+d0y)/2,0);
 box(d1x,d1y,d1z);
 //giunto 1
 fill(180);
 //translate(d1x/2,-(d0y+d1y-d0y/2)/2,0);
 translate(d1x/2-d2x/2,-d1y/2,0);
 box(d2x,d2y,d2z);
  //Link 2 (ruota su asse Z)
 fill(202);
 rotateZ(q[1]);
 translate(d3x/2,-(d2y+d3y)/2,0);

 box(d3x,d3y,d3z);
 /*//disegno sfera
 pushMatrix();
 translate(-d3x/2,+d3y/2,0);
 fill(255, 0, 2);
 sphere(25);
 popMatrix();
 */
 //giunto 2
 fill(180);
 //translate(d3x/2,-(d3y)/2,0);
 translate(d3x/2,0,0);
 box(d4x,d4y,d4z);
 /* //disegno sfera
 pushMatrix();
 translate(+d3x,-d3y/2,0);
 fill(255, 0, 2);
 sphere(25);
 popMatrix();*/
 
 //disegno il link
 rotateZ(q[2]);
 //translate(d4x,-d4y+d4y/2,0);
 translate(d4x,0,0);
 box(d5x,d5y,d5z);
//disengo link
 rotateX(q[3]);
 translate((d4x+d5x+35)/2,0,0);
 box(d6x,d6y,d6z);

 //disegno giunto
 fill(180);
 translate(d6x-d4x,0,0);
 box(d4x,d4y,d4z);
 rotateZ(q[4]);
 

 
 rotateZ(q[5]);
 translate(d4x,0,0);
 box(d5x,d5y,d5z);

 
 //pinza
  fill(255,0,0);
 rotateX(q[5]);
 translate((d5x+d6x-d4x)/2,0,0);
 box(d7x,d7y,d7z);


 
 
  printvalue();
 

}

void printvalue(){
  popMatrix();
  textSize(20);
  text("theta 0:",120,120);
  text(q[0],195,120);
  text("theta 1:",120,150);
  text(q[1],195,150);  
  text("theta 2:",120,180);
  text(q[2],195,180);  
  text("theta 3:",120,210);
  text(q[3],195,210); 
  text("theta 4:",120,240);
  text(q[4],195,240); 
  text("theta 5:",120,270);
  text(q[5],195,270);  


}
void muovi(){

  if (giunto == 0)
  {
    q[giunto] += segno*.006;
  }
  if (giunto == 1)
  {
    if (segno*q[giunto]-100*PI/180<0)
    {
      q[giunto] += segno*0.06;
    }
  }
  if (giunto == 2)
  {
    if (segno*q[giunto]-100*PI/180<0)
    {
      q[giunto] += segno*.1;
    }
  }
  if (giunto == 3)
  {
    q[giunto] += segno*.1;
  }
  if(giunto==4)
  {  
    if (segno*q[giunto]-100*PI/180<0)
    {
      q[giunto] += segno*.1;
    }
  }
  if(giunto==5)
  {  
      q[giunto] += segno*.1;
  }  


}
