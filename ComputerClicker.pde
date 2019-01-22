/**
 * Kevin Jiang
 * Oct 18, 2017
 * Amazing, Amazing, Amazing, Tic-tac toe of the toes. Great. Amazing. The best. Guarenteed. Or your money back.
 * More very descriptive descriptions. Descriptive. Description? Description.
 *
 *
 *Instructions:
 * Well, um. You play tic-tac-toe. With a mouse. Yeah.
 * Oh, and if you can beat the AI and click in the top-right hand corner of the window, you get a reward.
 *
 * It incorporates subprogram as a "reward". The following paragraph is a description of that.
 *
 * The best program ever to grace the planet of the earth (especially in looks).
 * Handily completes all criteria in order to achieve "amazing" in all catagories,
 * except for "overall appearance." blegh.
 
 
 TABLE OF CONTENTS ****NOT INCLUDED IN ORIGINAL***** (normal-day submission) CODE. INCLUDED IN THIS VERSION SO YOU DON'T GO INSANE
 ////Table of Contents for code:////
 *setup()
 *draw()
 *Win Checking
 *Reset Board
 *MousePressed()
 *General Housekeeping
 *PFrame Object
 *Coordinate Object
 *AI Classes
 *"Reward"
 */


import java.awt.Frame; //for creating a new "rewards" window
import java.util.Arrays;
import java.util.Scanner;

PFrame f; //The rewards frame
FinalReward reward; //rewards applet to be embedded in PFrame
boolean isFinalRewardShow; //is the final rewards screen being shown  
boolean isXTurn = true;

float YTOP, YTOP_MID, YBOTTOM_MID, YBOTTOM; //y constants, can't be final because processing
float XLEFT, XLEFT_MID, XRIGHT_MID, XRIGHT; //x constants
int[][] board = new int[3][3]; //0 = unplayed, 1 = player piece, 2 = Computer piece
int gameState = 0; //0 = still playing, 1 = player victory, 2 = comp victory, 3 = draw.
TicTacToeAI AI = new EasyAI(board);

void setup() {
 size(1080, 720, JAVA2D);
 frameRate(30); //don't need 60fps , save resources

 //NEED TO DECLARE CONSTS AFTER INIT BECAUSE OTHERWISE IT WILL  BREAK PROCESSING(height, width will be zero);
 YTOP = (height / 2 - height * 0.3);
 YTOP_MID = height / 2 - height * 0.1;
 YBOTTOM_MID = height / 2 + height * 0.2;
 YBOTTOM = height - height * 0.1;

 XLEFT = width * 0.1;
 XLEFT_MID = width / 3;
 XRIGHT_MID = width / 3 * 2;
 XRIGHT = width - width * (1 / 10);

 
}

