
void longFormatOutput() {
  //float with long formatting for Repeated Measures ANOVA

  float[][] longFormat = new float[24][60];


  //Amp    11111 11111 11111 11111 22222 22222 22222 22222 11111 11111 11111 11111
  //Tmbr   11111 22222 33333 44444 11111 22222 33333 44444 11111 22222 33333 44444 
  //Gran   12345 12345 12345 12345 12345 12345 12345 12345 12345 12345 12345 12345 

  for (int participantID = 0; participantID < participantCount; participantID++) {
    for (int i = 0; i < longFormat[participantID].length; i++) {
      longFormat[participantID][i] = standardizedData[participantID][2][int(i/5)%4][i%5][int(i/20)%3];
      print("index: ");
      print(i);
      print(", granularity: ");
      print(i%5);
      print(", timbre: ");
      print(int(i/5)%4);
      print(", amp: ");
      print(int(i/20)%3);
      print(", experience: ");
      print(int(i/60)%4);
      print(" - - - - Estimate: ");
      print( longFormat[participantID][i]);
      println();
    }
  }
  String dataToWrite = "";
  for (int participantID = 0; participantID < participantCount; participantID++) {
    dataToWrite = "";
    for (int i = 0; i < longFormat[participantID].length; i++) {
      dataToWrite = dataToWrite + longFormat[participantID][i] + ", ";  
    }
    appendTextToFile("new/"+"longformat_bumpy1.csv", dataToWrite + "\r\n");
  }
}