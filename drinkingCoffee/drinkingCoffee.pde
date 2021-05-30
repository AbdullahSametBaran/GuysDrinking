// PShape and PImage Initiation
PShape shapeTable1, shapeTable2, shapeChair1, shapeChair2, shapeChair3, shapeHome;

PImage imgTable, imgCoffee, imgChair, imgBrick, imgGrass, imgRock, imgSky, imgDoor, img1, img2, img3, img4;


void setup() {
  size(750, 550, P3D);
  frameRate(30);
  

  // Image declarations
  imgBrick = loadImage("brick.jpg");
  imgGrass = loadImage("grass.jpg");
  imgSky = loadImage("sky.jpg");
  imgChair = loadImage("chair.jpg");
  imgTable = loadImage("table.jpg");
  imgCoffee = loadImage("coffee.jpg");
  img1 = loadImage("trk.jpg");
  img2 = loadImage("smt.jpg");
  imgRock = loadImage("rock.jpg");
  imgDoor = loadImage("door.jpg");
  

  // PShape declarations
  shapeTable1 = createShape(BOX, 280, 20, 280);
  shapeTable1.setTexture(imgTable);
  shapeTable1.setStrokeWeight(0);

  shapeTable2 = createShape(BOX, 25, 150, 25);
  shapeTable2.setTexture(imgTable);
  shapeTable2.setStrokeWeight(0);

  shapeChair1 = createShape(BOX, 20, 200, 120);
  shapeChair1.setTexture(imgChair);
  shapeChair1.setStrokeWeight(0);

  shapeChair2 = createShape(BOX, 100, 20, 120);
  shapeChair2.setTexture(imgChair);
  shapeChair2.setStrokeWeight(0);

  shapeChair3 = createShape(BOX, 20, 90, 120);
  shapeChair3.setTexture(imgChair);
  shapeChair3.setStrokeWeight(0);

  shapeHome = createShape(BOX, 1000, 800, 1000);
  shapeHome.setTexture(imgBrick);
  shapeHome.setStrokeWeight(0);

  // Camera variable
  camZ = (height/2) / tan((PI*60.0)/360.0);
  

  // Creation of the smoke
  for (int i = 0; i < 10; i++)
  {
    particles.add(new Smoke());
  }
  
}

// Variables for animation and camera
float frm = 0;
float camZ = 0;


// Smoke particle array declaration
ArrayList<Smoke> particles = new ArrayList<Smoke>();


