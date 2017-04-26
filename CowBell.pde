class CowBell extends Instrument
{
 AudioPlayer cowBell;
 float timer;
 boolean isPlaying;
 
 CowBell(float delay)
 {
  super(delay);
  cowBell = minim.loadFile("Cowbell.wav",width);
 }
 
 void repeat()
 {
  if(isPlaying)
  {
    cowBell.play();
    timer += 0.5f;
    if(timer >= delay)
    {
     cowBell.rewind(); 
     timer=0;
    }
  }
 }
 
 void play()
 {
  cowBell.rewind();
  cowBell.play();
 }
 
 void render()
 {
  for(int i = 0; i < cowBell.bufferSize(); i++)
  {
   stroke(255);
   line(i, height/2 - 50, i , (height/2 - 50) - abs((cowBell.left.get(i) * height/2)));
  }
 }
}