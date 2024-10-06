use <m3d/fn.scad>
use <m3d/rounded_cube.scad>
include <m3d/math.scad>

cut_d = 6;
cut_h = 6.25;

cover_ext_size = [30, 35+10, 2.5];
edge_space = 0.5;


module alu_profile_20x20()
{
  l = 30;
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

  translate(20/2*[0, 1, -1] + [0, -edge_space, 0])
    rotate([90, 0, 90])
      linear_extrude(l)
        crossection();
}


module cover(mocks)
{
  module plate()
  {
    s = cover_ext_size;
    sb = [s.x, s.y, eps];
    off_xy = 1.5;
    st = sb - 2*off_xy*[1,1,0];
    r = 3;
    hull()
    {
      $fn=fn(50);
      side_rounded_cube(sb, r);
      translate(off_xy*[1,1,0] + [0, 0, s.z-eps])
        side_rounded_cube(st, r);
    }
  }

  module mount_screw_hole()
  {
    screw_d = 3;
    hole_d = screw_d + 0.5;
    translate([cover_ext_size.x/2, 20/2 - edge_space, -eps])
      cylinder(d=hole_d, h=cover_ext_size.z + 2*eps, $fn=fn(50));
  }

  module cable_groove()
  {
    dy = 35;
    cable_space_d = 5.5 + 0.5;

    module groove_profile()
    {
      l = 30/2 + eps;
      top = 1;
      bot = 2;
      h = cover_ext_size.z + 2*eps;
      translate([-eps, 0, -eps])
        rotate([90, 0, 90])
          linear_extrude(l)
            polygon([
              [-bot/2, 0],
              [-top/2, h],
              [+top/2, h],
              [+bot/2, 0],
            ]);
    }

    translate([cover_ext_size.x/2, dy, -eps])
      cylinder(d=cable_space_d, h=cover_ext_size.z + 2*eps, $fn=fn(50));
    translate([0, dy, 0])
      groove_profile();
  }

  difference()
  {
    plate();
    mount_screw_hole();
    cable_groove();
  }

  %if(mocks)
    alu_profile_20x20();
}


cover(mocks=$preview);
