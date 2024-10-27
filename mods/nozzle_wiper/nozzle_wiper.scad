use <m3d/fn.scad>
include <m3d/math.scad>

cut_d = 6;
cut_h = 6.25;

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

  translate(20/2*[-1, 0, 1])
    rotate([-90, 0, 0])
      linear_extrude(l)
        crossection();
}


alu_profile_20x20(10);