void draw() {
  checkWin();//check for win @ start to prevent weird bugs
  
  if(isXTurn){
   String message; //displayed message
  
   //init temporary storage/temporary constants for coordinates
   
   Coord[][] bottomLefts = new Coord[3][3];
   bottomLefts[0][0] = new Coord(XLEFT, YTOP_MID);
   bottomLefts[1][0] = new Coord(XLEFT_MID, YTOP_MID);
   bottomLefts[2][0] = new Coord(XRIGHT_MID, YTOP_MID);
  
   bottomLefts[0][1] = new Coord(XLEFT, YBOTTOM_MID);
   bottomLefts[1][1] = new Coord(XLEFT_MID, YBOTTOM_MID);
   bottomLefts[2][1] = new Coord(XRIGHT_MID, YBOTTOM_MID);
  
   bottomLefts[0][2] = new Coord(XLEFT, YBOTTOM);
   bottomLefts[1][2] = new Coord(XLEFT_MID, YBOTTOM);
   bottomLefts[2][2] = new Coord(XRIGHT_MID, YBOTTOM);
  
  
   //background
   background(128);
  
   //tic tac toe square
   pushStyle();
   strokeWeight(10);
   line(width / 3, height / 2 - height * 0.3, width / 3, height - height * 0.1); //left
   line(width / 3 * 2, height / 2 - height * 0.3, width / 3 * 2, height - height * 0.1); //right
   line(width * 0.1, height / 2 - height * 0.1, width - width * 0.1, height / 2 - height * 0.1); //top
   line(width * 0.1, height / 2 + height * 0.2, width - width * 0.1, height / 2 + height * 0.2); //bottom
   popStyle();
  
   pushStyle();
   //telling player whose turn it is
   if (isXTurn) {
    message = "X's turn";
   } else {
    message = "Y's turn";
   }
   textSize(30);
   textAlign(CENTER, CENTER);
   text(message, 858, 50, 1050, 125); //msg in top right corner
   popStyle();
  
  
   //draw the X's and O's on tic-tac-toe grid
   //Extremely lengthy; efficency could be improved if had access to newer-version java releases
   pushStyle();
   textSize(164);
   for (int i = 0; i < bottomLefts[0].length; i++) {
    for (int j = 0; j < bottomLefts.length; j++) {
  
     if (board[i][j] == 1) {
  
      text("X", bottomLefts[i][j].getX() + 60, bottomLefts[i][j].getY() - 10);
  
     } else if (board[i][j] == 2) {
      text("O", bottomLefts[i][j].getX() + 60, bottomLefts[i][j].getY() - 10);
     }
    }
   }
   popStyle();
   
  }else{//AI TURN
    AI.playMove();
    isXTurn = true;
  }
   //Scanning for win
   checkWin();
   
   
   
   
   ///////////////IF SOMEONE WON
   
   if(gameState != 0){
     String endMessage = "";
     
     switch(gameState){
        case 1://player win
              endMessage = "Well, congrats? I guess? I mean this isn't really an accomplishment at all. But whatevs.";
             break;
        case 2://comp win
              endMessage = "Hah. You lost to an easy mode AI. You know, you might wanna try again, because it might just be a bit embarassing, but you do you.";
             break;
        case 3://draw
              endMessage = "What a shame... Wanna to try again?";
             break;       
     }
     
     pushStyle();//white tint everything, with a few menu buttoms. Restart & exit.
     noStroke();
     fill(250,250,250,185);
     rect(0,0,width,height);
     popStyle();
     
     //display message
     pushStyle();
     fill(0,0,255);
     textSize(50);
     endMessage += "\nPress 'e' to exit, 'r' to restart.";
     textAlign(CENTER, TOP);
     text(endMessage,  50,height / 2 - height * 0.3, width - 50, height / 2 + height * 0.3);
     popStyle();
     
     
     
   }
}//END DRAW


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////// WIN CHECKING START////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Mmmmmmmmm. Brute force is best force.
void checkWin() {
 checkColumns();
 checkRows();
 checkDiags();
 checkDraw();
}

//check to see if anyone won using columns.
void checkColumns() {
 int referencePoint = board[0][0];
 for (int i = 0; i < board.length; i++) {
  boolean isRowSame = true; //assumes everything in the row is same, until proven false;
  referencePoint = board[i][0];

  if (referencePoint == 0) { //don't need to be checking for 3 empties in a row
   continue; //skip this iteration
  }

  for (int j = 0; j < board[i].length; j++) {
   if (board[i][j] != referencePoint) {
    isRowSame = false;
   }
  }
  if (isRowSame) {
   gameState = referencePoint; //that player (either human or computer) gets the win.
  }

 }
}


//checks to see if anybody won using rows
void checkRows() {
 //Everything in here behaves THE SAME as checkColumns(), except the x and y are switched. 

 int referencePoint = board[0][0];
 for (int i = 0; i < board.length; i++) {
  boolean isRowSame = true; //assumes everything in the row is same, until proven false;
  referencePoint = board[0][i];
  if (referencePoint == 0) { //don't need to be checking for 3 empties in a row
   continue; //skip this iteration
  }

  for (int j = 0; j < board[i].length; j++) {
   if (board[j][i] != referencePoint) {
    isRowSame = false;
   }
  }
  if (isRowSame) {
   gameState = referencePoint; //that player (either human or computer) gets the win.
  }

 }
}

//checks to see if anybody won using diagonals
void checkDiags() {
 int temp = board[0][0]; //top left square
 //check top-left to bott-right diag
 if (temp != 0) { //bottom is not empty
  if (board[1][1] == temp && board[2][2] == temp) {
   gameState = temp; //I really should learn how to do enums someday.
   return; //game is finished. This function can stop.
  }

 }

 temp = board[0][2]; //bottom left square
 //check bott-left to top-right diag
 if (temp != 0) {
  if (board[1][1] == temp && board[2][0] == temp) { //if the diagonal is all the same,
   gameState = temp; //same thing happened in previous section of func. check out comments there.
   return;
  }
 }
}

