ArrayList<Temperture> data = new ArrayList<Temperture>(); //<>//
float max;
float min;
float slide = -2000;
float slideup1 = 2000;
float slideup2 = 3000;
float slideup3 = 4000;
int mode = 1;


void setup()
{
  size(800,800);
}


void draw()
{
   
        background(200);
        stroke(255);
        textSize(16);
        loaddata();
        max = maxtemp(data);
        min = mintemp(data);

          switch(mode)
        {
          case 1:
          {
            home();
            slide = -2000;
            break;
          }
  
          case 2:
          {
            circleyears();
            break;
          }
         
          case 3:
          {
            drawgraph();
            drawGDPAmount();
            slide = -2000;
            break;
          }
          
        } // end switch
        
} // end draw()


void loaddata()
{
  String[] lines = loadStrings("tempertures.csv"); 
         
        for(String s:lines)
        {
          Temperture temp = new Temperture(s);
          data.add(temp);
        }
} // end loaddata()


void drawgraph()
{
       float border = width * 0.15f;
       
        
       if (mouseX >= border && mouseX <= width - border)
      {
        float x = map(mouseX,0,width,255,0);
        float y = map(mouseX,0,width,0,255);
        background(y,0,x);
        stroke(x,0,y);
      }
      
    
      //stroke(0, 0, 255);
      
      int border2 = 25;
      float firstvalue = data.get(0).annual;

      for (int i = 1 ; i < 81 ; i ++)
      {
        float rx1 = map((i - 1),0,81,border,width - border);
        float rx2 = map((i),0,81,border,width - border);
        float ry1 = map(data.get(i - 1).annual,min,max,border,height-border);
        float ry2 = map(data.get(i).annual,min,max,border,height-border);
        
        line(rx1, height - ry1, rx2,height - ry2);
       }
       int shift = 0;
       
       for(int j = 0; shift < 610; j += 10)
       {
         text((int)data.get(j).year,(border - 25) + shift,height - border + 25);
         shift += 70;
       }
      
         float zero = map(data.get(0).annual,-47,74,border,height-border);
              
         text(0 + " °C",border-border2 - 20,height - zero + firstvalue+5);
         
         text((int)max + " °C",border-border2 - 20,border);
        
         text((int)min + " °C",border-border2 - 30,height - border);
      
         stroke(0,0,255);
         //0-axis
         line(border,height - zero + firstvalue ,width - border,height - zero + firstvalue);
         //y-axis
         line(border,border,border,height-border);
         //x-axis
         line(border,height-border,width-border,height-border);
         
}// end draw graph








void circleyears()
{
    int i = 0;
    float xborder = width * 0.1f;
    
   for (float y = xborder ; y < height - xborder; y += 75)
  {
    for (float x = xborder ; x < width - xborder; x += 75)
    {
      
        if(data.get(i).annual >= 0)
        {
          stroke(255,0,0);
          fill(255,0,0);
          text("Red is values above 0",400,75);
          textSize(16);
        }
        else
        {
          stroke(0,0,255);
          fill(0,0,255);
          text("Blue is values below 0",400,50);
          textSize(16);
        }
        
          ellipse(x + 27.5 + slide ,y  + 27.5,data.get(i).annual,data.get(i).annual);
          i++;
          slide += 0.3;
        }
        
            if(slide >= 0)
          {
            slide = 0;
          }
         
        stroke(0);
        fill(0);
        
        if(slide == 0)
        {
          // code for getting the values of the circles
          if(mouseX > xborder && mouseY > xborder && mouseX < width - xborder  && mouseY < height - xborder )
          {
            
            int dw = (int) map(mouseX, xborder, width - xborder, 0, 9);
            int dh = (int) map(mouseY, xborder, width - xborder, 0,9);
        
            ellipse(110 + (dw * 75)-3,110  + (dh * 75)-3,10,10); // little black ball

            if(dh < 1)
            {
              text((int)data.get(dw).annual + " °C",50,50);
              text((int)data.get(dw).year,50,75);
              textSize(16);
            }
          
            else
            {
              text((int)data.get(dh * 9 + dw).annual + " °C",50,50);
              text((int)data.get(dh * 9 + dw).year,50,75);
              textSize(16);
            }
        }
     }

}
  
} // end circleyears

     



