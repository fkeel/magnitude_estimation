

float standardDeviationAbs(float[] data) {
  int n = 0;
  float total = 0;  
  float variance = 0;
  float sd;
  float average = meanAbs(data);

  for (int i = 0; i < data.length; i++) {
    total = total + sq(data[i]-average);
    n++;
  }

  variance = total / n-1; 
  sd = sqrt(variance);
  return sd;
}

float slope(float[] dataX, float[] dataY) {
  //x independent
  //y dependent
  // slope = ( n*sum(x*y)-sum(x)*sum(y) ) / n*sum(squared(x)) - squared(sum(x))

  if (dataX.length != dataY.length) { 
    println("ERROR - X and Y arrays not equal length. Cannot calculate slope");
  }

  float slope;
  float sumX = 0;
  float sumY= 0;
  float sumXsquared= 0;
  float sumXY= 0;
  float n = 0;

  for (int i = 0; i < dataX.length; i++) {
    sumX = sumX + dataX[i];
    sumY = sumY + dataY[i];
    sumXsquared = sumXsquared + dataX[i]*dataX[i];
    sumXY= sumXY + dataX[i]*dataY[i];
    n = n + 1;
  }

  slope = (n * sumXY - sumX * sumY) / (n * sumXsquared - sumX*sumX);

  return slope;
}


float intercept(float[] dataX, float[] dataY) {
  //x independent
  //y dependent
  // intercept = ((sum(y)*sum(squared(x)) - sum(x)*sum(x*y)) / n*sum(squared(x)) - squared(sum(x))

  float intercept;
  float sumX = 0;
  float sumY= 0;
  float sumXsquared= 0;
  float sumXY= 0;
  float n = 0;

  for (int i = 0; i < dataX.length; i++) {
    sumX = sumX + dataX[i];
    sumY = sumY + dataY[i];
    sumXsquared = sumXsquared + dataX[i]*dataX[i];
    sumXY= sumXY + dataX[i]*dataY[i];
    n = n + 1;
  }

  intercept = (sumY * sumXsquared - sumX * sumXY) / (n * sumXsquared - sumX*sumX);

  return intercept;
}

float correlation(float[] dataX, float[] dataY) {

  float correlation;
  float sumXdeviation = 0;
  float sumYdeviation = 0;
  float meanX = 0;
  float meanY = 0;
  float sdX = 0;
  float sdY = 0;
  float n = 0;

  meanX = mean(dataX);
  meanY = mean(dataY);
  sdX = standardDeviation(dataX);
  sdY = standardDeviation(dataY);

  for (int i = 0; i < dataX.length; i++) {
    sumXdeviation = sumXdeviation + dataX[i] - meanX;
    sumYdeviation = sumYdeviation + dataY[i] - meanY;
    n = n + 1;
  }

  correlation = (sumXdeviation *  sumYdeviation) / (sdX * sdY);

  return correlation;
}

float[] simpleSmooth(float[] data) {
  data[0] = (data[0]*2+data[1])/3;
  for (int i = 1; i < data.length-1; i++) {
    data[i] = (data[i-1]+data[i+1]+data[i])/3;
  }
  data[data.length-1] =  (data[data.length-2] +  data[data.length-1]*2)/3; 

  return data;
}

float mean(float[] data) {
  int counter = 0;
  float total = 0;
  for (int i = 0; i < data.length; i++) {
    if (Float.isNaN(data[i])) {
      //     print(" (Ignoring invalid number for average) ");
    } else {
      total = total+ data[i];
      // println("total of: " + data[i]);
      counter++;
    }
  }
  float mean = total / counter;
  return mean;
}

float mean(float[][] data) {
  int counter = 0;
  float total = 0;
  for (int i = 0; i < data.length; i++) {
    for (int y = 0; y < data[i].length; y++) {
      if (Float.isNaN(data[i][y])) {
        //      print(" (Ignoring invalid number for average) ");
      } else {
        total = total+ data[i][y];
        // println("total of: " + data[i]);
        counter++;
      }
    }
  }
  float mean = total / counter;
  return mean;
}

float mean(float[][][] data) {
  int counter = 0;
  float total = 0;
  for (int i = 0; i < data.length; i++) {
    for (int y = 0; y < data[i].length; y++) {
      for (int z = 0; z < data[i][y].length; z++) {
        if (Float.isNaN(data[i][y][z])) {
          //      print(" (Ignoring invalid number for average) ");
        } else {
          total = total+ data[i][y][z];
          // println("total of: " + data[i]);
          counter++;
        }
      }
    }
  }
  float mean = total / counter;
  return mean;
}


float standardDeviation(float[] data) {
  int counter = 0;
  float total = 0;  
  float variance = 0;
  float sd;
  float average = mean(data);

  for (int i = 0; i < data.length; i++) {
    //   println("sq of: " + data[i]);
    total = total + sq(data[i]-average);
    counter++;
  }

  variance = total / (counter-1); //(counter - 1) because its the sample SD
  sd = sqrt(variance);
  return sd;
}

float standardDeviation(float[][] data) { //update for missing values
  int counter = 0;
  float total = 0;  
  float variance = 0;
  float sd;
  float average = mean(data);

  for (int i = 0; i < data.length; i++) {
    for (int y = 0; y < data[i].length; y++) {      
      total = total + sq(data[i][y]-average);
      counter++;
    }
  }

  variance = total / ((data.length-1) * (data[1].length-1)); //data can vary in two dimensions
  sd = sqrt(variance);
  return sd;
}
//------------------------------------MAYBE I NEED DIFFERENT FUNCTIONS FOR Sum of Squares and SD?

float standardDeviation(float[][][] data) { //update for missing values  (meansum square?)
  int counter = 0;
  float total = 0;  
  float variance = 0;
  float sd;
  float average = mean(data);
  println("--------------------------------------------------------Mean is " + average);

  for (int i = 0; i < data.length; i++) {
    for (int y = 0; y < data[i].length; y++) {   
      for (int z = 0; z < data[i][y].length; z++) { 
        if (Float.isNaN(data[i][y][z])) {
          print("Calculating SD (three dimensions) is Ignoring invalid number for average) ");
        } else {
          total = total + sq(data[i][y][z]-average);
          counter++;
        }
      }
    }
  }

  variance = total / ((data.length-1) * (data[1].length-1) * (data[1][1].length-1)); //data can vary in THREE dimensions
  sd = sqrt(variance);
  println("--------------------------------------------------------SD is " + sd);
  return sd;
}

float meanAbs(float[] data) { //average of absolute values
  int counter = 0;
  float total = 0;
  for (int i = 0; i < data.length; i++) {
    total = total+ abs(data[i]);
    counter++;
  }
  float meanOfAbs = total / counter;
  return meanOfAbs;
}


float confidenceInterval(float[] data, float interval) { //this needs updating for DF, they are currently hardcoded 
  float ci;
  int n = data.length;
  float sd = standardDeviation(data);
  ci = interval * 2.228 * (sd/sqrt(n)); //assumes 1.96
  return ci;
}

//for touchlocators
int previous(int current) {
  int previous = current-1;
  if (previous < 0) {
    previous = current; //this is a dodgy assumption, needs exploration
  }

  return previous;
}

int next(int current, float[] stripValues) {
  int next = current + 1;
  if (next > stripValues.length-1) {
    next = stripValues.length-1; //ditto
  }
  return next;
}