//check to see if the game is a draw (full board)
void checkDraw() {
  boolean isEmptySpace = false;
  //report draw
  for (int i = 0; i < board.length; i++) { //go through board arr
   for (int j = 0; j < board.length; j++) {
    if (board[i][j] == 0) { //if any section of board is unfilled, it can't be a draw 
     isEmptySpace = true;
    }
   }
  }
  if (!isEmptySpace) {
   gameState = 3;
  }
 }
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 /////////////////////////////////WIN CHECKING END/////////////////////////////////////////////////////////////////////////
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void resetBoard() { //resets the board to zero for another playThrough
 for (int i = 0; i < board.length; i++) {
  for (int j = 0; j < board.length; j++) {
   board[i][j] = 0;
  }
 }

}

//////////////////// ////////////////////////////////////////////////////////////////////////////////////////////////////////
 //////////////////////////////////////////////////MOUSEPRESSED START/////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void mousePressed() {
  
  if(gameState == 0){
   if (isXTurn) {
    int xSelect = -1, ySelect = -1;
    //find which x box they clicked on
    if (isBetween(mouseX, XLEFT, XLEFT_MID)) {
     xSelect = 0;
    } else if (isBetween(mouseX, XLEFT_MID, XRIGHT_MID)) {
     xSelect = 1;
    } else if (isBetween(mouseX, XRIGHT_MID, XRIGHT)) {
     xSelect = 2;
    }
  
    //find which yBox they clicked on
    if (isBetween(mouseY, YTOP, YTOP_MID)) {
     ySelect = 0;
    } else if (isBetween(mouseY, YTOP_MID, YBOTTOM_MID)) {
     ySelect = 1;
    } else if (isBetween(mouseY, YBOTTOM_MID, YBOTTOM)) {
     ySelect = 2;
    }
  
    //if didn't click in box, just don't register the result
    if (xSelect == -1 || ySelect == -1) {
    
     return;
    }
  
    //click on a grid and plays their turn
    if (board[xSelect][ySelect] == 0) {
     board[xSelect][ySelect] = 1;
     isXTurn = false;
    }
  
   }
  }else{//"victory" screen
    if(gameState == 1){//if player wins, adds another hitbox in top-right of window. If clicked, it'll 
      if(isBetween(mouseX, 960, width) && isBetween(mouseY, 104, 0)){ //open the greatest reward of all time. If clicked again, reward stops harassing the user and hides itself.
        finalRewardShow();//greatest thing of all time happens
      }
   
    }
  }
}

void keyPressed(){
  if(gameState != 0){
   if(key == 'e' || key == 'E'){//for exitign after playing game
    exit();
   }else if(key == 'r' || key == 'R'){//reset
     resetBoard();
     gameState = 0;
   }
  }
 

}

    

//////////////////// //////////////////////////////MOUSEPRESSED END//////////////////////////////////////////////////////////////
 ///////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////GENERAL METHODS START/////////////////////////////////////////////////////////

/**
checks to see if 'compared' is between firstLimit and secondLimit
*/
boolean isBetween(float compared, float firstLimit, float secondLimit) {
 if ((compared < secondLimit && compared > firstLimit) || (compared > secondLimit && compared < firstLimit)) {
  return true;
 } else {
  return false;
 }
}



void finalRewardShow() {
 try {
  if (isFinalRewardShow) { //currently screen is being shown. Player wants to hide it
   f.show(false);
   isFinalRewardShow = false;
  } else { //player wants to see the screen again, for some reason that nobody can comprehend
   f.show(true);
   isFinalRewardShow = true;
  }
 } catch (Exception e) { //Final rewards has not been shown yet
  isFinalRewardShow = true;
  startFinalReward();
 }
}


void startFinalReward() {
  f = new PFrame();
  
 }
 ////////////////////////////////GENERAL METHODS END//////////////////////////////////////
 ////////////////////////////////PFRAME START//////////////////////////////////////////////////////

public class PFrame extends Frame { //just a wrapper frame to shove the reward into
 public PFrame() {

  reward = new FinalReward();
  setBounds(0,0, 1080, 720);
  add(reward); //adding "reward" into frame
  reward.init();
  show();
 }
}

//////////////////////////////////////////PFRAME END//////////////////////////////////////////////
//////////////////////////////////////////COORD START/////////////////////////////////////////////

class Coord { //coordinate class. Just used for storing in more readable way. No comments nessasarcy.
 private float x, y;

 //WHY DOES PROCESSING MAKE ME USE FLOATs???????  

 public Coord(float x, float y) { //processing forces you to use floats.
  this.x = x;
  this.y = y;
 }

