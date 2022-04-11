
//-----------------------------------------------------------
// Quality Factor, please don't change settings here;
// to make changes, please go to cellular_automaton
//-----------------------------------------------------------

int totalPossibleChange = 255+255;
int totalWeeks = roadQuality * 52;

float colorAmountToIncrement = totalPossibleChange / totalWeeks;
float selectedCellRed;
float selectedCellGreen;

// MAIN FUNCTION
void degrationDueToQuality(color[][] cells, color[][] cellsNext, int i, int j){
  selectedCellRed = red(cells[i][j]);
  selectedCellGreen = green(cells[i][j]);
  
  //println(selectedCellRed);
  //println(selectedCellGreen);
  
  // checks for max values
  if (selectedCellRed < 254.0){
    // increment red
    cells[i][j] = color(selectedCellRed+colorAmountToIncrement, selectedCellGreen, 0);
    cellsNext[i][j] = color(selectedCellRed+colorAmountToIncrement, selectedCellGreen, 0);
    
  }
  
  else if (selectedCellRed >= 254.0){
    // increment green
    cells[i][j] = color(selectedCellRed, selectedCellGreen-colorAmountToIncrement, 0);
    cellsNext[i][j] = color(selectedCellRed, selectedCellGreen-colorAmountToIncrement, 0);
  }
 
  else{
    println("something is not working in quality");
  }
}
