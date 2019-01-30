void printData(float[][] data) {
  for (int i = 0; i < data.length; i++) {
    for (int y = 0; y < data[i].length; y++) {
      print(data[i][y]);
      print(", ");
    }
    println();
  }
}