 public void setX(float x) {
  this.x = x;
 }
 public void setY(float y) {
  this.y = y;
 }
 public float getX() {
  return x;
 }
 public float getY() {
  return y;
 }
 public String toStringo() { //normal toString() was taken by processing; couldn't override it.
  return "X Coord: " + x + " Y Coord: " + y;
 }
}
////////////////////////////////////////COORD END////////////////////////////////////////////////
////////////////////////////AI CLASSES/START/////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////
abstract class TicTacToeAI{
  int[][] board;
  public final Coord TL = new Coord(0,0), T = new Coord(1,0), TR = new Coord(2,0), 
                     ML = new Coord(0,1), M = new Coord(1,1), MR = new Coord(2,1),
              BL = new Coord(0,2), B = new Coord(1,2), BR = new Coord(2,2);
 public TicTacToeAI(int[][] board){
   this.board = board;
 } 
 
 public abstract void playMove();
 
 public boolean isBoardFull(){
  
   for(int i = 0; i < board.length; i++){
    for(int j = 0; j < board[0].length; j++){
     if(board[i][j] == 0){//if there is an empty spot
       return false;
     }
    }
   } 
   
   return true;
 }
 
 //plays a piece by directly editing board. This should only be called after being vetted by canPlay();
 public void playPiece(Coord place){
   board[int(place.getX())][int(place.getY())] = 2;//plays an  'O' piece at the specified coordinate
 }
 
 //determines if AI can play in a spot on grid
 private boolean canPlay(Coord place){
   if(board[int(place.getX())][int(place.getY())] == 0){
     return true;
   }else{
     return false;
   }
 }
 
 //check to see if can play in any edge
 private boolean centerOpen(){
   if(board[1][1] == 0){
     return true;
   }else{
     return false;
   }
 }
 
 
 //checks to see if can play in any corner
 private boolean cornerOpen(){
   if(board[int(TL.getX())][int(TL.getY())] == 0 ||//I REALLY DON'T WANT TO USE FLOATS PROCESSING, STOP MAKING ME DO IT.
      board[int(TR.getX())][int(TR.getY())] == 0 ||
      board[int(BL.getX())][int(BL.getY())] == 0 ||
      board[int(TL.getX())][int(TL.getY())] == 0){//if any corners are open
        return true;
   }else{
     return false;
   }     
 }
 
 //tries to play at specified coordinate on grid
 public boolean tryPlay(Coord place){
  if(canPlay(place)){
   playPiece(place);
   return true;
  }else{
   return false; 
  }
 }
 
}
/////////////////////////////////
class EasyAI extends TicTacToeAI{
  public EasyAI(int[][] board){
    super(board);
  }
  
  public void playMove(){
    //if board is full, just break. Dont' do anything. Game is over.
    if(isBoardFull()){
     return;
    }
    
    if(super.centerOpen()){//if can play in the center, play there
       super.playPiece(M);
    }else if(super.cornerOpen()){//if can play in any corner, play there
      boolean hasPlayed = false;
      while(!hasPlayed){
        int temp = int(random(4));//choooses a random edge piece and tries to play until successful
        Coord attemptedCoord;
        
        
        
        
        switch(temp){
         case 0: 
             attemptedCoord = super.TL;
             break;
         case 1:
             attemptedCoord = super.TR;
             break;
          case 2:
             attemptedCoord = super.BL;
             break;
          case 3:
            attemptedCoord = super.BR;
            break;
          default:
            System.err.println("This really shouldn't be happening");
            attemptedCoord = null;
            
        }
        
       if(super.tryPlay(attemptedCoord)){//if you have played, you can continue past the while loop 
        hasPlayed = true;
       }
     }
    }else{//must play on sides/edges
      boolean hasPlayed = false;
      while(!hasPlayed){
        int temp = int(random(4));//choooses a random edge piece and tries to play until successful
        Coord attemptedCoord;
        
      
        switch(temp){
         case 0: 
             attemptedCoord = super.T;
             break;
         case 1:
             attemptedCoord = super.B;
             break;
          case 2:
             attemptedCoord = super.MR;
             break;
          case 3:
            attemptedCoord = super.ML;
            break;
          default:
            System.err.println("This really shouldn't be happening");
            attemptedCoord = null;
            
        }
        
      
       if(super.tryPlay(attemptedCoord)){//if you have played, you can continue past the while loop 
        hasPlayed = true;
       } 
      }
    } 
  }
}
/////////////////////////////////AI CLASSES END//////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////2ND APPLET CODE STARTING BELOW//////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////




