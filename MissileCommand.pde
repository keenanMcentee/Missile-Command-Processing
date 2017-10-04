/*
Authors: Keenan McEntee & Keith Wilson
Date Started: 22/09/2017
*/


import java.util.*;
int count;
final int NUM_OF_MISSILES = 5;
Missile[] friendlyMissile = new Missile[NUM_OF_MISSILES];
Missile[] enemyMissile = new Missile[NUM_OF_MISSILES];
boolean gameOver;
PImage endGame;
PFont font = new PFont();
void setup()
{
  font = createFont("ARIALNBI",32);
  textFont(font, 32);
  endGame = loadImage("Game_Over.jpg");
  gameOver = false;
  size(1960,1080);
  for (int i = 0; i < NUM_OF_MISSILES; i++)
  {
     friendlyMissile[i] = new Missile("friendly"); 
  }
  for (int i = 0; i < NUM_OF_MISSILES; i++)
  {
     enemyMissile[i] = new Missile("enemy"); 
  }
}

void draw()
{
  background(0);
  text("Score: "+ count, 10,50);
  if (!gameOver)
  {
    enemyMissileHandle();
  for (int i = 0; i < NUM_OF_MISSILES; i++)
   {
     friendlyMissile[i].update(); 
     enemyMissile[i].update();
   }
    for (int i = 0; i < NUM_OF_MISSILES; i++)
    {
     friendlyMissile[i].display(); 
     enemyMissile[i].display();
    }
    
    for(int i = 0; i < NUM_OF_MISSILES; i++)
    {
      if (friendlyMissile[i].m_velocity != null)
      {
        for (int j = 0; j < NUM_OF_MISSILES; j++)
         {
           if (enemyMissile[j].m_velocity != null){
             if(friendlyMissile[i].collideEnemyMissile(enemyMissile[j]))
             {
              count += 100 *  enemyMissile[j].speed;
             }
           }
         }
      }
     println(count);
    }
  }
  else
  {
    image(endGame,width/2.8,height/3);
  }
}
void mousePressed()
{
   //<>//
  for(int i = 0; i < NUM_OF_MISSILES; i++)
  {
     if (friendlyMissile[i].status == missileState.DEAD)
     {
       friendlyMissile[i].initialiseFriendly(new PVector(mouseX,mouseY));
       break;
     }
  }
  println("CLICKED");
}
void enemyMissileHandle()
{
  for(int i = 0; i <  NUM_OF_MISSILES; i++)
  {
     if (enemyMissile[i].status == missileState.DEAD)
     {
       enemyMissile[i].initialiseEnemy();
       enemyMissile[i].speed += 0.2;
       break;
     }
     if (enemyMissile[i].hitTarget() == true)
     {
       gameOver = true;
     }
  }
}