void draw() {



  // -----Camera------ // 
  
  camera(0, -125, camZ, 
    0, 100, -600, 
    0, 1, 0);

  if (keyPressed)
  {
    if (keyCode == UP)
      camZ -= 35;
    if (keyCode == DOWN)
      camZ += 35;
  }

  rotateX(rotX + distY);
  rotateY(rotY + distX);

  // -----Camera------ // 
  


  background(imgSky);



  // -----Shapes------ // 

  // Left Chair
  pushMatrix();
  translate(-250, 200, -600);
  shape(shapeChair1);
  translate(60, 0);
  shape(shapeChair2);
  translate(40, 55);
  shape(shapeChair3);
  popMatrix();


  // Right Chair
  pushMatrix();
  translate(250, 200, -600);
  scale(-1, 1);
  shape(shapeChair1);
  translate(60, 0);
  shape(shapeChair2);
  translate(40, 55);
  shape(shapeChair3);
  popMatrix();
  

  // Table
  pushMatrix();
  translate(0, 140, -600);
  shape(shapeTable1);
  translate(0, 85);
  shape(shapeTable2);
  popMatrix();
  
  
  //The body of the home
  push();
  translate(0, -100, -600);
  shape(shapeHome);
  pop();

  // -----Shapes------ // 
  
  
  
  

  // -----Animation objects------ // 

  // Right Mug
  push();
  translate(80, 50, -580);
  drawMug(img2, 0);
  pop();

  // Left Mug
  push();
  translate(-80, 50, -580);
  rotateY(radians(180));
  drawMug(img1, 150);
  pop();
  

  // Guy who is at rightside
  pushMatrix();
  translate(200, -50, -600);
  //shape(sekil3);
  translate(0, 50, 0);
  drawStickMen(0);
  fill(#DBCD61);
  popMatrix();

  // Guy who is at leftside
  pushMatrix();
  translate(-200, -50, -600);
  //shape(sekil8);
  translate(0, 50, 0);
  scale(-1, 1);
  drawStickMen(150);
  fill(#DBCD61);
  popMatrix();
  
  // Disco lamp at İnside of the house
  push();
  translate(0, -280, -600);
  scale(5);
  fill(random(256), random(256), random(256));
  noStroke();
  sphere(12);
  pop();

  push();
  translate(0, -400, -600);
  noStroke();
  fill(#078493);
  scale(5);
  box(5, 35, 5);
  pop();
  
  
  
  
  // Wall with background which has Kaan's head on it.
  push();
  translate(0, -100, -1080);
  noStroke();
  scale(500, 400);
  myOwnBrick(imgCoffee);
  pop();

  // Door texture
  push();
  translate(0, 38, -98);
  rotateZ(radians(0));
  noStroke();
  scale(220, 260, 5);
  myOwnBrick(imgDoor); 
  pop();

  // Floor with grass texture.
  push();
  translate(0, 290, -600);
  rotateX(radians(90));
  noStroke();
  scale(500, 500);
  myOwnBrick(imgGrass);
  pop();

  // Rock texture
  push();
  translate(0, 302, -600);
  rotateX(radians(90));
  noStroke();
  scale(1500, 1500);
  myOwnBrick(imgRock);
  pop();



  // -----Animation objects------ // 

  // We increase frm variable for animating objects.
  frm += 1;
}

// Camera variables
float rotX = 0, rotY = 0;
float lastX, lastY;
float distX, distY;



// -----Camera controls------ // 

void mousePressed()
{
  lastX = mouseX;
  lastY = mouseY;
}

void mouseDragged()
{
  distX = radians(mouseX - lastX);
  distY = radians(lastY - mouseY);
}

void mouseReleased()
{
  rotX += distY;
  rotY += distX;
  distX = distY = 0;
}

// -----Camera controls------ // 



// -----Wall grass, door and rock draw function------ // 

void myOwnBrick(PImage img)
{
  int w = img.width;
  int h = img.height;
  beginShape(QUADS);
  texture(img);
  textureMode(IMAGE);

  //+Z Face
  vertex(1, -1, 1, w, 0); //upper right corner
  vertex(1, 1, 1, w, h); //bottom right corner
  vertex(-1, 1, 1, 0, h); //bottom left corner
  vertex(-1, -1, 1, 0, 0); //upper left corner

  //-Z Face
  vertex(1, -1, -1, w, 0); //upper right corner
  vertex(1, 1, -1, w, h); //bottom right corner
  vertex(-1, 1, -1.0001, 0, h); //bottom left corner
  vertex(-1, -1, -1.0001, 0, 0); //upper left corner
  endShape();

  //+Y Face
  vertex(-1, 1, 1); //upper right corner
  vertex(1, 1, 1); //bottom right corner
  vertex(1, 1, -1); //bottom left corner
  vertex(-1, 1, -1); //upper left corner

  //-Y Face
  vertex(-1, -1, 1); //upper right corner
  vertex(1, -1, 1); //bottom right corner
  vertex(1, -1, -1); //bottom left corner
  vertex(-1, -1, -1); //upper left corner

  //+X Face
  vertex(1, -1, 1); //upper right corner
  vertex(1, 1, 1); //bottom right corner
  vertex(1, 1, -1); //bottom left corner
  vertex(1, -1, -1); //upper left corner

  //-X Face
  vertex(-1, -1, 1); //upper right corner
  vertex(-1, 1, 1); //bottom right corner
  vertex(-1, 1, -1); //bottom left corner
  vertex(-1, -1, -1); //upper left corner

  //+X, -X, +Y, -Y

  endShape();
}

// -----Wall grass, door and rock draw function------ // 




// -----Stick man draw function------ // 

void drawStickMen(int offset)

{ 

  // Drawing head
  push();

  float x, y, z;
  translate(0, -30, 0);
  float arc;

  // When the guy drop the mug to the table his mouth opens more.
  if(frm < 1500) {
    if ((frm - offset)%300 >= 150 && (frm < 1500)) arc = 3*PI/4;
    else arc = 10*PI/12;
  }
  else arc = PI;

  // We rotate the head 90 degrees because the head looks up
  rotateZ(PI / 2);

  // Drawing head pieces
  for (float i = 0.0; i < arc; i += TWO_PI / 20.0) {
    beginShape(QUAD_STRIP);


    // Vertical pieces
    for (float j = 0.0; j < TWO_PI + TWO_PI / 20.0; j += TWO_PI / 20.0) {
      x = 50.0 * sin(i) * cos(j);
      z = 50.0 * sin(i) * sin(j);
      y = -50.0 * cos(i);

      vertex(x, y, z);

      x = 50.0 * sin(i + TWO_PI / 20.0) * cos(j);
      z = 50.0 * sin(i + TWO_PI / 20.0) * sin(j);
      y = -50.0 * cos(i + TWO_PI / 20.0);

      vertex(x, y, z);
    }
    endShape(CLOSE);
  }

  pop();



  // Body of stickman
  translate(0, 80);
  box(20, 200, 30);
  translate(-60, 10, -20);

  // Drinking animation
  push();
  translate(50, 0, 0);
  rotateX(radians(334));

  // Rotating hand for drinking
  if (frm < 1500) {
    if ((frm%300 - offset) >= 50 && (frm%300 - offset) <= 100) rotateZ(radians(50));
    else if ((frm%300 - offset) > 100 && (frm%300 - offset) < 150) rotateZ(radians((150 - (frm%300 - offset))));
    else if ((frm%300 - offset) >= 150) rotateZ(radians(0));
    else if ((frm%300 - offset) >= 0 && (frm%300 - offset) < 50) rotateZ(radians((frm%300 - offset)));
  }

  translate(-50, 0, 0);
  box(100, 15, 10);
  pop();
  

  // Drawing limbs

  translate(0, 0, 50);
  push();
  translate(50, 0, 0);
  rotateY(radians(45));
  rotateZ(radians(341));
  translate(-50, 0, 0);
  box(100, 15, 10);
  pop();


  translate(20, 90, -5);
  box(100, 20, 20);
  translate(0, 0, -50);
  box(100, 20, 20);
  translate(-60, 50, 0);
  box(20, 120, 20);
  translate(0, 0, 50);
  box(20, 120, 20);
}

// -----Stick man draw function------ // 





// -----Mug draw function------ // 

void drawMug(PImage img, int offset) {

  float angle = 0;
  float angle2 = 0;

  int pieces = 12; 
  int increaseAngle = 360 / pieces;
  int r = 30;
  int h = 80;
  int w = img.width;

  // Drinking animation
  push();
  translate(120, 0, -20);

  // Lifting mug
  if (frm < 1500) {
    if ((frm%300 - offset) >= 50 && (frm%300 - offset) <= 100) rotateZ(radians(50));
    else if ((frm%300 - offset) > 100 && (frm%300 - offset) < 150) rotateZ(radians((150 - (frm%300 - offset))));
    else if ((frm%300 - offset) >= 150) rotateZ(radians(0));
    else if ((frm%300 - offset) >= 0 && (frm%300 - offset) < 50) rotateZ(radians((frm%300 - offset)));
  }
  translate(-120, 0, 20);

  // Cylinder shape of the mug
  beginShape(QUADS);
  texture(img);
  tint(255, 128);
  for (int i = 0; i < pieces; i++)
  {
    vertex(r * cos(radians(i * increaseAngle)), 0, r * sin(radians(i * increaseAngle)), i * w / pieces, 0);
    vertex(r * cos(radians((i + 1)*increaseAngle)), 0, r * sin(radians((i + 1)*increaseAngle)), (i+1) * w / pieces, 0);
    vertex(r * cos(radians((i + 1)*increaseAngle)), h, r * sin(radians((i + 1)*increaseAngle)), (i+1) * w / pieces, img.height);
    vertex(r * cos(radians(i * increaseAngle)), h, r * sin(radians(i * increaseAngle)), i * w / pieces, img.height);
  }
  endShape();

  // Coffee itself
  if ((frm + 100 - offset) < 1650) {

    push();
    fill(#4a2c2b);

    // Drawing smoke on coffee
    for (int i = 0; i < 10 - frm/150; i++)
    {
      particles.get(i).drawSmoke();
    }


    translate(0, -10 + 10 * (int((frm + 200 - offset)/300)));
    rotateX(radians(90));
    beginShape();
    for (int i=0; i<=18; i++) {
      float  px = cos(radians(angle2))*30;
      float  py = sin(radians(angle2))*30;
      vertex(px, py, -39);
      angle2+=30;
    }
    endShape();

    pop();
  }

  // Base of mug
  push();
  translate(0, 39);
  rotateX(radians(90));
  beginShape(POLYGON);
  for (int i=0; i<=18; i++) {
    float  px = cos(radians(angle))*30;
    float  py = sin(radians(angle))*30;
    vertex(px, py, -40);
    angle+=30;
  }
  endShape();

  pop();


  // Handle of the mug
  push();
  fill(0);
  rotateX(radians(90));

  translate(30, 0, -60);
  box(25, 5, 5);
  translate(15, 0, 15);
  box(5, 5, 35);
  translate(-15, 0, 15);
  box(25, 5, 5);

  pop();

  pop();
}

// -----Mug draw function------ // 





// -----References------ //

// Images

// https://slm-assets.secondlife.com/assets/16766271/lightbox/Grassy_Squares.jpg?1490765332
// https://data2.polantis.com/image1000/data/699/24617/Brick%20Texture%2086_3D_p.png
// https://graphicriver.img.customer.envatousercontent.com/files/121104.jpg?auto=compress%2Cformat&fit=crop&crop=top&w=590&h=590&s=ecb72e4e9e6a563a2a3f5d112d7f9222
// https://www.energy.gov/energysaver/design/windows-doors-and-skylights/doors
// https://siegmundlandscape.com/3-4-4-round-rock/
// https://cdna.artstation.com/p/assets/images/images/009/647/682/medium/martin-novak-wood-texture.jpg?1520148399
// https://joya.info/en/blog/why-you-should-drink-your-coffee-with-plant-based-milk-438883
// https://miro.medium.com/max/1838/1*bMoO0i3dwcPEDS2zAhBjjw.jpeg


// https://forum.processing.org/two/discussion/13353/creating-arc-sections-in-3d
