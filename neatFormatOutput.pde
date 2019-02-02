void neatFormatOutput(String filename) {
  //float with long formatting for Repeated Measures ANOVA

  float[][] neatFormat = new float[5520][6]; // <--------------------- make sure this is correct (divide by 4 or not, depending on what should be exported


  //Amp    11111 11111 11111 11111 22222 22222 22222 22222 11111 11111 11111 11111
  //Tmbr   11111 22222 33333 44444 11111 22222 33333 44444 11111 22222 33333 44444 
  //Gran   12345 12345 12345 12345 12345 12345 12345 12345 12345 12345 12345 12345 

  for (int i = 0; i < neatFormat.length; i++) {


    neatFormat[i][0] = int(i/240)%23; //participant
    neatFormat[i][1] = int(i/60)%4; //experience <-------------------------------------change this (and also below at index 5)
    neatFormat[i][2] = int(i/20)%3; //amplitude
    neatFormat[i][3] = int(i/5)%4; //timbre
    neatFormat[i][4] = int(i%5); //granularity
    neatFormat[i][5] = standardizedData[int(i/240)%23][int(i/60)%4][int(i/5)%4][i%5][int(i/20)%3];

    print(i);
    print(" - Participant: ");
    print(int(i/240)%23);
    print(" Experience: ");
    print(int(i/60)%4); // <-------------------------------------use this
    print(" Amplitude: ");
    print(int(i/20)%3);
    print(" timbre: ");
    print( int(i/5)%4);
    print(" granularity: ");
    print(int(i%5));
    print(" - - - - Estimate: ");
    print( neatFormat[i][5]);
    println();
  }

  String dataToWrite = "Participant, Experience, Amplitude, Timbre, Granularity, Estimate";
  appendTextToFile("neat/"+filename+".csv", dataToWrite + "\r\n");
  for (int i = 0; i < neatFormat.length; i++) {
    dataToWrite = "";
    dataToWrite = dataToWrite + neatFormat[i][0] + ", ";
    dataToWrite = dataToWrite + experienceTypes[int(neatFormat[i][1])] + ", ";
    dataToWrite = dataToWrite + amplitudeLevels[int(neatFormat[i][2])] + ", ";
    dataToWrite = dataToWrite + timbreLevels[int(neatFormat[i][3])] + ", ";
    dataToWrite = dataToWrite + granularityLevels[int(neatFormat[i][4])] + ", ";
    dataToWrite = dataToWrite + neatFormat[i][5];

    appendTextToFile("neat/"+filename+".csv", dataToWrite + "\r\n");
  }
  println("finished_writing");
}