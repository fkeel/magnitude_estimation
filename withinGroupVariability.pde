


void normalizeToNoise() {

  /*
  /* The raw data is in diffirent ranges, at different scales per participant.
  /*
  /*       Normalizing the raw data might exaggerate unwanted features: 
  /*       if a participant exerienced no change between stimuli, small variations in estimates would be stretched to full range
  /*       even though data is in the same range, the scale is different per participant
  /*
  /*       Standardizing the data reduces this problem, however it would remove part of the signal:
  /*       if a participant experienced a clear difference between two stimuli, 
  /*       standardization would make that difference appear smaller
  /*
  /* If we calculate the within groups variability (or 'error variability' for independant samples ANOVA)
  /* (I will call this noise from now on)
  /* If we assume that the noise is similar for all participants
  /* We can use this measure of noise to standardize the data according to noise.
  /*
  /*        Standardizig according to noise creates a 
  /*         - shared scale (units relative to noise)
  /*         - shared range 
  /*         and
  /*         - unlike regular standardization preserves effect sizes (data is not penalized for showing large effects)
  /*         - unlike normalization does not inflate noise (data with no effects is not stretched to the same range as data with effects)
  /*
  /*
   */

  /*
  /*        We calculate the noise by finding the Sum of Squares Within Groups (SSw) 
  /*        and dividing by the appropriate degrees of freedom
  /*        (see also https://statistics.laerd.com/statistical-guides/repeated-measures-anova-statistical-guide-2.php)
  /*
  /*       We then standardize according to noise by dividing each estimate by that value (per person & condition)
  /*
   */


  //loop through all participants and all experiences. Do calculations for each participant/experience combination

  for (int participantID = 0; participantID < participantCount; participantID++) {
    //for each participant
    println();
    println("Begin participant " + participantID);
    for (int experienceID = 0; experienceID < experienceCount; experienceID++) {
      println("Begin experience " + experienceID);
      //and each experience

      ///////////////////////////////////////////////
      // (1) Remove all variability due to stimuli //
      ///////////////////////////////////////////////


      //----------Remove variability for Timbre---------------//

      //we start with timbre as the data is already organized that way!
      //(the for loops could be optimized, but I'm leaving it like this to better follow my thought process)

      for (int timbreID = 0; timbreID < timbreLevels.length; timbreID++) { //<---here we get the arrays of all amplitude+granularity levels at that timbre level
        //Find averages for each timbre estimate and subtract them (so that the remaining data is only noise)

        //calculate the average timbre
        float averageTimbre = mean(data[participantID][experienceID][timbreID]);
        // print("Participant: " + participantID + ", Experience: " + experienceID + ", timbreLevel: " + timbreLevels[timbreID] + " - "); 
        //println("Timbre Mean: " + averageTimbre);

        //subtract it from the estimates
        for (int granularityID = 0; granularityID < granularityLevels.length; granularityID++) {
          for (int amplitudeID = 0; amplitudeID < amplitudeLevels.length; amplitudeID++) { //<---here we get all individual values
            //using standardizedData as a placeholder to calculate the SDs from
            standardizedData[participantID][experienceID][timbreID][granularityID][amplitudeID] = 
              data[participantID][experienceID][timbreID][granularityID][amplitudeID] - averageTimbre;
            //   println( standardizedData[participantID][experienceID][timbreID][granularityID][amplitudeID]);
          }
        }

        /*
        //testing. this should be zero
         averageTimbre = mean(standardizedData[participantID][experienceID][timbreID]);
         print("Mean after subtracting: " + int(averageTimbre));
         */
      } //<---- end manipulating the array of all amplitude+granularity level estimates for timbre level
      
      //----------finished with timbre------------//




      //----------remove variability due to granularity---------------//
      for (int granularityID = 0; granularityID < granularityLevels.length; granularityID++) { 
        //Find averages for each granularity estimate and subtract them (so that the remaining data is only noise)

        //create an interim float[][] array to store the values which we want to calculate
        float[][] interim = new float[timbreLevels.length][amplitudeLevels.length];

        //populate interim array
        for (int timbreID = 0; timbreID < timbreLevels.length; timbreID++) {
          for (int amplitudeID = 0; amplitudeID < amplitudeLevels.length; amplitudeID++) { 
            interim[timbreID][amplitudeID] = 
              standardizedData[participantID][experienceID][timbreID][granularityID][amplitudeID];
          }
        }

        //calculate the average granularity
        float averageGranularity = mean(interim);
        //print("Participant: " + participantID + ", Experience: " + experienceID + ", timbreLevel: " + timbreLevels[timbreID] + " - "); 
        //println("Mean: " + granularity);

        //subtract it from the estimates
        for (int timbreID = 0; timbreID < timbreLevels.length; timbreID++) {
          for (int amplitudeID = 0; amplitudeID < amplitudeLevels.length; amplitudeID++) { //<---here we get all individual values
            //using standardizedData as a placeholder to calculate the SDs from
            standardizedData[participantID][experienceID][timbreID][granularityID][amplitudeID] = 
              standardizedData[participantID][experienceID][timbreID][granularityID][amplitudeID] - averageGranularity;
            //println( standardizedData[participantID][experienceID][timbreID][granularityID][amplitudeID]);
          }
        }

        /*
         //testing. this should be zero
         averageTimbre = mean(standardizedData[participantID][experienceID][timbreID]);
         print("Mean after subtracting: " + int(averageTimbre));
         */
      } //<---- end manipulating the array of all timbre+amplitude level estimates for timbre level
      
      //----------finished with granularity------------//




      //----------remove variability due to amplitude---------------//
      for (int amplitudeID = 0; amplitudeID < amplitudeLevels.length; amplitudeID++) {//<---here we get the arrays of all amplitude+granularity levels at that timbre level
        //Find averages for each ampltidue estimate and subtract them (so that the remaining data is only noise)

        //we need to create an interim float[][] array to store the values which we want to calculate
        float[][] interim = new float[timbreLevels.length][amplitudeLevels.length];

        //populate interim array;
        for (int timbreID = 0; timbreID < timbreLevels.length; timbreID++) {
          for (int granularityID = 0; granularityID < granularityLevels.length; granularityID++) { 

            interim[timbreID][amplitudeID] = 
              standardizedData[participantID][experienceID][timbreID][granularityID][amplitudeID];
          }
        }

        //calculate the average granularity
        float averageAmplitude = mean(interim);
        //print("Participant: " + participantID + ", Experience: " + experienceID + ", timbreLevel: " + timbreLevels[timbreID] + " - "); 
        // println("Mean: " + granularity);

        //subtract it from the estimates
        for (int timbreID = 0; timbreID < timbreLevels.length; timbreID++) {
          for (int granularityID = 0; granularityID < granularityLevels.length; granularityID++) { //<---here we get all individual values
            //using standardizedData as a placeholder to calculate the SDs from
            standardizedData[participantID][experienceID][timbreID][granularityID][amplitudeID] = 
              standardizedData[participantID][experienceID][timbreID][granularityID][amplitudeID] - averageAmplitude;
            //println( standardizedData[participantID][experienceID][timbreID][granularityID][amplitudeID]);
          }
        }

        /*
        //testing. this should be zero
         averageTimbre = mean(standardizedData[participantID][experienceID][timbreID]);
         print("Mean after subtracting: " + int(averageTimbre));
         */
      } //<---- end manipulating the array of all timbre+amplitude level estimates for timbre level
      
      //----------finished with amplitude------------//





      ///////////////////////////////////////////
      // (2) Find Mean Sum of Squares of Noise //
      ///////////////////////////////////////////

      float standardDeviation = standardDeviation(standardizedData[participantID][experienceID]); 
      println(("SD: " + standardDeviation));




      //////////////////////////////////////////////////////////////
      // (3) Divide original data by Mean Sum of Squares of Noise //
      //////////////////////////////////////////////////////////////

      for (int timbreID = 0; timbreID < timbreLevels.length; timbreID++) {         
        for (int granularityID = 0; granularityID < granularityLevels.length; granularityID++) {
          for (int amplitudeID = 0; amplitudeID < amplitudeLevels.length; amplitudeID++) {
            //updating the interim data to actual data
            standardizedData[participantID][experienceID][timbreID][granularityID][amplitudeID] =   
              data[participantID][experienceID][timbreID][granularityID][amplitudeID] / standardDeviation;
          }
        }
      }



      /////////////////////////////
      // (4) Subtract Grand Mean //
      /////////////////////////////
      
      float grandMean = mean(standardizedData[participantID][experienceID]);
      println(("Grand Mean: " + standardDeviation));

      for (int timbreID = 0; timbreID < timbreLevels.length; timbreID++) {         
        for (int granularityID = 0; granularityID < granularityLevels.length; granularityID++) {
          for (int amplitudeID = 0; amplitudeID < amplitudeLevels.length; amplitudeID++) {

            // subtract grand mean

            standardizedData[participantID][experienceID][timbreID][granularityID][amplitudeID] =   
              standardizedData[participantID][experienceID][timbreID][granularityID][amplitudeID] - grandMean;
            //  println("subtracting");
          }
        }
      }
      
    } //<-----------finish experience
  } //<-------------finish participant
  
}