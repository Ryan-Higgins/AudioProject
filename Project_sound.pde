import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


//This is for merging
void setup()
{
  size(512, 512);
  minim = new Minim(this);
  ai = minim.loadSample("Jazz.mp3", 512);
  //ai = minim.getLineIn(Minim.STEREO, width, sampleRate, resolution);
  halfHeight = height / 2;
  halfWidth = width / 2;
  newBackColor();
}

void newBackColor()
{
  backColor = color(random(0, 255), random(0, 255), random(0, 255));
}

Minim minim;
//AudioInput ai;
AudioSample ai;

int sampleRate = 44100;
int resolution = 16;
float halfHeight;
float halfWidth;
float radius = 0;
float threshold = 5;
color backColor;

void keyPressed()
{
  if (key == ' ')
  {
    // Uncomment this if you want to play the audio file
    ai.trigger();  
  }
}

void draw()
{
  background(0);
  backGround();
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
  if (average > threshold)
  {
    newBackColor();
  }
  radius = lerp(radius, average, 0.1f);
  //ellipse(halfHeight, halfHeight, radius * height, radius * height); 
  
  
}