void drawGDPAmount()
{
  float border = width * 0.15f;
  
  if (mouseX >= border && mouseX <= width - border)
  {
    stroke(255, 0, 0);
    fill(255, 0, 0);
    line(mouseX, border, mouseX, height - border);
    int i = (int) map(mouseX, border, width - border, 0, 80);
    float y = map(data.get(i).annual, min, max, height - border, border);
    ellipse(mouseX, y, 5, 5);
    fill(255);
    text((int)data.get(i).year, 50, 75);
    text((int)data.get(i).annual + " °C", 50, 50);
    textSize(16);
  }
} // drawGDPAmount()



void home()
{
      // HOME PAGE GRAPH
      stroke(0, 0, 255);
      float border = width * 0.5f; 


      for (int i = 1 ; i < 81 ; i ++) 
      {
        float rx1 = map((i - 1),0,81,border,width);
        float rx2 = map((i),0,81,border,width);
        float ry1 = map(data.get(i - 1).annual,min,max,border,height);
        float ry2 = map(data.get(i).annual,min,max,border,height);
        line(rx1, height - ry1, rx2 ,height - ry2);
       }

         //y-axis
         line(width / 2,0,border,height / 2);
         //x-axis
         line(0 ,height / 2,width,height / 2);
 
         
     // HOME PAGE CIRCLES
         
    float xborder = width * 0.1 / 2f;
    int i = 0;
  
  for (float y = xborder; y < height  / 2 - xborder; y += 75 / 2)
  {
    for (float x = xborder ; x < width  / 2 - xborder; x += 75 / 2)
    {
        
        if(data.get(i).annual >= 0)
        {
          stroke(255,0,0);
          fill(255,0,0);
        }
        else
        {
          stroke(0,0,255);
          fill(0,0,255);
        }
          ellipse(x + 27.5  / 2,y  + 27.5 / 2,data.get(i).annual  / 2,data.get(i).annual / 2);
          i++;
        }
      
  }
  
          textSize(32);
          text("The Earths Temperture from 1933 - 2013", width / 2 - 300, height / 2 + 50);
          text("1 HomePage", width / 2 - 100,(height / 2) + 100 +  slideup1);
          slideup1 -= 30;
          
          if(slideup1 <= 0)
          {
            slideup1 = 0;
          }
 
 
          text("2 Circle Graph" ,width / 2 - 100, height / 2 + 150 +  slideup2);
          slideup2 -= 40;
          if(slideup2 <= 0)
          {
            slideup2 = 0;
          }  
        
        
          text("3 Line Graph", width / 2 - 100, height / 2 + 200 +  slideup3);
          slideup3 -= 45;
          if(slideup3 <= 0)
          {
            slideup3 = 0;
          }
        
        
} // end home()


void keyPressed()
{
  if (key >= '0' && key <='9')
  {
    mode = key - '0';
  }
  println(mode);
} // End keyPressed()



// Method for calculating the max

float maxtemp(ArrayList<Temperture> data) 
{
  float max = 0.0f;
  max = data.get(0).annual;
  
  for(int i = 0; i < data.size(); i ++)
  {
    if(data.get(i).annual > max)
    {
      max = data.get(i).annual;
    }
  }
  return max;
  
}//end max



// Method for calculating the min

float mintemp(ArrayList<Temperture> data) 
{
  float min = 0.0f;
  min = data.get(0).annual;
  
  for(int i = 0; i < data.size(); i ++)
  {
    if(data.get(i).annual < min)
    {
      min = data.get(i).annual;
    }
  }
  return min;
  
} // end min