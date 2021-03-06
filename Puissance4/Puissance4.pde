int plateau[][]= new int[7][6];
int player=1;
boolean partie=true;
boolean full_plate=false;
String result ="";

void setup() {
  size(700, 600);
  smooth();
}

void draw() {
  background(0, 120, 255);  

  for (int i=0; i<7; i++) {
    line(i*100, 0, i*100, 600);
    line(0, i*100, 700, i*100);
  }

  for (int x=0; x<7; x++) {
    for (int y=0; y<6; y++) {
      if ( plateau[x][y] == 1) {
        fill(255, 0, 0);
        ellipse(50+x*100, 50+y*100, 90, 90);
      } else if (plateau[x][y] == 2) {
        fill(255, 255, 0);
        ellipse(50+x*100, 50+y*100, 90, 90);
      }
    }
  }

  if (!partie) {
    fill(255, 255, 255);
    textSize(32);
    text(result+" !", 50 ,100);
    text("NOTRE TEAM : #ISNDUSWAG", 50, 150);
    partie=false;
  }
}

void mouseClicked() {

  int x_clic=mouseX/100;
  int y_clic=mouseY/100;
  boolean placed=false;

  if (player == 1 && partie) {

    for (int i=6; i>0 && placed==false; i--) {
      if (plateau[x_clic][i-1] == 0) {
        plateau[x_clic][i-1]=1;
        check_plate_state();
        IA_turn(); 
        placed=true;
      }
    }
  }
}


void resultat(boolean point, int temp){
      if (point && temp==1)      {
        result="Vous avez gagné";
        partie=false;
      } else if (point && temp==2)      {
        result="Vous avez perdu"; 
        partie=false;
      }
} 


void check_plate_state () {
  ///////////////////////
  // COMPTE LES POINTS // 
  ///////////////////////

  for (int y=0; y<6; y++) { //TOUTES LES LIGNES Y
    for (int x=0; x<4; x++) { //TOUTES LES COLONNES X
      int temp=plateau[x][y];    
      boolean point=true;

      for (int curs_x=x; curs_x<x+4; curs_x++) { //POUR CHAQUE RANGÉE DE 4 PIONS
        if (plateau[curs_x][y]!=temp) //SI DISCONTINUITÉ
          point=false;
      }
      resultat(point, temp);
    }
  }


  for (int x=0; x<7; x++) { //TOUTES LES COLONNES X
    for (int y=0; y<3; y++) { //TOUTES LES LIGNES Y
      int temp=plateau[x][y];    
      boolean point=true;

      for (int curs_y=y; curs_y<y+4; curs_y++) { //POUR CHAQUE RANGÉE DE 4 PIONS
        if (plateau[x][curs_y]!=temp) //SI DISCONTINUITÉ
          point=false;
      }
      resultat(point, temp);
    }
  }

  //DIAGONALE G --> D

  for (int y=0; y<3; y++) { //TOUTES LES LIGNES Y
    for (int x=0; x<4; x++) { //TOUTES LES COLONNES X
      int temp=plateau[x][y];    
      boolean point=true;
      int curs_x=x;
      int curs_y=y;

      while (curs_x<x+4) {
        if (plateau[curs_x][curs_y]!=temp) //SI DISCONTINUITÉ
          point=false;    
        curs_x++;
        curs_y++;
      }
      resultat(point, temp);
    }
  }

   //DIAGONALE G <-- D

  for (int y=0; y<3; y++) { //TOUTES LES LIGNES Y
    for (int x=6; x>=3; x--) { //TOUTES LES COLONNES X
      int temp=plateau[x][y];    
      boolean point=true;
      int curs_x=x;
      int curs_y=y;

      while (curs_x>x-4) {
        if (plateau[curs_x][curs_y]!=temp) //SI DISCONTINUITÉ
          point=false;
        curs_x--;
        curs_y++;
      }
      resultat(point, temp);
    }
  }

  ////////////////////////////////////////////
  // VERIFIE QUE LE PLATEUR N EST PAS PLEIN //
  ////////////////////////////////////////////

  full_plate=true;
  for (int x=0; x<7; x++) {
    for (int y=0; y<6; y++) {
      if ( plateau[x][y] == 0)
        full_plate=false;
    }
  }

  if (full_plate) {
    result="Match nul";
    partie=false;
  }
}



void IA_turn() {

  boolean success=false;
  boolean placed=false;

  if (partie) {
    while (!success) {
      int x = int (random(0, 7));

      for (int i=6; i>0 && placed==false; i--) {
        if (plateau[x][i-1] == 0) {
          plateau[x][i-1]=2;
          placed=true;
          success=true;
          check_plate_state();
        }
      }
    }
  }
}

