import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

void setup ()
{
  size (512, 512, P3D);
  minim = new Minim(this);
  ai = minim.loadSample("Tobtok ft. River - Fast Car.mp3"); //mp3 in there
  halfHeight = height/2;
  cellWidth = width / boardWidth;
  cellHeight= height/ boardHeight;

  //for ( int i =0; i < boxX.length; i++)
  //{
    /*boxX[i] = random(0, width);
    boxY[i] = random(500,700);*/
    

  boxes = new boxes[20];
  
  for(int i = 0; i<20; i ++)
  {
   boxes[i] = new boxes(); 
  }

}

boxes[] boxes;
Minim minim;
AudioSample ai;
//AudioInput ai;
int sampleRate = 44100;
int resolution = 16;
float halfHeight;
float radius = 0; 
float cellHeight, cellWidth;
float boardWidth= 5.6666;
float boardHeight =5.6666; 
//float boxY= 512;
//float boxX= random(0,width);
float boxZ = 0;

color c = color(random(0, 255), random(0, 255), random(0, 255));
float y, x;

boolean dark = true; 

void keyPressed()
{
  if (key == ' ')
  {
    ai.trigger();
  }
}


void draw ()
{
  rotateX(0.7f);
  noStroke();
  for ( float y= 0; y <height; y += cellHeight)
  {
    for (float x = 0; x < width; x += cellWidth)
    {
      if ( dark)
      {
        fill(51, 51, 255);
      } else
      {
        fill(255, 0, 255);
      }
      dark = !dark;
      rect(x, y, cellWidth, cellHeight);
    }
    dark=!dark;
  }



  stroke(0);
  float total = 0; 
  for (int i = 0; i < ai.bufferSize(); i ++)
  {
    for ( int j =0; j < height; j +=90)
    {
      line(i, j, i, j + (ai.left.get(i) * 70));
      total += abs( ai.left.get(i));
      line(j, i, j + (ai.left.get(i) * 70), i);
    }
  }
  
  for(int i = 0; i<20; i++)
  {
  boxes[i].boxs();
  }

  /*float average = total /ai.bufferSize();
   if (average >threshold)
   {
   newBackColor();
   }
   
   radius = lerp(radius, average, 0.1f);
   fill(0);*/
}