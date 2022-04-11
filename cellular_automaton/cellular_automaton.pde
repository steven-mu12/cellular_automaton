// --------------------------------------
// -----Degradation of Asphalt Roads-----
// -----ICS4UI Project By Steven Mu------
// --------------------------------------

// Global Variables (settings that can be changed)

int w = 100; // the width of the road. The bigger this number, the better the details of the damage.
float genPerSec = 30; //how many generations or "weeks" per second
int offset = 150; // the offset from the left and right of the screen

int roadQuality = 5; // the quality of the road, used in degration due to quality and damage
int selectedLatitude = 50; // the latitude location of the road, used in degration due to weather
int chanceOfPrecipitation = 33; // the chance of precipitation, from 0-100, used in degration due to weather
int amountOfTraffic = 50; // the amount of traffic (ranging from 0-100), used in degration due to traffic

// things that shouldn't be changed

color[][] cells, cellsNext;
float cellSize;
int rowCount;

int y;
int time = 13;
int timerCounter = 0;


// MAIN FUNCTIONS

void setup(){
  size(1000, 600); 
  frameRate(genPerSec);
  background(255);
  
  cellSize = (width-offset*2)/w;
  rowCount = int(height / cellSize) + 1;
  
  cells = new color[rowCount][w];
  cellsNext = new color[rowCount][w];
  
  // finds thickness and initializes the arrays
  findThickness();
  leftWheelIndex = new int[thickness];
  rightWheelIndex = new int[thickness];
  
  // the arrays for the locations of the damage
  potholeLocationX = new int [rowCount * w];
  potholeLocationY = new int [rowCount * w];
 
  // initializes the road to be green
  initRoad();
  drawTimer();
  
  // finds the heatLevel (used for weather degration)
  findHeatLevel(selectedLatitude);
  
  // find the left and right wheel locations
  findLeftWheel();
  findRightWheel();
  findTrafficDegration();
}


void draw(){
  background(255);
  
  drawRoad();
  drawTimer();
  
  timerCounter = timerCounter + 1;
  if (timerCounter % 13 == 0){
    time = time + 13;
  }
  
  setNextGen(cells, cellsNext);
  copyToNextGen(cells, cellsNext);
}


// SUB FUNCTIONS

// draws the information box 
void drawTimer(){
  fill(200);
  stroke(2);
  rect(offset/2+w*cellSize, 0, offset+offset/2, width/6);
  
  fill(0);
  textSize(24);
  text("Week / Gen: ", offset/2+w*cellSize+offset/10, 24+offset/10);
  
  textSize(48);
  text(timerCounter, offset/2+w*cellSize+offset/10, 72+offset/9);
  
  textSize(24);
  text("Weather: " + weather, offset/2+w*cellSize+offset/10, 96+offset/9);
  textSize(24);
  text("Season: " + season, offset/2+w*cellSize+offset/10, 120+offset/9);
}



// initializes the road
void initRoad(){
  color startingGreen = color(0,255,0);

  
  for(int i=0; i<rowCount; i++){
    for(int j=0; j<w; j++) {
      cells[i][j] = startingGreen;
      float x = offset/2 + j*cellSize;
      fill(cells[i][j]);
      stroke(0);
      square(x, y, cellSize);
    }
    y += cellSize;
  }
}


// draws the updated roads
void drawRoad(){
  y = 0;
  
  for(int i=0; i<rowCount; i++) {
    for(int j=0; j<w; j++) {
      float x = offset/2 + j*cellSize;
      fill(cells[i][j]);        
      square(x, y, cellSize);
    }
    y += cellSize;
  }
}


// sets the next generation based on the different factors
void setNextGen(color[][] cells, color[][] cellsNext){
  y = 0;
  
  // these only need to set once per generation, and applies to all the cells
  findSeason(time);
  findChanceOfPrecipitation();
  snowOrNot();
  damageBegin();
  
  // this actually goes through all the cells and applies the damage
 
  for(int i=0; i<rowCount; i++){
    for(int j=0; j<w; j++){
      degrationDueToQuality(cells, cellsNext, i, j); // you can commment this line out to disable degrationDueToQuality
      degrationDueToWeather(cells, cellsNext, i, j); // you can commment this line out to disable degrationDueToWeather
      degrationDueToTraffic(cells, cellsNext, i, j); // you can commment this line out to disable degrationDueToTraffic
      surfaceDamage(cells, cellsNext, i, j); // you can comment this line out to disable surfaceDamage
    }
    y += cellSize;
  } 
}


// copies the new generation and gets it ready for displaying
void copyToNextGen(color[][] cells, color[][] cellsNext) {
    for(int i=0; i<rowCount; i++) 
      for(int j=0; j<w; j++) 
        cells[i][j] = cellsNext[i][j];
}
