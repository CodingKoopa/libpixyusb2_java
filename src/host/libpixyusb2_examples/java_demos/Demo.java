class Demo {
    static {
        System.loadLibrary("libpixy2");
    }
    public static native void init();
    public static void main(String[] args) throws Exception {
        System.out.println("Hello Java");
        init();
    }
}