/*
 Based on mirrors.pov by Fabrizio Carimati Posted on November 23, 2009
 See https://www.clodo.it/blog/mirrors/
*/

#version 3.7;

#include "colors.inc"
#include "functions.inc" 
#include "rad_def.inc"

#include "textures.inc"
#include "stars.inc"
#include "skies.inc"

#declare myMode = 3;
#declare myClock = frame_number/final_frame;
#declare smoothClock = (sin(myClock*pi-pi/2)+1)/2;       
#declare myRadius = 19;

global_settings { ambient_light rgb<0,0,0> max_trace_level 100 assumed_gamma 1.0}       

#declare BoxCount=0;   
#declare BoxNumber=20;
#while (BoxCount < BoxNumber)
  #declare BoxSize = 2.2;
  box { <-BoxSize,0,-1+0.1>, <BoxSize,BoxSize*4,1>        
    rotate 360/BoxNumber*BoxCount * y
    translate <sin(BoxCount*2*pi/BoxNumber)*myRadius, -0 ,cos(BoxCount*2*pi/BoxNumber)*myRadius>
    texture {Chrome_Texture}
    //pigment { White }
    pigment { Gray }
    finish { emission 0 ambient White diffuse 0.8 reflection {0.01 metallic}}            
  }
  
  box {                            
    <-BoxSize+0.3,0.3,-1+0.5>,
    <BoxSize-0.3,BoxSize*4-0.3,-1>        
    
    rotate 360/BoxNumber*BoxCount * y
    translate <sin(BoxCount*2*pi/BoxNumber)*myRadius, -0 ,cos(BoxCount*2*pi/BoxNumber)*myRadius>
    pigment {Red} finish { ambient 0 diffuse 0 reflection 1.0 }
  }
  #declare BoxCount=BoxCount+1;
#end

plane { y, -0
  pigment { 
    checker pigment{White}, pigment{Black} 
    translate<0,0,0.5>
  }
  finish { reflection {0.6} }
}

sky_sphere{
  pigment{ gradient y
    color_map{
      [0.0 color rgb<1,1,1> ]
      [0.3 color rgb<0.18,0.28,0.75>*0.8]
      [1.0 color rgb<0.15,0.28,0.75>*0.5]}
    scale 1.05
    translate<0,-0.05,0>
  }
}

// spherical cloud layer
#declare R_planet = 6000000;
#declare R_sky    = R_planet + 2000;
sphere{ <0, -R_planet, 0>, R_sky hollow
  texture{
    pigment{ bozo turbulence 0.75
      octaves 6  omega 0.7
      lambda 2  phase 0.15
      color_map {
        [0.00 color rgb <1,1,1>*0.95]
        [0.05 color rgb <1,1,1>*1.25]
        [0.15 color rgb <1,1,1>*0.85]
        [0.55 color rgbt<1,1,1,1>]
        [1.00 color rgbt<1,1,1,1>]
      } // end color_map
      translate< 3, 0,-1>
      scale<0.3, 0.4, 0.2>*3
    } // end pigment
    #if(version = 3.7)
      finish{emission 1 diffuse 0}
    #else finish{ ambient 1 diffuse 0}
    #end
    scale 3000
  } // end texture
  // no_shadow // optional!!
} // end of sphere ---------------------

light_source {
  <0,50,0>
  color rgb <1,1,1>*2
  spotlight
  radius 80
  falloff 50
  tightness 20
  point_at <0, 0, 0>
}

#declare distanceCam = 4 + smoothClock*6;
#declare cameraRotationClock = smoothClock + 1/24;

camera 
{
  #declare myZ = -myRadius+1+myClock*2*myRadius;
  
  #if(myClock<0.5)
    #declare myValue = pow((sin(myClock*pi*4-pi/2)+1)/2,5);
  #else                                                          
    #declare myValue = -pow((sin(myClock*pi*4-pi/2)+1)/2,5);
  #end                                                           
  #declare myValue2 = pow((sin(myClock/2*pi*4-pi/2)+1)/2,5);
  
  #if(myMode=4) 
    spherical
    angle 360  // horizontal
    180  // vertical(optional)
    location<myValue*5,2.5+myValue2*3,myZ>
    look_at<0,2.5,myRadius>
  
    rotate<0,0,-myValue*5>
  #end
  
  #declare cameraLocationX = myValue*5;
  #declare cameraLocationY = 2.5+myValue2*3;
  #declare cameraLocationZ = myZ;

  #declare ipd = 0.065;

#if(myMode=3) // ODS top/bottom
  user_defined
  location {
    function { cameraLocationX + cos(((x+0.5)) * 2 * pi - pi)*ipd/2*select(y,-1,+1) }
    function { cameraLocationY }
    function { cameraLocationZ + sin(((x+0.5)) * 2 * pi - pi)*ipd/2*select(y,-1,+1) }
  }
  direction {
    function {  sin(((x+0.5)) * 2 * pi - pi) * cos(pi / 2 -select(y, 1-2*(y+0.5), 1-2*y) * pi) }
    function {  sin(pi / 2 - select(y, 1-2*(y+0.5), 1-2*y) * pi) }
    function { -cos(((x+0.5)) * 2 * pi - pi) * cos(pi / 2 -select(y, 1-2*(y+0.5), 1-2*y) * pi) * -1}
  }
#end
#if(myMode=2) // ODS left/right
  user_defined
  location {
    function { cameraLocationX + cos(select(x,(x+0.5)*2,(x*2)) * 2 * pi - pi)*ipd/2*select(x,-1,1) }
    function { cameraLocationY }
    function { cameraLocationZ + sin(select(x,(x+0.5)*2,(x*2)) * 2 * pi - pi)*ipd/2*select(x,-1,1) }
  }
  direction {
    function { sin(select(x,(x+0.5)*2,(x*2)) * 2 * pi - pi) * cos(pi / 2 -
      (1-(y+0.5))*pi) }
    function { sin(pi / 2 - (1-(y+0.5))*pi) }
    function { cos(select(x,(x+0.5)*2,(x*2)) * 2 * pi - pi) * cos(pi / 2 -
      (1-(y+0.5))*pi) }
  }
  rotate<0,0,-myValue*5> // ?
#end
#if(myMode=0)                           
  #declare myZ = -myRadius+1+myClock*2*myRadius;
  
  #if(myClock<0.5)
    #declare myValue = pow((sin(myClock*pi*4-pi/2)+1)/2,5);
  #else                                                          
    #declare myValue = -pow((sin(myClock*pi*4-pi/2)+1)/2,5);
  #end                                                           
  #declare myValue2 = pow((sin(myClock/2*pi*4-pi/2)+1)/2,5);
  
  location<myValue*5,2.5+myValue2*3,myZ>
  look_at<0,2.5,myRadius>
  
  rotate<0,0,-myValue*5>
  
#end
  #if(myMode=1)                      
  location<0,100,0>
  look_at <0, 0.0, 0.0>
#end

  right x*1920/1080
}