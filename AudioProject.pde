import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

void setup()
{
  size(512, 512, P3D);
  
  //Ryan's stuff
  minim = new Minim(this);
  drum = new Drum(50);
  trumpet = new Trumpet(90);
  hiHat = new HiHat(50);
  bass = new Bass(50);
  cowBell = new CowBell(15);
  
  //Cillian's Stuff
  halfHeight = height / 2;
  halfWidth = width / 2;
  //newBackColor();
  ai = minim.loadSample("Jazz.mp3", 512);
  
  //Robyn's Stuff
  
  cellHeight = height/ boardHeight;
  cellWidth = width/boardWidth;
  boxes = new Boxes[20];
  
   for(int i = 0; i<20; i ++)
  {
   boxes[i] = new Boxes(); 
  }
  
  stroke(255,255,0);
}

Boxes[] boxes;
Minim minim;

//Ryan's Stuff
Drum drum;
Trumpet trumpet;
HiHat hiHat;
Bass bass;
CowBell cowBell;

//Cillian's Stuff
AudioSample ai;
int sampleRate = 44100;
int resolution = 16;
float halfHeight;
float halfWidth;
float radius = 0;
float threshold = 5;
color backColor;

//Robyn's Stuff

AudioSample bi;
//AudioInput ai; 
float boardWidth = 5.6666;
float boardHeight = 5.6666;
float cellWidth, cellHeight;
//float boxY= 512;
//float boxX= random(0,width);
float boxZ = 0;

color c = color(random(0, 255), random(0, 255), random(0, 255));
float y, x;

boolean dark = true; 


//This is Bryan's code that allows multiple key presses
boolean[] keys = new boolean[1000];

boolean checkKey(int k)
{
  if (keys.length >= k) 
  {
    return keys[k] || keys[Character.toUpperCase(k)];
  }
  return false;
}

void keyPressed()
{
  keys[keyCode] = true;
  
  //this is all 1 play
  if (checkKey('q'))
  {
    drum.play();
  }
  
  if(checkKey('w'))
  {
   trumpet.play();
  }
 
  if(checkKey('e'))
  {
   hiHat.play();
  }
  
  if(checkKey('r'))
  {
    bass.play();
  }
  
  if(checkKey('t'))
  {
    cowBell.play();
  }
  
  if (key == ' ')
  {
    ai.trigger();  
  }
}

void keyReleased()
{
 keys[keyCode] = false; 
}

/*void newBackColor()
{
  backColor = color(random(0, 255), random(0, 255), random(0, 255));
}
*/
void draw()
{
 //Cillian's Stuff
 //backGround();
 stroke(255, 255, 0);
 float total = 0;
  for (int i = 0 ; i < ai.bufferSize() ; i ++)
  {
    //line(i, halfHeight, i, halfHeight + (ai.left.get(i) * halfHeight));
    total += abs(ai.left.get(i));
    
  noFill();
  stroke(255);
  arc(halfWidth, halfHeight,  i, halfHeight + (ai.left.get(i) * halfHeight), 0, TWO_PI);
  
  }
  float average = total / ai.bufferSize();
 /* if (average > threshold)
  {
    newBackColor();
  }
  */
  radius = lerp(radius, average, 0.1f);
 
 

//Ryan's Stuff
 if(checkKey('q') && checkKey(SHIFT))
  {
      drum.isPlaying = !drum.isPlaying;
  }

 if(checkKey('w') && checkKey(SHIFT))
 {
     trumpet.isPlaying = !trumpet.isPlaying;     
 }
 
 if(checkKey('e') && checkKey(SHIFT))
 {
    hiHat.isPlaying = !hiHat.isPlaying;
 }
 
 if(checkKey('r') && checkKey(SHIFT))
 {
    bass.isPlaying = !bass.isPlaying; 
 }
 
 if(checkKey('t') && checkKey(SHIFT))
 {
    cowBell.isPlaying = !cowBell.isPlaying; 
 }
 
 //Robyn's Stuff
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

 for(int i = 0; i<20; i++)
  {
  boxes[i].boxes();
  }
 

  stroke(0); 
  for (int i = 0; i < ai.bufferSize(); i ++)
  {
    for ( int j =0; j < height; j +=90)
    {
      line(i, j, i, j + (ai.left.get(i) * 70));
      total += abs( ai.left.get(i));
      line(j, i, j + (ai.left.get(i) * 70), i);
    }
  }

  /*float average = total /ai.bufferSize();
   if (average >threshold)
   {
   newBackColor();
   }
   
   radius = lerp(radius, average, 0.1f);
   fill(0);*/
 
 //Ryan's Stuff
 trumpet.render();
 trumpet.repeat();
 hiHat.render();
 hiHat.repeat();
 drum.render();
 drum.repeat();
 bass.render();
 bass.repeat();
 cowBell.render();
 cowBell.repeat();
}