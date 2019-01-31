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
float[][][][][] standardizedData = new float [participantCount][experienceCount][timbreLevels.length][granularityLevels.length][amplitudeLevels.length];

void setup() {

  //---------load data--------------//
  raw = parseFile("raw_restructured.csv");
  //---------data loaded from CSV file--------------//



  //---------restructure data ---------//
  for (int i = 1; i < raw.length; i++) {
    data[int(raw[i][participant])][int(raw[i][experience])][int(raw[i][timbre])][int(raw[i][granularity])][int(raw[i][amplitude])] = raw[i][estimate];
  }
  //--------- data now in more convenient structure ---------//






  normalizeToNoise();








  //----------Get averages for timbre for plots---------------//
  for (int participantID = 0; participantID < participantCount; participantID++) {
    //for each participant
    for (int timbreID = 0; timbreID < timbreLevels.length; timbreID++) { //<---here we get the arrays of all amplitude+granularity levels at that timbre level

      //(1)//
      //Find averages for each timbre estimate and subtract them (so that the remaining data is only noise)
      ///////

      //calculate the average timbre
      float averageTimbre = mean(standardizedData[participantID][bumpyness][timbreID]);
      print(averageTimbre + ", ");
    }
    println();
  }
  //----------averages printed---------------//
}