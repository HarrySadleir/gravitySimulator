class Startup {
  public void tick() {
    background(0);
    camera();
    hint(DISABLE_DEPTH_TEST);
    fill(255);
    text("Hello World", 50, 50);
    hint(ENABLE_DEPTH_TEST);
  }

  public void handlePress() {
  }

  public void handleRelease() {
  }
}