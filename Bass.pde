class Bass extends Instrument
{
  AudioPlayer bass;
  float timer;
  boolean isPlaying;
 
  Bass(float delay)
  {
   super(delay);
   bass = minim.loadFile("Bass.wav", width);
  }
  
  void repeat()
  {
   if (isPlaying)
    {
      bass.play();
      timer += 0.5f;
      if (timer >= delay)
      {
        bass.rewind();
        timer = 0;
      }
    }    
  }
  
  void play()
  {
    bass.rewind();
    bass.play();
  }
  
  void render()
  {
   for(int i = 0; i < bass.bufferSize(); i++)
    {
    stroke(0,255,0);
    line(i,height,i, height - abs((bass.left.get(i) * height/2))); 
    }     
  }
    
  
}