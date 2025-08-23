include <m3d/all.scad>

wall = 1.1;
d_int = 2.99 + 0.05;
d_ext = d_int + 2*wall;
over = 0.5;
h = 15 - 5;

module profile_2d()
{
  module body()
  {
    hull()
    {
      square([10, 0.01], center=true);
      translate([0,5])
        square([d_int, 0.01], center=true);
    }

    translate([0,5])
      circle(d=d_ext, $fn=fn(50));
  }

  difference()
  {
    body();
    translate([0,5])
      circle(d=d_int, $fn=fn(50));
    translate([-(d_int-over)/2, 5])
      square([d_int-over, d_ext]);
  }
}


module holder()
{
  linear_extrude(h)
    profile_2d();
}


holder();
