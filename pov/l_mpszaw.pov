// Entry code: mpszaw
// Name      : Jeff Reifel
// Frame rate: 10
#local C=clock*pi;
#macro
 B(N,F)         // blob elements for wings and tail
 sphere{0,F/7,1
 scale 1-pow(I.5)
 translate-I*F*x 
 rotate y*N*90
 rotate-N*x*pow(5,I)*10*sin(I*2-C*8+i) // shapes and flaps wings
 scale.2+x*.8
 translate-x}
 #end
 #local i=C;
 #while(i<2*pi+C) // spaces and moves rays
 #local I=0;
 blob{
 #while(I<1)
 B(1,7)  // wing
 B(-1,7) //wing
 B(0,3)  // tail
 #local I=I+.01;
 #end 
 rotate<-90,cos(i*3)*-45,i*pi*36> //orients ray on knot
 translate<sin(i)+2*sin(2*i),5+cos(i)-2*cos(2*i),3*sin(3*i)+7>*2   //knot
 rotate x*37
 pigment{slope y}}
 #local i=i+pi/8;
 #end 
 light_source{<0,60,99> 1 spotlight}
 sphere { 0 100 pigment { rgbt 0.90 } hollow
  interior {
   media{
   intervals 6
   scattering{
   2
   rgb<0,3,1>/99}
   }
  }
 }

camera {
  #declare myRadius = 0.00001;
  #declare myClock = frame_number/final_frame;
  #declare myZ = -myRadius+14+myClock*2*myRadius;
  
  #if(myClock<0.5)
    #declare myValue = pow((sin(myClock*pi*4-pi/2)+1)/2,5);
  #else
    #declare myValue = -pow((sin(myClock*pi*4-pi/2)+1)/2,5);
  #end
  #declare myValue2 = pow((sin(myClock/2*pi*4-pi/2)+1)/2,5);
  
  #declare cameraLocationX = myValue*2;
  #declare cameraLocationY = myValue2*1;
  #declare cameraLocationZ = myZ;
  
  #declare ipd = 0.065;
  
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
}
