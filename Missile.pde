import java.util.*;

public enum missileState{ ALIVE, DEAD, EXPLODING };
class Missile
{
   Random rng = new Random();
   public missileState status = missileState.DEAD; 
   PVector m_position;
   PVector m_startPos;
   PVector m_target;
   String m_type;
   public PVector m_velocity;
   float radius;
   public float speed = 2;
   float timer;
   float[] rgb = {0,0,0};
   public PVector m_heading;
   boolean targetHit = false;
   Missile(String type)
   {
     m_type = type;
   }
   void initialiseFriendly(PVector destination)
   {
     
     m_startPos = new PVector(width/2, height);
     m_position = new PVector(m_startPos.x, m_startPos.y);
     m_target = new PVector(destination.x, destination.y);
     m_heading = new PVector();
     m_heading = PVector.sub(m_target, m_startPos).normalize();
     speed = 5;
     radius = 0;
     m_velocity = null;
     status = missileState.ALIVE;
     rgb[2] = 255;
   }
   void initialiseEnemy()
   {
      m_startPos = new PVector(rng.nextInt((width - 0) + 1) + 0, 0);
      m_position = new PVector(m_startPos.x, m_startPos.y);
      m_target = new PVector(rng.nextInt((width - 0) + 1) + 0, height);
      m_heading = new PVector();
     m_heading = PVector.sub(m_target, m_startPos).normalize();
     m_velocity = null;
     status = missileState.ALIVE;
     rgb[0] = 255;
   }
   void update()
   {
     switch (status) {
       case ALIVE:
       {
          goToPoint(m_target, m_position);
          break; 
       }
       case DEAD:
       {
          break; 
       }
       case EXPLODING:
       {
          radius += 10;
          if (timer + 500 < millis())
          {
             status = missileState.DEAD; 
             m_position = m_startPos;
             radius = 0;
          }
          break; 
       }
       
     }
   }
   
   void display()
   {
     switch (status) {
       case ALIVE:
       {
          stroke(rgb[0],rgb[1],rgb[2]);
          line(m_startPos.x, m_startPos.y, m_position.x, m_position.y);
          break; 
       }
       case DEAD:
       {
          break; 
       }
       case EXPLODING:
       {
          fill(255,128,0);
          ellipse(m_position.x,m_position.y,radius,radius);
          break; 
       }
       
     }
   }
   void goToPoint(PVector target,PVector pos)
   {
     if (target != null)
    {
        
        if (m_velocity == null)
        {
          m_velocity = PVector.mult(m_heading,speed); 
        }
        else
        {
           pos.add(m_velocity); 
           if (PVector.sub(pos, target).mag() < 5)
           {
              m_velocity.set(0,0);
           }
        }
     
        if (m_velocity.x == 0 && m_velocity.y == 0 && status == missileState.ALIVE)
        { //<>//
           status = missileState.EXPLODING;
           radius = 0;
           timer = millis();
           targetHit = true;
        }
        
    }
   }
   boolean collideEnemyMissile(Missile m)
   {
     
     if (PVector.sub(m.m_position, this.m_position).mag() < radius-10)
     {
        m.status = missileState.DEAD; 
        return true;
     }
     else
     {
      return false; 
     }
     
   }
   boolean hitTarget()
   {
    return targetHit;
   }
}