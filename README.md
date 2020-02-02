# [libpixyusb2_java](src/host/libpixyusb2_java)

[*libpixyusb2_java*](src/host/libpixyusb2_java) is a thin Java wrapper for [*libpixyusb2*](https://github.com/charmedlabs/pixy2/tree/master/src/host/libpixyusb2). It leverages Charmed Lab's [existing infrastructure for generating Python bindings](https://github.com/charmedlabs/pixy2/tree/master/src/host/libpixyusb2_examples/python_demos) to generate Java bindings. This mostly serves as a proof of concept to show that this is possible. This is able to successfully initialize the Pixy2 camera on Windows if the drivers have been installed with [PixyMon v2](https://pixycam.com/downloads-pixy2/), and on Linux. This was created for use with the [NI roboRIO](https://www.andymark.com/products/ni-roborio) for the [First Robotics Competition](https://www.firstinspires.org/robotics/frc), however, the Gradle build system here isn't able to fulfill this because the [new C++ plugin](https://blog.gradle.org/introducing-the-new-cpp-plugins) used here does not support cross compilation, which is essential for making usage with the roboRIO work. For using the Pixy2 camera with the roboRIO over I2C, rather than USB, Kentridge Robotics has created [Pixy2JavaAPI](https://github.com/PseudoResonance/Pixy2JavaAPI).

More info on the technical research backing this can be found in [this](src/host/libpixyusb2_java/Pixy2%20with%20roboRIO%20Research.pdf) document.

## Setup

### Prerequisites
- [libusb 1.0](https://github.com/libusb/libusb/releases).
  - If on Linux, install this through your package manager.
  - If on Windows, extract this with [7-Zip](https://www.7-zip.org/download.html), to `C:\Program Files\libusb-$MAJOR_VERSION` (e.g. `C:\Program Files\libusb-1.0` for `libusb-1.0.23.7z`), and add it to the PATH.
- [swig](http://www.swig.org/download.html).
  - If on Linux, install this through your package manager.
  - If on Windows, download *swigwin* and extract it as `C:\Program Files\swigwin-$VERSION`, and add it to the PATH. If you aren't the administrator, you should either take ownership of this folder, or install it somewhere else instead, else swig's output files won't be accessible for writing for the build process.
- A Java compiler
- A C++ compiler.
  - This was tested with GCC on Linux, and [Mingw-w64](http://mingw-w64.org/doku.php/download) on Windows

### Building
1. Run `gradle build` in the `libpixyusb2_java` directory. The `swig` task may not be ran and finished before the `cppCompile` task, so it may be necessary to run this twice.