//The best part that checks everything off.
//If you read this part of the code from top to bottom, you should be able
//to check most of the stuff off sequentially from the rubric.
class FinalReward extends PApplet {

 int[][] positionsOfNumbersX, positionsOfNumbersY;
 final int[] playerOrigin = new int[] {
  width / 2, height / 2
 };
 int[] playerPos = new int[] {
  playerOrigin[0], playerOrigin[1]
 };
 
 int[][] shapePos = new int[][] {
  {0,500}, 
  {width,255}
 };
 
 boolean[] directions = new boolean[] {
  true,
  true
 };
 int[] backgroundColor = new int[] {
  255,
  0,
  0
 };

 void setup() {
  //init arrays
  positionsOfNumbersX = new int[6][];
  positionsOfNumbersY = new int[6][];

  //The coordinates of custom shapes being initalized;
  positionsOfNumbersX[0] = new int[5]; //1
  positionsOfNumbersY[0] = new int[5];
  positionsOfNumbersX[0][0] = 343;
  positionsOfNumbersY[0][0] = 58;
  positionsOfNumbersX[0][1] = 397;
  positionsOfNumbersY[0][1] = 19;
  positionsOfNumbersX[0][2] = 385;
  positionsOfNumbersY[0][2] = 95;
  positionsOfNumbersX[0][3] = 351;
  positionsOfNumbersY[0][3] = 109;
  positionsOfNumbersX[0][4] = 435;
  positionsOfNumbersY[0][4] = 100;


  positionsOfNumbersX[1] = new int[9]; //2
  positionsOfNumbersY[1] = new int[9];
  positionsOfNumbersX[1][0] = 518;
  positionsOfNumbersY[1][0] = 17;
  positionsOfNumbersX[1][1] = 539;
  positionsOfNumbersY[1][1] = 14;
  positionsOfNumbersX[1][2] = 569;
  positionsOfNumbersY[1][2] = 21;
  positionsOfNumbersX[1][3] = 573;
  positionsOfNumbersY[1][3] = 52;
  positionsOfNumbersX[1][4] = 541;
  positionsOfNumbersY[1][4] = 61;
  positionsOfNumbersX[1][5] = 512;
  positionsOfNumbersY[1][5] = 70;
  positionsOfNumbersX[1][6] = 505;
  positionsOfNumbersY[1][6] = 52;
  positionsOfNumbersX[1][7] = 539;
  positionsOfNumbersY[1][7] = 58;
  positionsOfNumbersX[1][8] = 558;
  positionsOfNumbersY[1][8] = 90;


  positionsOfNumbersX[2] = new int[8]; //3
  positionsOfNumbersY[2] = new int[8];
  positionsOfNumbersX[2][0] = 624;
  positionsOfNumbersY[2][0] = 20;
  positionsOfNumbersX[2][1] = 661;
  positionsOfNumbersY[2][1] = 20;
  positionsOfNumbersX[2][2] = 670;
  positionsOfNumbersY[2][2] = 46;
  positionsOfNumbersX[2][3] = 654;
  positionsOfNumbersY[2][3] = 49;
  positionsOfNumbersX[2][4] = 627;
  positionsOfNumbersY[2][4] = 57;
  positionsOfNumbersX[2][5] = 666;
  positionsOfNumbersY[2][5] = 57;
  positionsOfNumbersX[2][6] = 677;
  positionsOfNumbersY[2][6] = 73;
  positionsOfNumbersX[2][7] = 618;
  positionsOfNumbersY[2][7] = 88;


  positionsOfNumbersX[3] = new int[7]; //4
  positionsOfNumbersY[3] = new int[7];
  positionsOfNumbersX[3][0] = 732;
  positionsOfNumbersY[3][0] = 50;
  positionsOfNumbersX[3][1] = 732;
  positionsOfNumbersY[3][1] = 20;
  positionsOfNumbersX[3][2] = 732;
  positionsOfNumbersY[3][2] = 47;
  positionsOfNumbersX[3][3] = 779;
  positionsOfNumbersY[3][3] = 42;
  positionsOfNumbersX[3][4] = 763;
  positionsOfNumbersY[3][4] = 42;
  positionsOfNumbersX[3][5] = 763;
  positionsOfNumbersY[3][5] = 14;
  positionsOfNumbersX[3][6] = 765;
  positionsOfNumbersY[3][6] = 73;


  positionsOfNumbersX[4] = new int[7]; //5
  positionsOfNumbersY[4] = new int[7];
  positionsOfNumbersX[4][0] = 843;
  positionsOfNumbersY[4][0] = 20;
  positionsOfNumbersX[4][1] = 804;
  positionsOfNumbersY[4][1] = 22;
  positionsOfNumbersX[4][2] = 806;
  positionsOfNumbersY[4][2] = 41;
  positionsOfNumbersX[4][3] = 840;
  positionsOfNumbersY[4][3] = 42;
  positionsOfNumbersX[4][4] = 853;
  positionsOfNumbersY[4][4] = 59;
  positionsOfNumbersX[4][5] = 824;
  positionsOfNumbersY[4][5] = 74;
  positionsOfNumbersX[4][6] = 811;
  positionsOfNumbersY[4][6] = 66;


  positionsOfNumbersX[5] = new int[7]; //6
  positionsOfNumbersY[5] = new int[7];
  positionsOfNumbersX[5][0] = 906;
  positionsOfNumbersY[5][0] = 15;
  positionsOfNumbersX[5][1] = 882;
  positionsOfNumbersY[5][1] = 57;
  positionsOfNumbersX[5][2] = 893;
  positionsOfNumbersY[5][2] = 66;
  positionsOfNumbersX[5][3] = 904;
  positionsOfNumbersY[5][3] = 66;
  positionsOfNumbersX[5][4] = 911;
  positionsOfNumbersY[5][4] = 51;
  positionsOfNumbersX[5][5] = 903;
  positionsOfNumbersY[5][5] = 41;
  positionsOfNumbersX[5][6] = 895;
  positionsOfNumbersY[5][6] = 41;



  size(1400, 900);
 }


