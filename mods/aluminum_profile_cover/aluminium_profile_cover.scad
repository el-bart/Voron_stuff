use <m3d/fn.scad>
include <m3d/math.scad>

module cover(l)
{
  th = 0.55;
  module crossection_thin()
  {
    // bottom
    translate([-7.16/2, 0])
      square([7.16, eps]);
    // side walls
    for(dir=[-1,+1])
      translate([dir*-6/2, 0])
        rotate([0, 0, dir*10])
        {
          square([eps, 2.36]);
          translate([0, 2.36])
            rotate([0, 0, dir*-40])
              square([eps, 0.66]);
        }
  }

  module element()
  {
    linear_extrude(l)
      translate([0, th/2])
        minkowski()
        {
          crossection_thin();
          circle(d=th, $fn=fn(20));
        }
  }

  translate([0, l])
    rotate([90, 0])
      element();
}

cover(l=90);
