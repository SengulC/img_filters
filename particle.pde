class Particle
{
  float posx, posy;
  float velx, vely;
  float diameter;
  color c;
  
  public Particle(float posx, float posy, float velx, float vely, float diameter, color c) {
    this.posx = posx;
    this.posy = posy;
    this.velx = velx;
    this.vely = vely;
    this.diameter = diameter;
    this.c = c;
  }
  
  void render()
  {
    c = centreImg.get( floor( posx ), floor (posy) );
    noStroke();
    fill(c);
    circle(posx, posy, diameter);
  }
  
  void update()
  {
    posx += velx;
    posy += vely;
    
    // bounce off the sides
    if ( (posx>width) || (posx<0) ) velx = -velx;
    if ( (posy>height) || (posy<0) ) vely = -vely;
  }
}
