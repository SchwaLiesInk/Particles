Vector cam=new Vector(0, 0, 100);
Vector angle=new Vector(0, Math.PI*0.5, 0);
Vector lookat=new Vector(0, 0, 0);
Normal up=new Normal(0, 1, 0);
double radius=1;
float spin=0;
int mx;  
int my;  
int trak=64;
RingList<Particle>particles=new RingList();
void setup(){
size(800,800,P3D);

    background(0);
    cam=new Vector();
  cam.x=radius*Math.cos(angle.x);
  cam.z=radius*Math.sin(angle.x);
  cam.y=radius*Math.cos(angle.y);
  lookat=new Vector(0, 0, 0);
  up=new Normal(0, 1, 0);
  textFont(createFont("Eurostile", 12));
  Particle p;
  for(int i=0;i<PARTICLES;i++){
  p=new Particle();
  particles.Append(p);
  }
  
}
void mousePressed() {
  mx=(mouseX);
  my=(mouseY);
}
void mouseReleased() {
  mx=(mouseX);
  my=(mouseY);
}
void mouseDragged() {
  double x=(mx-mouseX);
  double xs=Math.sqrt(Math.abs(x*Math.PI));
  double y=(my-mouseY);
  double ys=Math.sqrt(Math.abs(y*Math.PI));
  if (x>0) {
    x=Math.PI;
  } else if (x<0) {
    x=-Math.PI;
  }
  if (y>0) {
    y=Math.PI;
  } else if (y<0) {
    y=-Math.PI;
  }
  angle.x-=(double)(x)/width*xs;
  angle.y-=(double)(y)/height*ys;
  if (angle.x<-Math.PI) {
    angle.x+=Math.PI*2;
  } else
    if (angle.x>Math.PI) {
    angle.x-=Math.PI*2;
  }
  if (angle.y<-Math.PI) {
    angle.y+=Math.PI*2;
  } else
    if (angle.y>Math.PI) {
    angle.y-=Math.PI*2;
  }
  cam.x=radius*Math.cos(angle.x);
  cam.z=radius*Math.sin(angle.x);
  cam.y=radius*Math.cos(angle.y);
  mx=(mouseX);
  my=(mouseY);
}
void keyPressed() {

  if (keyCode==UP) {
    radius*=0.99;
    if (radius<1.25) {
      radius=1.25;
    } 

    cam.x=radius*Math.cos(angle.x);
    cam.z=radius*Math.sin(angle.x);
    cam.y=radius*Math.cos(angle.y);
  } else
    if (keyCode==DOWN) {
    radius*=1.11;
    if (radius>25) {
      radius=25;
    }

    cam.x=radius*Math.cos(angle.x);
    cam.z=radius*Math.sin(angle.x);
    cam.y=radius*Math.cos(angle.y);
  }
}
void draw(){
  background(0);
  lights();
  camera((float)cam.x*100, (float) cam.y*100, (float)cam.z*100, (float)lookat.x, (float)lookat.y, (float)lookat.z, (float)up.x, (float)up.y, (float)up.z);
  //beginShape(TRIANGLE_FAN);
  noStroke();
  //beginShape(POINTS);
  for(Node<Particle> p=particles.Start();p.data!=null;p=p.next){
  float l=(float)p.data.Move(0.005,256,0.01,10);
  //stroke(l*2,128,255-l,64);
    fill(l*2,128,255-l,64);
    pushMatrix();
    //vertex((float)p.data.local.x,(float)p.data.local.y,(float)p.data.local.z);
    scale(0.5,0.5,0.5); 
    translate((float)p.data.local.x,(float)p.data.local.y,(float)p.data.local.z);
    
    sphere((float)p.data.local.r);
    popMatrix();
  }
  //endShape();  
}