 void draw() {
  background(backgroundColor[0], backgroundColor[1], backgroundColor[2]);
  //4 different shapes, each a different color
  fill(255 / 4);
  ellipse(1400, 900, 150, 150);
  fill(255 / 3);
  triangle(0, 0, 75, 75, 125, 0);
  fill(255 / 2);
  rect(1400, 900 / 2, -50, 150);
  fill(255);
  quad(250, 250, 270, 400, 350, 365, 425, 435);



  //6 Custom shapes (elements) & 2 for loops. (Numbers from 1-6)
  noFill();
  for (int i = 0; i < positionsOfNumbersX.length; i++) { //go through the shapes
   beginShape(); //starts shape
   for (int j = 0; j < positionsOfNumbersX[i].length; j++) { //go through vertices
    vertex(positionsOfNumbersX[i][j], positionsOfNumbersY[i][j]); //adds the point from arrays made in setup()
   }
   endShape(); //ends shape
  }


  //draw 2 living shapes, if statements
  if (shapePos[0][0] >= width) { //if passed onto right of screen
   directions[0] = false;
  } else if (shapePos[0][0] <= 0) { //if on left of screen
   directions[0] = true;
  }

  if (shapePos[1][0] >= width) { //if on right of screen
   directions[1] = false;

  } else if (shapePos[1][0] <= 0) { //left of screen
   directions[1] = true;
  }

  fill(0, 255, 0);
  rect(shapePos[0][0], shapePos[0][1], 200, 50); //living shape 1
  ellipse(shapePos[1][0], shapePos[1][1], 175, 80); //liviing shape 2
  //making the shapes move, prepare for next frame
  if (directions[0]) { //moves the shape a random amount depending on directions
   shapePos[0][0] += random(50);
  } else {
   shapePos[0][0] -= random(5);
  }

  if (directions[1]) { //moves the shape a  random amount depending on directions
   shapePos[1][0] += random(10);
  } else {
   shapePos[1][0] -= random(100);
  }

  //KEYBOARD CONTROL
  if (keyPressed) { //controlling, using WASD control  scheme
   if (String.valueOf(key).equalsIgnoreCase("W")) {
    playerPos[1] -= 2;
   } else if (String.valueOf(key).equalsIgnoreCase("A")) {
    playerPos[0] -= 2;

   } else if (String.valueOf(key).equalsIgnoreCase("S")) {
    playerPos[1] += 2;
   } else if (String.valueOf(key).equalsIgnoreCase("D")) {
    playerPos[0] += 2;
   } else if (String.valueOf(key).equalsIgnoreCase("E")) { //exit
    //this.setVisible(false);

   } else if (key == 10) { //reset using {ENTER} key
    playerPos = Arrays.copyOf(playerOrigin, playerOrigin.length);
   }
  }

  //draw chactherter
  fill(0, 0, 255);
  beginShape();
  vertex(22 + playerPos[0], 13 + playerPos[1]);
  vertex(17 + playerPos[0], 29 + playerPos[1]);
  vertex(17 + playerPos[0], 42 + playerPos[1]);
  vertex(26 + playerPos[0], 65 + playerPos[1]);
  vertex(8 + playerPos[0], 72 + playerPos[1]);
  vertex(13 + playerPos[0], 78 + playerPos[1]);
  vertex(39 + playerPos[0], 82 + playerPos[1]);
  vertex(66 + playerPos[0], 75 + playerPos[1]);
  vertex(84 + playerPos[0], 56 + playerPos[1]);
  vertex(53 + playerPos[0], 60 + playerPos[1]);
  vertex(39 + playerPos[0], 52 + playerPos[1]);
  vertex(42 + playerPos[0], 35 + playerPos[1]);
  vertex(65 + playerPos[0], 39 + playerPos[1]);
  vertex(92 + playerPos[0], 48 + playerPos[1]);
  vertex(75 + playerPos[0], 96 + playerPos[1]);
  vertex(170 + playerPos[0], 77 + playerPos[1]);
  vertex(153 + playerPos[0], 44 + playerPos[1]);
  vertex(110 + playerPos[0], 70 + playerPos[1]);
  vertex(109 + playerPos[0], 42 + playerPos[1]);
  vertex(145 + playerPos[0], 28 + playerPos[1]);
  vertex(132 + playerPos[0], 15 + playerPos[1]);
  vertex(106 + playerPos[0], 10 + playerPos[1]);
  vertex(68 + playerPos[0], 10 + playerPos[1]);
  vertex(47 + playerPos[0], 14 + playerPos[1]);
  vertex(37 + playerPos[0], 23 + playerPos[1]);
  vertex(57 + playerPos[0], 21 + playerPos[1]);
  vertex(50 + playerPos[0], 27 + playerPos[1]);
  vertex(38 + playerPos[0], 28 + playerPos[1]);
  vertex(28 + playerPos[0], 22 + playerPos[1]);
  vertex(27 + playerPos[0], 7 + playerPos[1]);
  vertex(21 + playerPos[0], 15 + playerPos[1]);
  endShape();

  //mouse interactivity instructions
  noFill();
  beginShape(); //arrow
  vertex(1047, 502);
  vertex(1041, 544);
  vertex(1158, 544);
  vertex(1161, 578);
  vertex(1229, 537);
  vertex(1197, 481);
  vertex(1164, 503);
  vertex(1051, 506);
  endShape();

  beginShape(); //c
  vertex(1047, 594);
  vertex(1038, 610);
  vertex(1037, 622);
  vertex(1047, 628);
  vertex(1058, 629);
  endShape();

  beginShape(); //l
  vertex(1061, 590);
  vertex(1067, 629);
  endShape();

  beginShape(); //i
  vertex(1080, 613);
  vertex(1078, 629);
  vertex(1057, 635);
  vertex(1102, 634);
  vertex(1080, 627);
  vertex(1080, 577);
  vertex(1065, 587);
  vertex(1098, 580);
  endShape();

  beginShape(); //c
  vertex(1141, 585);
  vertex(1120, 583);
  vertex(1100, 594);
  vertex(1103, 600);
  vertex(1104, 615);
  vertex(1118, 618);
  vertex(1131, 627);
  endShape();

  beginShape(); //k
  vertex(1156, 583);
  vertex(1147, 623);
  vertex(1150, 601);
  vertex(1168, 625);
  vertex(1152, 601);
  vertex(1179, 583);
  endShape();

  beginShape(); //t
  vertex(1049, 649);
  vertex(1053, 681);
  vertex(1048, 650);
  vertex(1038, 649);
  vertex(1067, 649);
  endShape();

  beginShape(); //o
  vertex(1095, 651);
  vertex(1073, 662);
  vertex(1075, 676);
  vertex(1093, 682);
  vertex(1106, 666);
  vertex(1100, 651);
  vertex(1094, 654);
  endShape();

  beginShape(); //c
  vertex(1147, 651);
  vertex(1133, 660);
  vertex(1135, 673);
  vertex(1150, 687);
  endShape();

  beginShape(); //h
  vertex(1161, 653);
  vertex(1163, 684);
  vertex(1162, 665);
  vertex(1184, 663);
  vertex(1188, 642);
  vertex(1178, 683);
  endShape();

  beginShape(); //a
  vertex(1201, 646);
  vertex(1194, 681);
  vertex(1201, 662);
  vertex(1217, 662);
  vertex(1228, 677);
  vertex(1203, 629);
  vertex(1197, 652);
  endShape();

  beginShape(); //n
  vertex(1238, 635);
  vertex(1239, 669);
  vertex(1239, 634);
  vertex(1249, 648);
  vertex(1257, 657);
  vertex(1257, 628);
  endShape();

  beginShape(); //g
  vertex(1284, 625);
  vertex(1270, 628);
  vertex(1266, 636);
  vertex(1272, 656);
  vertex(1284, 663);
  vertex(1295, 666);
  vertex(1296, 651);
  vertex(1294, 641);
  vertex(1280, 641);
  endShape();

  beginShape(); //e
  vertex(1325, 614);
  vertex(1296, 616);
  vertex(1306, 640);
  vertex(1325, 638);
  vertex(1308, 639);
  vertex(1305, 657);
  vertex(1335, 652);
  endShape();

  beginShape(); //b
  vertex(1049, 701);
  vertex(1052, 741);
  vertex(1050, 705);
  vertex(1080, 699);
  vertex(1085, 708);
  vertex(1075, 716);
  vertex(1056, 722);
  vertex(1070, 726);
  vertex(1071, 745);
  vertex(1056, 753);
  vertex(1055, 742);
  endShape();

  beginShape(); //a
  vertex(1104, 701);
  vertex(1087, 747);
  vertex(1103, 725);
  vertex(1118, 725);
  vertex(1132, 744);
  vertex(1104, 701);
  endShape();

  beginShape(); //c
  vertex(1176, 699);
  vertex(1141, 713);
  vertex(1142, 734);
  vertex(1177, 739);
  endShape();

  beginShape(); //k stick
  vertex(1194, 688);
  vertex(1192, 743);
  endShape();

  beginShape(); //k right part
  vertex(1224, 691);
  vertex(1198, 714);
  vertex(1226, 731);
  endShape();

  beginShape(); //r
  vertex(1252, 690);
  vertex(1230, 698);
  vertex(1228, 710);
  vertex(1236, 717);
  vertex(1249, 725);
  endShape();

  beginShape(); //o
  vertex(1250, 725);
  vertex(1261, 708);
  vertex(1250, 703);
  endShape();

  beginShape(); //n
  vertex(1279, 685);
  vertex(1283, 728);
  vertex(1280, 688);
  vertex(1299, 686);
  vertex(1305, 700);
  vertex(1280, 707);
  vertex(1318, 720);
  endShape();

  beginShape(); //d
  vertex(1337, 666);
  vertex(1320, 678);
  vertex(1315, 697);
  vertex(1330, 706);
  vertex(1349, 709);
  vertex(1354, 692);
  vertex(1354, 670);
  vertex(1336, 666);
  endShape();

  beginShape(); //n
  vertex(1378, 664);
  vertex(1374, 697);
  vertex(1378, 663);
  vertex(1395, 692);
  vertex(1400, 656);
  endShape();

  beginShape(); //d
  vertex(1418, 653);
  vertex(1418, 686);
  vertex(1441, 678);
  vertex(1442, 656);
  vertex(1426, 645);
  vertex(1420, 639);
  vertex(1418, 664);
  endShape();

  //explanation for movement sytem
  pushStyle();
  noStroke();
  fill(0);
  textSize(32);
  text("Use WASD for controls\nENTER to restore position\nResize to view more surprises!", 100, 35);
  popStyle();

  if (frameCount % 2 == 0) {
   String victorySuffix = ""; //add up to 10 characters to end of victory string.
   for (int i = 0; i < random(10); i++) {
    if (int(random(3)) == 2) { //50% chance of exclamation mark, 
     victorySuffix += "!";
    } else { //50% chance of question mark
     victorySuffix += "?";
    }
   }

   //random numbers (every 2 frames)
   pushStyle();
   noStroke();
   fill(random(255), random(255), random(255));
   textSize(128);
   text("VICTORY" + victorySuffix, width / 2 - width * 0.4, height / 2 + height * 0.1);
   popStyle();
  }


 }

 public void mouseClicked() {

  if (mouseX > 1350 && mouseY > 450 && mouseY < 600) { //clicked inside left grey square, change backgroundColor
   if (backgroundColor[0] == 255) {
    backgroundColor[0] = 0;
    backgroundColor[1] = 255;
   } else if (backgroundColor[1] == 255) {
    backgroundColor[1] = 0;
    backgroundColor[2] = 255;

   } else {
    backgroundColor[2] = 0;
    backgroundColor[0] = 255;
   }
  }

 }
}
