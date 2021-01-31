
public void keyPressed() {
  if (mode == 0) {
    //startup.handlePress(keyCode);
  } else if (mode == 1) {
    simulation.handlePress();
  }

}

public void keyReleased() {
  if (mode == 0) {
    //startup.handlePress(keyCode);
  } else if (mode == 1) {
    simulation.handleRelease();
  }
}