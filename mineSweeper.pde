
Cell[][] grid; //<>//
int cols;
int rows;
int w;


int totalBombs;
PImage img;
PImage img1;

int mode;
PImage img2;
PImage img3;
PImage img4;
PImage img5;
PImage img6;
PImage img7;
PImage img8;
PImage img9;
PImage img10;
int openedCells;
int level = 0;

void setup() {
  size(601, 601);
  w = 20;
  totalBombs = 40 + (level + 1 + 10);
  mode = 0;
  level++;
  cols = floor(width / w);
  rows = floor(height / w);
  grid = new Cell[cols][rows];
  img = loadImage("title.png");
  img1 = loadImage("gameover.png");
  img2 = loadImage("one.png");
  img3 = loadImage("two.png");
  img4 = loadImage("three.png");
  img5 = loadImage("four.png");
  img6 = loadImage("start.png");
  img7 = loadImage("five.png");
  img8 = loadImage("six.png");
  img9 = loadImage("meme.png");
  img10 = loadImage("gamewon.png");
  openedCells = 0;
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = new Cell(i, j, w);
    }
  }

  
  ArrayList<int[]> options = new ArrayList<int[]>();    // Generate location of bombs

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int[] option = new int[2];
      option[0] = i;
      option[1] = j;
      options.add(option);
    }
  }


  for (int n = 0; n < totalBombs; n++) {
    int index = floor(random(options.size()));
    int[] choice = options.get(index);
    int i = choice[0];
    int j = choice[1];
    options.remove(index);        //Deletes the spot so that it cannot be chosen again
    grid[i][j].bomb = true;
  }


  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].countBombs();
    }
  }
  restart();
}

void restart(){
  size(601, 601);
  w = 20;
  totalBombs = 40 + (level + 1 + 10);
  mode = 0;
  openedCells = 0;
  level++;
  cols = floor(width / w);
  rows = floor(height / w);
  grid = new Cell[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = new Cell(i, j, w);
    }
  }

  ArrayList<int[]> options = new ArrayList<int[]>();

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int[] option = new int[2];
      option[0] = i;
      option[1] = j;
      options.add(option);
    }
  }


  for (int n = 0; n < totalBombs; n++) {
    int index = floor(random(options.size()));
    int[] choice = options.get(index);
    int i = choice[0];
    int j = choice[1];
    options.remove(index);
    grid[i][j].bomb = true;
  }


  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].countBombs();
    }
  }
}


void endScreen(){
  background(0);      // Used when player loses
  image(img1, 20, 0);
  String text = "Press r to return to title screen";
  textSize(width / 20);
  fill(255, 0, 0);
  text(text, 300, 270);
  level = 0;
  if (keyPressed){
    if (key == 'r')
      mode = 5;
  }
}

void winScreen(){    // Used when player levels up
  background(100, 200, 200);
  String text = "You have completed level " + level + "!\n Press space to move to the next level\n You're probably gonna lose the next one";
  textSize(width / 25);
  fill(255, 255, 0);
  text(text, 302, 115);
  image(img9, 50, 250);
    
  if (keyPressed){
    if (key == ' ')
      mode = 7;
  }
}

void gameWon(){    //Used when player finishes the game
  background(218, 165, 32);
  image(img10, 105, 150);
  String text = "Press q to return to main menu";
  text(text, 302, 115);
  if (keyPressed){
    if (key == 'q')
      mode = 5;
  }
}
void rulesScreen(){    //Shows the rules
  background(255, 200, 200);
  String text1 = "Use the left click button on the mouse to select a space on the grid.\n                                If you hit a bomb, you lose.\nThe numbers on the board represent how many bombs are adjacent.\nAvoid the bombs and expose all the empty spaces to win the game.\n                         Press enter to return to the title screen.";
  //String text2 = "If you hit a bomb, you lose";
  //String text3 = "The numbers on the board represent how many bombs are adjacent to a square.";
  textSize(width / 33);
  fill(0, 102, 153);
  text(text1, 0, 150);
  if (keyPressed){
            if (key == '\n')
               mode = 0;
            }
}

void mousePressed() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (grid[i][j].contains(mouseX, mouseY)) {
        grid[i][j].reveal();
        if (grid[i][j].bomb) {
          mode = 4;
        }
        else if (!(grid[i][j].bomb)){
          openedCells++;     //Calculates how many non-bomb spots have been revealed to determine whether player has completed the level
        }
        if (openedCells == ((cols * rows) - totalBombs)){
          mode = 6;
        }
      }
    }
  }
}

void introMode(){     
  background(255, 200, 200);     //Start menu
  image(img, 100, 80);
  image(img6, 120, 300, 350, 50);
  String text = "Press x to see the rules";
  textSize(width / 22);
  fill(0);
  text(text, 140, 400);
  if (keyPressed){
    if (key == ' '){
      mode = 1;
    }
    else if (key == 'x'){
      mode = 3;
    }
  }
}

void draw() {
  background(255);
  if (mode == 0){
    introMode();
  }
  else if (mode == 3){
    rulesScreen();
  }
  else if (mode == 4){
    endScreen();
  }
  else if (mode == 5){
    restart();
  }
  else if (mode == 6){
    winScreen();
  }
  else if (mode == 7){
    restart();
    mode = 1;
  }
  if (level == 5){
    gameWon();
  }
  else if (mode == 1){
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
         grid[i][j].show();
    }
  }
 }
}
