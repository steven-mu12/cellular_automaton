
//-----------------------------------------------------------
// Weather Factor, please don't change settings here;
// to make changes, please go to cellular_automaton
//-----------------------------------------------------------

int heatLevel;
int currentSeason; // keeps track of weather

boolean precipitation = false;
boolean snow = false; 
int hemisphere;
float precipChance;

String weather;
String season;

float selectedCellRedWeather;
float selectedCellGreenWeather;

int totalDegration;

// MAIN FUNCTION

void degrationDueToWeather(color[][] cells, color[][] cellsNext, int i, int j){
  totalDegration = 0;
  
  selectedCellRedWeather = red(cells[i][j]);
  selectedCellGreenWeather = green(cells[i][j]);
  
  if (snow == true && precipitation == true){
    totalDegration = 2;
    weather = "snow";
  }
  else if (snow == false && precipitation == true){
    totalDegration = 1;
    weather = "rain";
  }
  else if (precipitation == false){
    totalDegration = 0;
    weather = "clear";
  }
  else{
    println("something is not working in weather");
  }
  
  // APPLY THE DEGRATION
  
  if (selectedCellRed < 254.0){
    // increment red
    cells[i][j] = color(selectedCellRedWeather+totalDegration, selectedCellGreen, 0);
    cellsNext[i][j] = color(selectedCellRedWeather+totalDegration, selectedCellGreen, 0);
    
  }
  
  else if (selectedCellRed >= 254.0){
    // increment green
    cells[i][j] = color(selectedCellRed, selectedCellGreenWeather-totalDegration, 0);
    cellsNext[i][j] = color(selectedCellRed, selectedCellGreenWeather-totalDegration, 0);
  }
 
  else{
    println("something is not working in weather");
  }
}


// SUB FUNCTIONS

void findSeason(int time){
  if ((time / 13) % 4 == 1){
    // spring
    currentSeason = 0;
    season = "Spring";
  }
  
  else if ((time / 13) % 4 == 2){
    //summer
    currentSeason = 1;
    season = "Summer";
  }
  
  else if ((time / 13) % 4 == 3){
    // fall
    currentSeason = 2;
    season = "Fall";
  }
  
  else if ((time / 13) % 4 == 0){
    // winter
    currentSeason = 3;
    season = "Winter";
  }
}

void findHeatLevel(int selectedLatitude){
  hemisphere = 90 - selectedLatitude;
  
  if (hemisphere < 0){
    // southern hemisphere
    heatLevel = hemisphere + 90;
  }
  else if (hemisphere > 0){
    // northern hemisphere
    heatLevel = selectedLatitude;
  }
  else if (hemisphere == 90){
    // it's on the equator
    heatLevel = 90;
  }
}

void findChanceOfPrecipitation(){
  precipChance = random(0, 100);
  
  if (precipChance >= 0 && precipChance <= chanceOfPrecipitation){
    precipitation = true;
  }
  
  else {
    precipitation = false;
  }
}



void snowOrNot(){
  if (heatLevel <= 15) {
    // in every season but summer, snow
    if (currentSeason == 0 || currentSeason == 2 || currentSeason == 3){
      snow = true;
    }
    else if (currentSeason == 1){
      snow = false;
    }
    
  }
  
  else if (heatLevel >= 75) {
    // no snow
    snow = false;
  }
  
  else{
    // only snow during the winter
    if (currentSeason == 3){
      snow = true;
    }
    else{ 
      snow = false;
    }
  }
}
