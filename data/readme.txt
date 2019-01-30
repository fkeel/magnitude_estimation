
format of each line: X, Y, Z, strip1, strip2, strip3, strip4, strip5, strip6, strip7

data_scaler.pde processing sketch was used to create these files.

the sketch 

- applies a low-pass filter
- finds maximum and minimum sensor readings
- removes noise by capping values at 0.95*maximum
- rescales and inverts readings (maximum --> 0, minimum --> 1)
