import processing.opengl.*;

Table table;

float value[] = new float[15 * 27]; 

ColorMap cm = new ColorMap();

PVector[] vecs = new PVector[405];
int dim = 255;

void setup(){
  size(1100, 729, OPENGL);
  for (int i=0; i<vecs.length; i++) {
    vecs[i] = new PVector(random(dim),random(dim),random(dim));
  }
}

void draw(){
  background(0);
  
  table = loadTable("../data.csv");
  
  if(table.getRowCount() > 0){
    TableRow row = table.getRow(0);
    for(int i = 0; i < value.length; i++){
      if(row.getColumnCount() >= i+2){
        try{
        value[i] = row.getFloat(i+2);
        value[i] = map(value[i], -10, 300, 0, 255);
        }catch(ArrayIndexOutOfBoundsException e){
          println("read/write conflict");
        }
      }
    }
  }
  fill(255);
  textSize(30);
  text("2D view", 100, 80);
  float size = 20;
  noFill();
  stroke(255);
  strokeWeight(1);
  rect(100, 100, 15*size, 27*size);
  for(int i=0; i < 15; i++){
    for (int j = 0; j < 27; j++){
      
      //int[] rgb = cm.getColor((float)((value[j*15+i])/500.0));
      //fill(rgb[0], rgb[1], rgb[2]);
      noStroke();
      fill(value[j*15+i]);
      rect(i*size + 100, j * size + 100, size-2, size-2);
    }
  }
  
  // draw 3D stuff
  fill(255);
  textSize(30);
  text("3D view", 650, 80);
  stroke(255);
  strokeWeight(3);
  
  translate(800,height/2);
  scale(1,-1,1); // so Y is up, which makes more sense in plotting
  rotateX(radians(45));
  //rotateZ(radians(45));
 
  noFill();
  strokeWeight(1);
  int bsize = 20;
 
  translate(-dim/2,-dim/2,-dim/2 - 200);
  
  for (int i=0; i<vecs.length; i++) {
    
    int z = (int)(i/15)*bsize;
    int x = (int)(i%15)*bsize;
    int y = (int)(value[i]);
      

    stroke(255);
    strokeWeight(1);
    line(x, 0, z, x, y ,z);
    
    int[] rgb = cm.getColor((float)(value[i] / 400));
    stroke(rgb[0], rgb[1], rgb[2]);
    strokeWeight(12);
    point(x,y,z);
  }
}
