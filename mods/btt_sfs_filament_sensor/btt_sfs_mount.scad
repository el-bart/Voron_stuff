use <m3d/fn.scad>
include <m3d/math.scad>

cut_d = 6;
cut_h = 6.25;
wall = 2;
l = 25.4;
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


module mount(mocks=false)
{
  ds = 20 - (20 - cut_d)/2;

  module body()
  {
    module core()
    {
      module crossection()
      {
        square([ds+wall, wall]); // top mount
        translate([0.5/2, -2])
          square([cut_d-0.5, 2]); // groove fill
        translate([ds, -ds])
        {
          square([wall, ds]); // side mount
          translate([wall, 0])
            square([base_l, wall]); // sensor base
        }
      }
      translate([0, l])
        rotate([90, 0, 0])
          translate([-ds, ds])
            linear_extrude(l)
              crossection();
    }

    module sensor_mount_holes()
    {
      module hole()
      {
        cylinder(d=screw_d + 0.5, h=wall+2*eps, $fn=fn(50));
      }
      sx = 24.7;
      sy = 12.4;
      translate([-sx/2 + wall + base_l/2, 4.3, -eps])
      {
        hole();
        translate([0, sy, 0])
          hole();
        translate([sx, 0, 0])
          hole();
      }
    }

    difference()
    {
      core();
      translate([-ds + cut_d/2, l/2])
        cylinder(d=screw_d + 0.5, h=2*ds, $fn=fn(50));
      sensor_mount_holes();
    }
  }

  body();
  if(mocks)
    %alu_profile_20x20(l=l);
}


rotate([90, 0, 0])
  mount(mocks=true);
