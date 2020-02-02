package com.charmedlabs.libpixyusb2.examples;

import java.io.IOException;

import com.charmedlabs.libpixyusb2.pixy.*;

class Demo {
    static {
        try {
            NativeUtils.loadLibraryFromJar("/libusb-1.0.dll");
            NativeUtils.loadLibraryFromJar("/libpixyusb2_cpp_api.dll");
        } catch (IOException exception) {
            System.out.println("An exception occurred while loading the libpixyusb2 shared object:");
            exception.printStackTrace();
        }
    }

    public static void main(String[] args) throws Exception {
        System.out.println("Pixy2 Java SWIG Example");
        // System.out.println("Path: " + System.getProperty("java.library.path"));

        System.out.println("Initializing Pixy...");
        int ret = pixy.init();
        if (ret != 0) {
            System.out.println("Error: Pixy initialization failed with error code " + ret + ".");
            return;
        }
        System.out.println("Pixy has been initialized.");

        System.out.println("Reading blocks.");
        while (true) {
            Thread.sleep(2000);
            BlockArray blocks = new BlockArray(2);
            pixy.ccc_get_blocks(2, blocks);
        }
    }
}