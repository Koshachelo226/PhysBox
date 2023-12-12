import controlP5.*;
ControlP5 cp;

PVector VentPower = new PVector(-1, 0);
PVector g = new PVector(0, 1); 
float bounce = 0.9;
float Drag = 0.01;
float densityWater = 0.5;
int CirclesNumber = 10;
float maxStartPower = 50;

circleObject[] circles = new circleObject[CirclesNumber];

boolean play = true;

//circleObject circle1 = new circleObject();

void setup() {
  background(200);
  size(1280, 720);
  frameRate(60);
  
  cp = new ControlP5(this);
  
  cp.addButton("resetButton")
     .setLabel("Reset")
     .setValue(0)
     .setPosition(10, 10)
     .setSize(80, 30)
     .setFont(createFont("Colombo", 22))
     ;
     
  sliderAdd("sliderG", "G - Const", 1, 10, 50, 0, 10);
  sliderAdd("sliderVentY", "", 0, 10, 90, -10, 10);
  sliderAdd("sliderVentX", "Vent Power", 0, 90, 90, -10, 10);
  sliderAdd("sliderBounce", "Bounce", bounce, 10, 130, 0, 1);
  sliderAdd("sliderRadius", "Radius", 5, 10, 170, 0, 250);
  sliderAdd("sliderMaxStartPower", "StartPower", maxStartPower, 10, 210, 10, 100);
  //sliderAdd("sliderDrag", "Drag", 0.2, 10, 250, Drag, 1);
  //sliderAdd("sliderArch", "Arch Power", 0.0001, 10, 290, 0, 10);
  
  cp.addTextfield("arch")
     .setLabel("Arch Power")
     .setPosition(10,250)
     .setSize(250,40)
     .setFont(createFont("Calibri", 22))
     .setFocus(true)
     .setColor(color(255,0,0))
     ;
  
  VentPower.rotate(0);
  
  for (int i = 0; i < CirclesNumber; i++) {
    circles[i] = new circleObject();
    
    circles[i].radius = 25;
    circles[i].CirclePos = new PVector(random(circles[i].radius+5, width-circles[i].radius-5), random(circles[i].radius+5, height-circles[i].radius-5));
    circles[i].CircleDir = PVector.random2D();
    circles[i].CircleDir.mult(random(10, maxStartPower));
  }
  
  noStroke();
  
}

void draw() {
  background(200);
  
  if (play) {
    //circles[0].circleCollide(circles[1]);
    //circles[1].circleCollide(circles[0]);
    
    for (int i = 0; i < CirclesNumber; i++) {
        circles[i].circleCollide();
        circles[i].circlePowersCalc();
        //println(circles[3].CircleDir);
        //circles[i].drawC();
    }
  }
  text(densityWater, 100, );
  
  for (int i = 0; i < CirclesNumber; i++) {
    if (i == 3) {fill(255,0,0);}
    else {fill(0,0,0);}
    circles[i].drawC();
  }
  
  fill(144, 243, 255, 150);
  rect(0, height*(0.7), width, height);
  //delay(100);
}

void resetButton() {
  for (int i = 0; i < CirclesNumber; i++) {
    circles[i].CirclePos = new PVector(random(circles[i].radius+5, width-circles[i].radius-5), random(circles[i].radius+5, height-circles[i].radius-5));
    circles[i].CircleDir = PVector.random2D();
    circles[i].CircleDir.mult(random(10, maxStartPower));
    circles[i].checked = false;
  }
}

void sliderG(int gConst) {
  g.y = gConst;
}

void sliderVentX(int vent) {
  VentPower.x = vent;
}

void sliderVentY(int vent) {
  VentPower.y = vent;
}

void sliderBounce(float bounceV) {
  bounce = bounceV;
}

void sliderRadius(int rad) {
  for (int i = 0; i < CirclesNumber; i++) {
    circles[i].radius = rad;
  }
}

void sliderMaxStartPower(float pow) {
  maxStartPower = pow;
}

void sliderDrag(float drag) {
  Drag = drag;
} 

void arch(String Arch) {
  densityWater = float(Arch);
}

void keyPressed() {
  if (key == ' ') {play = !play;}
}

void sliderAdd(String techName, String name, float startValue, float posX, float posY, float rangeMin, float rangeMax) {
  cp.addSlider(techName)
     .setLabel(name)
     .setValue(startValue)
     .setPosition(posX, posY)
     .setSize(80, 30)
     .setRange(rangeMin, rangeMax)
     .setFont(createFont("Calibri", 22))
     ;
}
