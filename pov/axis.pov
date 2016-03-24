#version 3.7;
global_settings {
    assumed_gamma 1
    ambient_light srgb <1,1,1>
}
#declare Grey50 = srgbft <0.0,0.0,0.0,0,0>;
background { color Grey50 }

#declare White = srgbft <1,1,1,0,0>;
#declare Light00 = light_source {
    <50,150,-250>, White
}
#declare Green = srgbft <0,1,0,0,0>;
#declare CylSide0 = cylinder {
    <-10,0,-10>, <10,0,10>, 1.01
    pigment { color Green }
    translate <0,10,0>
}
#declare CylSide1 = cylinder {
    <-10,-10,0>, <10,10,0>, 1.01
    pigment { color Green }
    translate <0,0,10>
}
#declare CylSide2 = cylinder {
    <10,0,-10>, <-10,0,10>, 1.01
    pigment { color Green }
    translate <0,-10,0>
}
#declare CylSide3 = cylinder {
    <10,-10,0>, <-10,10,0>, 1.01
    pigment { color Green }
    translate <0,0,-10>
}
#declare Red = srgbft <1,0,0,0,0>;
#declare CylCrn0 = cylinder {
    <-10,0,0>, <10,0,0>, 1.01
    pigment { color Red }
    translate <0,10,10>
}
#declare CylCrn1 = cylinder {
    <-10,0,0>, <10,0,0>, 1.01
    pigment { color Red }
    translate <0,-10,10>
}
#declare CylCrn2 = cylinder {
    <-10,0,0>, <10,0,0>, 1.01
    pigment { color Red }
    translate <0,-10,-10>
}
#declare CylCrn3 = cylinder {
    <-10,0,0>, <10,0,0>, 1.01
    pigment { color Red }
    translate <0,10,-10>
}
#declare Union00 = union {
    object { CylCrn0 }
    object { CylCrn1 }
    object { CylCrn2 }
    object { CylCrn3 }
    object { CylSide0 }
    object { CylSide1 }
    object { CylSide2 }
    object { CylSide3 }
}
#declare TextXp = text {
    internal 1 "X+"
    0.5, 0.0
    translate <-0.5,-0.5,-0.25>
    rotate y*90
    translate <1,0,0>
}
#declare TextXn = text {
    internal 1 "X-"
    0.5, 0.0
    translate <-0.5,-0.5,-0.25>
    rotate y*90
    translate <-1,0,0>
}
#declare TextYp = text {
    internal 1 "Y+"
    0.5, 0.0
    translate <-0.5,-0.5,-0.25>
    rotate x*-90
    translate <0,1,0>
}
#declare TextYn = text {
    internal 1 "Y-"
    0.5, 0.0
    translate <-0.5,-0.5,-0.25>
    rotate x*-90
    translate <0,-1,0>
}
#declare TextZp = text {
    internal 1 "Z+"
    0.5, 0.0
    translate <-0.5,-0.5,-0.25>
    translate <0,0,1>
}
#declare TextZn = text {
    internal 1 "Z-"
    0.5, 0.0
    translate <-0.5,-0.5,-0.25>
    translate <0,0,-1>
}
#declare Orange = srgbft <1,0.5,0,0,0>;
#declare Union01 = union {
    object { TextXp }
    object { TextXn }
    object { TextYp }
    object { TextYn }
    object { TextZp }
    object { TextZn }
    pigment { color rgb<1,0,0> }
}
#declare Sphere0 = sphere { <3,5,3>, 0.5 }
#declare Sphere1 = sphere { <-3,5,3>, 0.5 }
#declare Sphere2 = sphere { <3,-5,3>, 0.5 }
#declare Sphere3 = sphere { <-3,-5,3>, 0.5 }
#declare Sphere4 = sphere { <3,5,-3>, 0.5 }
#declare Sphere5 = sphere { <-3,5,-3>, 0.5 }
#declare Sphere6 = sphere { <3,-5,-3>, 0.5 }
#declare Sphere7 = sphere { <-3,-5,-3>, 0.5 }
#declare Magenta = srgbft <1,0,1,0,0>;
#declare Union02 = union {
    object { Sphere0 }
    object { Sphere1 }
    object { Sphere2 }
    object { Sphere3 }
    object { Sphere4 }
    object { Sphere5 }
    object { Sphere6 }
    object { Sphere7 }
    pigment { color rgb<0,0,1> }
}

object { Union00 }
object { Union01 }
object { Union02 }                   

#declare coordBox = 7;
box
{
    -coordBox,
    coordBox
    
    pigment 
        { 
                checker pigment{
                    rgb<0.5,0.5,0.5>
                    filter 0            
                    }, 
                    pigment{
                    rgb<0.3,0.3,0.3>                    
                    filter 0            
                    } 
                translate<0,0,0.5>
        }                                       
    hollow      
}          
    
    
light_source { <0,coordBox-0.1,0>, rgb<1,1,1>*2 }
  
  

sphere { <0,0,0.6> 0.03 pigment { rgb<1,1,0> } }
sphere { <-0.6,0,0> 0.03 pigment { rgb<1,1,0> } }
sphere { <0.6,0,0> 0.03 pigment { rgb<1,1,0> } }
sphere { <0,0,-0.6> 0.03 pigment { rgb<1,1,0> } }

  
#declare odsIPD = 0.065;

#declare odsLocationX = 0;
#declare odsLocationY = 0;
#declare odsLocationZ = 0;
camera {
      user_defined
      location {
        function {  odsLocationX + cos(((x+0.5)) * 2 * pi - pi)*odsIPD/2*select(-y,-1,+1) }
        function {  odsLocationY }
        function {  odsLocationZ + sin(((x+0.5)) * 2 * pi - pi)*odsIPD/2*select(-y,-1,+1) }
      }
      direction {
        function {  sin(((x+0.5)) * 2 * pi - pi) * cos(pi / 2 -select(y, 1-2*(y+0.5), 1-2*y) * pi) }
        function {  sin(pi / 2 - select(y, 1-2*(y+0.5), 1-2*y) * pi) }
        function {  -cos(((x+0.5)) * 2 * pi - pi) * cos(pi / 2 -select(y, 1-2*(y+0.5), 1-2*y) * pi) * -1}
      }
    }