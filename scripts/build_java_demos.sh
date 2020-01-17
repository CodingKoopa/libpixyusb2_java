#!/bin/bash
set -e

function WHITE_TEXT {
  printf "\033[1;37m"
}
function NORMAL_TEXT {
  printf "\033[0m"
}
function GREEN_TEXT {
  printf "\033[1;32m"
}
function RED_TEXT {
  printf "\033[1;31m"
}

WHITE_TEXT
echo "########################################################################################"
echo "# Building Java (SWIG) Demos...                                                        #"
echo "########################################################################################"
NORMAL_TEXT

uname -a

TARGET_BUILD_FOLDER=../build

mkdir -p $TARGET_BUILD_FOLDER
mkdir -p $TARGET_BUILD_FOLDER/java_demos

cd "$TARGET_BUILD_FOLDER/java_demos"

echo "Generating C++ to Java for libpixyusb2..."
pwd

cp ../../src/host/libpixyusb2_swig/pixy.i .
swig -java -c++ -outcurrentdir -package com.charmedlabs.libpixyusb2.pixy pixy.i


echo "Compiling and linking C++ interface for libpixyusb2..."
# GCC_EXECUTABLE=arm-frc2019-linux-gnueabi-g++
GCC_EXECUTABLE=g++
GCC_INCLUDES=(
    -I/usr/lib/jvm/java-11-openjdk/include/ \
    -I/usr/lib/jvm/java-11-openjdk/include/linux \
    -I/opt/arm32v7/jdk1.8.0_201/include/ \
    -I/opt/arm32v7/jdk1.8.0_201/include/linux \
    -I/usr/include/libusb-1.0 \
    -I/opt/arm32v7/include/libusb-1.0 \
    -I"C:\Program Files\Java\jdk-11.0.2\include" \
    -I"C:\Program Files\Java\jdk-11.0.2\include\win32" \
    -I"C:\Users\User\Documents\libusb\include\libusb-1.0" \
    -I../../src/common/inc/ \
    ../../src/common/src/chirp.cpp \
    -I../../src/host/libpixyusb2/include/ \
    ../../src/host/libpixyusb2/src/libpixyusb2.cpp \
    ../../src/host/libpixyusb2/src/usblink.cpp \
    ../../src/host/libpixyusb2/src/util.cpp \
    -I../../src/host/arduino/libraries/Pixy2/
)
echo "Compiling with compiler \"$GCC_EXECUTABLE\" ($(where $GCC_EXECUTABLE)) with includes \"${GCC_INCLUDES[@]}\"."
cp ../../src/host/libpixyusb2_examples/java_demos/pixy.cpp .
echo "Compiling C++ libpixyusb2 library..."
$GCC_EXECUTABLE -c -fpic pixy.cpp "${GCC_INCLUDES[@]}"
echo "Compiling C++ libpixyusb2 wrapper..."
$GCC_EXECUTABLE -c -fpic pixy_wrap.cxx "${GCC_INCLUDES[@]}"
echo "Linking libpixyusb2 library to wrapper.."
$GCC_EXECUTABLE -fPIC pixy.o pixy_wrap.o "${GCC_INCLUDES[@]}" \
    -L"C:\Users\User\Documents\libusb\MinGW64\dll" \
    -L"/opt/arm32v7/lib" \
    -lusb-1.0 \
    -shared \
    -o libpixyusb2.so
echo "Copying shared object to Java build tree..."
cp libpixyusb2.so ../../src/host/libpixyusb2_java/libpixyusb2/src/main/resources

if [ -f ../../src/host/libpixyusb2_java/libpixyusb2/src/main/resources/libpixyusb2.so ]; then
  GREEN_TEXT
  printf "SUCCESS "
else
  RED_TEXT
  printf "FAILURE "
fi
echo ""
