import processing.pdf.*; //for exporting visualizations
import java.io.BufferedWriter; //for logging lines
import java.io.FileWriter; //create files

//labels
int participant = 0;
int granularity = 1;
int amplitude = 2;
int timbre = 3;
int experience = 4;
int estimate = 5;

//counters
int participantCount = 24;
int experienceCount = 4;
String[] timbreLevels = {"40Hz", "80Hz", "160Hz", "320Hz"};
String[] granularityLevels = {"gran_1", "gran_2", "gran_5", "gran_20", "gran_312"};
String[] amplitudeLevels = {"low", "medium", "high"};


//levels
int ampLow = 0;
int ampMid = 1;
int ampHigh = 2;

int t_40hz = 0;
int t_80hz = 1;
int t_160hz = 2;
int t_320hz = 4;

int gran_1 = 4;
int gran_2 = 3;
int gran_5 = 2;
int gran_20 = 1;
int gran_312 = 0;

//experience codes
int roughness = 0;
int sharpness = 1;
int bumpyness = 2;
int adhesiveness = 3;

//data storage
float[][] raw = new float[5761][6];
//order: Participant, Experience,  Timbre, Granularity, Amplitude
float[][][][][] data       = new float [participantCount][experienceCount][timbreLevels.length][granularityLevels.length][amplitudeLevels.length];
float[][][][][] dataTimbre = new float [participantCount][experienceCount][timbreLevels.length][granularityLevels.length][amplitudeLevels.length];

void setup() {

  //---------load data--------------//
  raw = parseFile("raw_restructured.csv");
  //---------data loaded from CSV file--------------//



  //---------restructure data ---------//
  for (int i = 1; i < raw.length; i++) {
    data[int(raw[i][participant])][int(raw[i][experience])][int(raw[i][timbre])][int(raw[i][granularity])][int(raw[i][amplitude])] = raw[i][estimate];
  }
  //--------- data now in more convenient structure ---------//



  //----------preprocess according to timbre---------------//
  for (int participantID = 0; participantID < participantCount; participantID++) {
    //for each participant
    for (int experienceID = 0; experienceID < experienceCount; experienceID++) {
      //and each experience
      for (int timbreID = 0; timbreID < timbreLevels.length; timbreID++) { //<---here we get the arrays of all amplitude+granularity levels at that timbre level

        //(1)//
        //Find averages for each timbre estimate and subtract them (so that the remaining data is only noise)
        ///////

        //calculate the average timbre
        float averageTimbre = mean(data[participantID][experienceID][timbreID]);
        print("Participant: " + participantID + ", Experience: " + experienceID + ", timbreLevel: " + timbreLevels[timbreID] + " - "); 
        println("Mean: " + averageTimbre);

        //subtract it from the estimates
        for (int granularityID = 0; granularityID < granularityLevels.length; granularityID++) {
          for (int amplitudeID = 0; amplitudeID < amplitudeLevels.length; amplitudeID++) { //<---here we get all individual values
            //using datatimbre as a placeholder to calculate the SDs from
            dataTimbre[participantID][experienceID][timbreID][granularityID][amplitudeID] = 
              data[participantID][experienceID][timbreID][granularityID][amplitudeID] - averageTimbre;
            println( dataTimbre[participantID][experienceID][timbreID][granularityID][amplitudeID]);
          }
        }


        /*
        //testing. this should be zero
         averageTimbre = mean(dataTimbre[participantID][experienceID][timbreID]);
         print("Mean after subtracting: " + int(averageTimbre));
         */
      } //<---- end manipulating the array of all amplitude+granularity level estimates for timbre level

      //(2)//
      //calculate the standard deviation using the interim variable
      ///////

      float standardDeviation = standardDeviation(dataTimbre[participantID][experienceID]);
      println((" SD: " + standardDeviation));


      //(3)//
      //divide the original data by the standard deviation
      ///////

      for (int timbreID = 0; timbreID < timbreLevels.length; timbreID++) {         
        for (int granularityID = 0; granularityID < granularityLevels.length; granularityID++) {
          for (int amplitudeID = 0; amplitudeID < amplitudeLevels.length; amplitudeID++) {
            //updating the interim data to actual data
            dataTimbre[participantID][experienceID][timbreID][granularityID][amplitudeID] =   
              data[participantID][experienceID][timbreID][granularityID][amplitudeID] / standardDeviation;
          }
        }
      }


      //subtract grand mean
      float grandMean = mean(dataTimbre[participantID][experienceID]);
      println(("Grand Mean: " + standardDeviation));

      for (int timbreID = 0; timbreID < timbreLevels.length; timbreID++) {         
        for (int granularityID = 0; granularityID < granularityLevels.length; granularityID++) {
          for (int amplitudeID = 0; amplitudeID < amplitudeLevels.length; amplitudeID++) {

            // subtract grand mean
          
            dataTimbre[participantID][experienceID][timbreID][granularityID][amplitudeID] =   
              dataTimbre[participantID][experienceID][timbreID][granularityID][amplitudeID] - grandMean;
              println("subtracting");
         
          }
        }
      }
    } //<--- finish the experience
  } //<--- finish the participant
  //----------finished preprocessing according to timbre------------//


  //----------Get averages for timbre for plots---------------//
  for (int participantID = 0; participantID < participantCount; participantID++) {
    //for each participant
    for (int timbreID = 0; timbreID < timbreLevels.length; timbreID++) { //<---here we get the arrays of all amplitude+granularity levels at that timbre level

      //(1)//
      //Find averages for each timbre estimate and subtract them (so that the remaining data is only noise)
      ///////

      //calculate the average timbre
      float averageTimbre = mean(dataTimbre[participantID][bumpyness][timbreID]);
      print(averageTimbre + ", ");
    }
    println();
  }
  //----------averages printed---------------//
}