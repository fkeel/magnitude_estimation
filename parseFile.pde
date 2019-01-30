//for parsing files

float[][] parseFile(String filename) {
  String[] lines = loadStrings(filename);

  //create file that is [pressure(2)][strip(7)][x(71)][y(11)]

  float[][] data = new float[5761][6];

  //  println("created the monster array");

  for (int i = 1; i < lines.length; i++) { //throw away first line
    //    println("Parsing file: " + filename);
    //    print("creating a new split string... ");
    String[] items = split(lines[i], ','); //create an array of all items in a line

//replace words with IDs
    switch(items[experience]) {  
    case "Roughness":
      items[experience] = str(roughness);
      break;
    case "Bumpyness":
      items[experience] = str(bumpyness);
      break;
    case "Adhesiveness":
      items[experience] = str(adhesiveness);
      break;
    case "Sharpness":
      items[experience] = str(sharpness);
      break;
    }


    //    println("... done");
    for (int y = 0; y < items.length; y++) {
      
      data[i][y] = float(items[y]);
    }
  }
  return data;
}