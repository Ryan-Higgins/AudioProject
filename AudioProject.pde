import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

void setup()
{
  size(512,512);
  
  minim = new Minim(this);
  drum = new Drum(50);
  trumpet = new Trumpet(90);
  hiHat = new HiHat(50);
  
  stroke(255,255,0);
}

Minim minim;

Drum drum;
Trumpet trumpet;
HiHat hiHat;

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
}

void keyReleased()
{
 keys[keyCode] = false; 
}

void draw()
{
 background(0);

//this turns the loop on and off
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
 
 trumpet.render();
 trumpet.repeat();
 hiHat.render();
 hiHat.repeat();
 drum.render();
 drum.repeat();
}