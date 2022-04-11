
//-----------------------------------------------------------
// Traffic Factor, please don't change settings here;
// to make changes, please go to cellular_automaton
//-----------------------------------------------------------

int thickness;
int offsetFromEdges;

float totalDegrationDueToTraffic;
float selectedCellRedTraffic;
float selectedCellGreenTraffic;

int[] leftWheelIndex, rightWheelIndex;


// THE MAIN FUNCTION

void degrationDueToTraffic(color[][] cells, color[][] cellsNext, int i, int j){ 
  
  selectedCellRedTraffic = red(cells[i][j]);
  selectedCellGreenTraffic = green(cells[i][j]);
  
  for (int m = 0; m < thickness; m++) {
    if (leftWheelIndex[m] == j || rightWheelIndex[m] == j){

        if (selectedCellRed < 254.0){
          // increment red
          cells[i][j] = color(selectedCellRedTraffic+totalDegrationDueToTraffic, selectedCellGreenTraffic, 0);
          cellsNext[i][j] = color(selectedCellRedTraffic+totalDegrationDueToTraffic, selectedCellGreenTraffic, 0);
          
        }
        
        else if (selectedCellRed >= 254.0){
          // increment green
          cells[i][j] = color(selectedCellRedTraffic, selectedCellGreenTraffic-totalDegrationDueToTraffic, 0);
          cellsNext[i][j] = color(selectedCellRedTraffic, selectedCellGreenTraffic-totalDegrationDueToTraffic, 0);
        }
       
        else{
          println("something is not working in traffic");
        }
    }
  }
}


// SUB FUNCTIONS

// this will need to run literally once
void findThickness(){
  thickness = w/7;
  offsetFromEdges = thickness*2-thickness/4;
}

void findLeftWheel(){
  for (int a=0; a<thickness; a++){
    leftWheelIndex[a] = offsetFromEdges + a;
  }
}

void findRightWheel(){
  for (int b=0; b<thickness; b++){
    rightWheelIndex[b] = w - offsetFromEdges - 1 - b;
  }
}

void findTrafficDegration(){
  
  if (amountOfTraffic == 0){
    totalDegrationDueToTraffic = 0;
  }
  else if (amountOfTraffic <= 25){
    totalDegrationDueToTraffic = 0.2;
  }
  else if (amountOfTraffic > 25 && amountOfTraffic <= 50){
    totalDegrationDueToTraffic = 0.4;
  }
  else if (amountOfTraffic > 50 && amountOfTraffic <= 75){
    totalDegrationDueToTraffic = 0.6;
  }
  else if (amountOfTraffic > 75){
    totalDegrationDueToTraffic = 0.8;
  }
}
