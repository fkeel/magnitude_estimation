

void removeGenerallEffects() {




  //-------------calculate average timbre over all experiences ----------------------//

  float globalTimbreAverage[] = new float[4]; // create an array for storing mean of all experiences

  for (int participantID = 0; participantID < participantCount; participantID++) {     //for each participant
    for (int experienceID = 0; experienceID < experienceCount; experienceID++) {       //and each experience
      for (int timbreID = 0; timbreID < timbreLevels.length; timbreID++) { 

        //collect the sum of the means of all timbre estimates per level
        globalTimbreAverage[timbreID] = globalTimbreAverage[timbreID] + mean(data[participantID][experienceID][timbreID]);
      }
    }
  }

  for (int i = 0; i < globalTimbreAverage.length; i++) {
    //divide this sum by participants*experiences to get the average (could also use or double check using counts)
    globalTimbreAverage[i] = globalTimbreAverage[i]  / (participantCount*experienceCount); //calculate the global average from local averages
  }

  //-------------done with timbre ----------------------//




  //-------------calculate average granularity over all experiences ----------------------//

  float globalGranularityAverage[] = new float[5]; //array for storing the global mean

  for (int participantID = 0; participantID < participantCount; participantID++) { //for each participant
    
    for (int experienceID = 0; experienceID < experienceCount; experienceID++) { //and each experience
      

      for (int granularityID = 0; granularityID < granularityLevels.length; granularityID++) { 

        //create an interim float[][] array to store the values which we want to calculate the *local* mean
        float[][] interim = new float[timbreLevels.length][amplitudeLevels.length];

        //populate interim array
        for (int timbreID = 0; timbreID < timbreLevels.length; timbreID++) {
          for (int amplitudeID = 0; amplitudeID < amplitudeLevels.length; amplitudeID++) { 
            interim[timbreID][amplitudeID] = 
              standardizedData[participantID][experienceID][timbreID][granularityID][amplitudeID];
          }
        }
        //collect the sum of the means of all granularity estimates per granularity level
        globalGranularityAverage[granularityID] = globalGranularityAverage[granularityID] + mean(interim);
      }
    }
  }
  for (int i = 0; i < globalGranularityAverage.length; i++) {
    //divide this sum by all participants & experiences
    globalGranularityAverage[i] = globalGranularityAverage[i]  / (participantCount*experienceCount); //calculate the global average from local averages
  }

  //-------------done with granularity ----------------------//







  //-------------calculate average amplitude over all experiences ----------------------//

  float globalAmplitudeAverage[] = new float[3];
  for (int participantID = 0; participantID < participantCount; participantID++) {
    //for each participant
    for (int experienceID = 0; experienceID < experienceCount; experienceID++) {
      //and each experience

      for (int amplitudeID = 0; amplitudeID < amplitudeLevels.length; amplitudeID++) {

        //we need to create an interim float[][] array to store the values which we want to calculate the *local* mean
        float[][] interim = new float[timbreLevels.length][amplitudeLevels.length];

        //populate interim array;
        for (int timbreID = 0; timbreID < timbreLevels.length; timbreID++) {
          for (int granularityID = 0; granularityID < granularityLevels.length; granularityID++) { 

            interim[timbreID][amplitudeID] = 
              standardizedData[participantID][experienceID][timbreID][granularityID][amplitudeID];
          }
        }

        //create the sum of all means per level of amplitude
        globalAmplitudeAverage[amplitudeID] = globalAmplitudeAverage[amplitudeID]+mean(interim);
      }
    }
  }
  for (int i = 0; i < globalAmplitudeAverage.length; i++) {
    //divide that sum by participants*experience to get the global mean
    globalAmplitudeAverage[i] = globalAmplitudeAverage[i]  / (participantCount*experienceCount); //calculate the global average from local averages
  }
  //-------------done with amplitude ----------------------//
}