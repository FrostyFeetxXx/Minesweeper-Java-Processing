
class Cell {
  int i;
  int j;
  int x;
  int y;
  int w;
  int neighborCount;
  boolean bomb;
  boolean revealed;
  


  Cell(int i_, int j_, int w_) {
    i = i_;
    j = j_;
    x = i * w_;
    y = j * w_;
    w = w_;
    neighborCount = 0;
    
    bomb = false;
    revealed = false;
  }
  
  
  void show() {
    stroke(0);
    noFill();
    rect(x, y, w, w);
    if (revealed) {
      if (bomb) {
        image(loadImage("bomb.png"), x + w * 0.5 - 6, y + w * 0.5 - 6, w * 0.7, w * 0.7);
      } else {
        fill(200);
        rect(x, y, w, w);
        if (neighborCount > 0) {
          textAlign(CENTER);
          fill(0);
          if (neighborCount == 1){
            image(img2, x + w * 0.5 - 6, y + w * 0.5 - 6, w * 0.7, w * 0.7);
          }
          else if (neighborCount == 2){
            image(img3, x + w * 0.5 - 6, y + w * 0.5 - 6, w * 0.7, w * 0.7);
          }
          else if (neighborCount == 3){
            image(img4, x + w * 0.5 - 6, y + w * 0.5 - 6, w * 0.7, w * 0.7);
          }
          else if (neighborCount == 4){
            image(img5, x + w * 0.5 - 6, y + w * 0.5 - 6, w * 0.7, w * 0.7);
          }
          else if (neighborCount == 5){
            image(img7, x + w * 0.5 - 6, y + w * 0.5 - 6, w * 0.7, w * 0.7);
          }
          else if (neighborCount == 6){
            image(img8, x + w * 0.5 - 6, y + w * 0.5 - 6, w * 0.7, w * 0.7);
          }
          else{
            text(neighborCount, x + w * 0.5, y + w - 6);
          }
        }
      }
    }
  }
  
  void countBombs() {
    if (bomb) {
      neighborCount = -1;
      return;
    }
    int total = 0;
    for (int xoff = -1; xoff <= 1; xoff++) {
      int celli = i + xoff;
      if (celli < 0 || celli >= cols) continue;
  
      for (int yoff = -1; yoff <= 1; yoff++) {
        int cellj = j + yoff;
        if (cellj < 0 || cellj >= rows) continue;
  
        Cell neighbor = grid[celli][cellj];
        if (neighbor.bomb) {
          total++;
        }
      }
    }
    neighborCount = total;
  }
  
  boolean contains(int x_, int y_) {
    return (x_ > x && x_ < x + w && y_ > y && y_ < y + w);
  }
  
  void reveal() {
    revealed = true;
    if (neighborCount == 0) {
      // flood fill time
      floodFill();
    }
  }
  
  void floodFill() {
    for (int xoff = -1; xoff <= 1; xoff++) {
      int celli = i + xoff;
      if (celli < 0 || celli >= cols) continue;
  
      for (int yoff = -1; yoff <= 1; yoff++) {
        int cellj = j + yoff;
        if (cellj < 0 || cellj >= rows) continue;
  
        Cell neighbor = grid[celli][cellj];
        if (!neighbor.revealed) {
          neighbor.reveal();
        }
      }
    }
  }
}
