
//-----------------------------------------------------------
// Damage, please don't change settings here;
// to make changes, please go to cellular_automaton
//-----------------------------------------------------------

boolean damagePossibility = false;

int chance;

float selectedCellRedDmg;
float selectedCellGreenDmg;

int[] potholeLocationX, potholeLocationY;
int counter = 0;

int spreadChance;


// MAIN FUNCTION

void surfaceDamage(color[][] cells, color[][] cellsNext, int i, int j) {
  
  selectedCellRedDmg = red(cells[i][j]);
  selectedCellGreenDmg = green(cells[i][j]);
  
  if (damagePossibility == true){
    chance = int(random(0,(roadQuality * 5000) - amountOfTraffic * 100));
  }
  
  if (chance == 1){

    if (selectedCellRed < 254.0){
      cells[i][j] = color(selectedCellRedDmg+100, selectedCellGreenDmg, 0);
      cellsNext[i][j] = color(selectedCellRedDmg+100, selectedCellGreenDmg, 0);
      potholeLocationX[counter] = j;
      potholeLocationY[counter] = i;
    }
  
    else if (selectedCellRed >= 254.0){
      cells[i][j] = color(selectedCellRedDmg, selectedCellGreenDmg-100, 0);
      cellsNext[i][j] = color(selectedCellRedDmg, selectedCellGreenDmg-100, 0);
      potholeLocationX[counter] = j;
      potholeLocationY[counter] = i;
    }
 
    else{
      println("something is not working in damage");
    }
    
    println(potholeLocationX[counter]);
    println(potholeLocationY[counter]);
    counter = counter + 1;
  }
  
  
  // if the cell is infected:
  for (int z = 0; z < potholeLocationX.length; z++){
    if (j == potholeLocationX[z] && i == potholeLocationY[z]){
      for(int c = -3; c <= 3; c++) {  
        for(int d = -2; d <= 2; d++) {  
          spreadChance = int(random(0,250));
    
          try{
            if (spreadChance == 1){
              if (selectedCellRed < 254.0){
                cells[i+c][j+d] = color(selectedCellRedDmg, selectedCellGreenDmg, 0);
                cellsNext[i+c][j+d] = color(selectedCellRedDmg, selectedCellGreenDmg, 0);
              }
            
              else if (selectedCellRed >= 254.0){
                cells[i+c][j+d] = color(selectedCellRedDmg, selectedCellGreenDmg, 0);
                cellsNext[i+c][j+d] = color(selectedCellRedDmg, selectedCellGreenDmg, 0);
              }
            }
          }  
    
          catch(IndexOutOfBoundsException e){
          }
        }    
      }
    }
  }
}


// SUB FUNCTIONS

void damageBegin(){
  if (timerCounter == (roadQuality*52)/8){
    damagePossibility = true;
  }
}
