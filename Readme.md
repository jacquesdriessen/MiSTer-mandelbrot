# Mandelbrot renderer

## General description
This core will render the mandelbrot set (https://en.wikipedia.org/wiki/Mandelbrot_set).

## Core 
### Controls

a = left, d is right, w is top, s is bottom and z to zoom in, x to zoom out:

### Menu options:
Number of iterations, colouring and enable/disable individual compute cores.

### Other things to be aware of:
To fit 20 compute cores - have set compiler options for area (not speed). Compute cores only enabled whilst calculating a frame (the user LED will flash). Clk set to 175Mhz.

## Source
### Top level
Normal descriptive verilog, provides the state machine and has an array of compute cores (each one having a pipeline to calculate a point) and one "preprocessor pipeline" that translates the screen coordinates into the re/im coordinates for mandelbrot

### Pipelines and below
Created in BSD format (basically it's a schematic that will be translated into the actual logic). There is some nesting (e.g. parts have their own schematic)

## Acknowledgements
* sorgelig and the rest of the team for providing the awesome framework and guidelines
* Al Williams' FPGA bootcamp to get me started: https://hackaday.com/2018/08/06/learn-fpga-fast-with-hackadays-fpga-boot-camp/
* Bruce Land for his lectures in general and on what challenges to expect and overcome specifically for mandelbrot https://www.youtube.com/watch?v=AYpbyZFo5xs.
* Jesse Armagos/Eddie Yang for the idea on basic structure the main pipeline http://web.cecs.pdx.edu/~mperkows/CLASS_574/Oct16-2008/mand.pdf

### Youtube Demo:

[![](https://i9.ytimg.com/vi/wUut63y8E0I/mq3.jpg?sqp=CKDIiYUG&rs=AOn4CLArdc5xE_QAR0bvqa3g7eNfndPiIg)](https://www.youtube.com/watch?v=wUut63y8E0I)
