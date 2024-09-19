use <m3d/fn.scad>
include <m3d/math.scad>

cut_d = 6;
cut_h = 6.25;
wall = 2;
l = 50;
base_l = 53.1;
screw_d = 3;


module alu_profile_20x20(l)
{
  module crossection()
  {
    difference()
    {
      square([20,20], center=true);
      for(r=[0:90:360])
        rotate([0, 0, r])
          translate([-cut_d/2, 20/2-cut_h])
            square([cut_d, cut_h]);
    }
  }

  translate([0, 0, -(20-cut_d)/2])
    translate(20/2*[-1, 0, 1])
      rotate([-90, 0, 0])
        linear_extrude(l)
          crossection();
}


module led_strip(l)
{
  w = 8.2;
  h = 0.5;
  led_w = 3.2;
  led_l = 2.85;
  module led()
  {
    translate([(w-led_w)/2, 0, 0])
      cube([led_w, led_l, 1.25]);
  }

  cube([w, l, h]);
  for(dy = [5 : 8.5 : l-led_l])
    translate([0, dy, 0])
      led();
}


module mount(mocks=false)
{
  %if(mocks)
  {
    alu_profile_20x20(l=l);
    led_strip(l=l);
  }
}


//rotate([90, 0, 0])
  mount(mocks=true);
