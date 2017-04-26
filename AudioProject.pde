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
  //all instruments are initialised
  minim = new Minim(this);
  drum = new Drum(50);
  trumpet = new Trumpet(90);
  hiHat = new HiHat(50);
  bass = new Bass(50);
  cowBell = new CowBell(15);

  //Cillian's Stuff
  halfHeight = height / 2;
  halfWidth = width / 2;

  //Different Songs
  ai = minim.loadFile("Electro.mp3", 512);
  //ai = minim.loadFile("Jazz.mp3", 512);
  //ai = minim.loadFile("Swing.mp3", 512);


  //Robyn's Stuff

  cellHeight = height/ boardHeight; // this is the setup for the checkerboard
  cellWidth = width/boardWidth;
  boxes = new Boxes[20];// calling the class box to the scren

  for (int i = 0; i<20; i ++)
  {
    boxes[i] = new Boxes();
  }

  stroke(255, 255, 0);
}

Boxes[] boxes;
Minim minim;

//Ryan's Stuff
Drum drum;
Trumpet trumpet;
HiHat hiHat;
Bass bass;
CowBell cowBell;
boolean isPlaying = false;

//Cillian's Stuff
AudioPlayer ai; //Allows the play of the sound file
int sampleRate = 44100;
int resolution = 16;
float halfHeight;
float halfWidth;
float radius = 0;
float threshold = 5;
color backColor;

//Robyn's Stuff

float boardWidth = 5.6666;
float boardHeight = 5.6666;
float cellWidth, cellHeight;
float boxZ = 0;
float y, x;

boolean dark = true; 


//This is code that allows multiple key presses
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

  if (checkKey('w'))
  {
    trumpet.play();
  }

  if (checkKey('e'))
  {
    hiHat.play();
  }

  if (checkKey('r'))
  {
    bass.play();
  }

  if (checkKey('t'))
  {
    cowBell.play();
  }

  if (checkKey(' '))
  {
    isPlaying = !isPlaying;
  }
}

void keyReleased()
{
  keys[keyCode] = false;
}

void draw()
{ 
  //Robyn's Stuff
  rotateX(0.6f); // this is Bryans code for rotating the screen
  noStroke();
  //this is how the checkerboard on the background works
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

  // calling the cubes to the screen
  for (int i = 0; i<20; i++)
  {
    boxes[i].boxes();
  }

  float total = 0;
  stroke(227, 16, 5);
  strokeWeight(1f);
  //this is how I got the lines of the checkerboard to move in time with the rhythm. 
  for (int i = 0; i < ai.bufferSize(); i ++)
  {
    for ( int j =0; j < height; j +=90)
    {
      line(i, j, i, j + (ai.left.get(i)* 50));

      line(j, i, j + (ai.left.get(i) * 50), i);
    }
  }

  //Cillian's Stuff

  stroke(255);
  for (int i = 0; i < ai.bufferSize(); i ++)
  {    
    noFill();//noFill because if there is a fill the effect just looks like a solid shape as it is all lines
    stroke(255);
    strokeWeight(0.5f);// Set to 0.5f because 1 makes it very thick and the gap of the line bounces are hidden
    total += abs(ai.left.get(i));// Is in association with the lerp
    float average = total / ai.bufferSize();
    radius = lerp(radius, average, 0.9f); // smoothens off the eye(arc)
    arc(halfWidth, halfHeight, i-180, halfHeight + (radius * halfHeight), 0, TWO_PI);//The eye
  }
  strokeWeight(1);

  //Ryan's Stuff
  //All the key combinations for looping
  if (checkKey('q') && checkKey(SHIFT))
  {
    drum.isPlaying = !drum.isPlaying;
  }

  if (checkKey('w') && checkKey(SHIFT))
  {
    trumpet.isPlaying = !trumpet.isPlaying;
  }

  if (checkKey('e') && checkKey(SHIFT))
  {
    hiHat.isPlaying = !hiHat.isPlaying;
  }

  if (checkKey('r') && checkKey(SHIFT))
  {
    bass.isPlaying = !bass.isPlaying;
  }

  if (checkKey('t') && checkKey(SHIFT))
  {
    cowBell.isPlaying = !cowBell.isPlaying;
  }
  
  if (isPlaying)
    {
      ai.rewind();
      ai.play();
    }

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