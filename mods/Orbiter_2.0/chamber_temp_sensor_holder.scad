include <m3d/all.scad>

wall = 1.0;
d_int = 2.99 + 0.15;
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
  difference()
  {
    linear_extrude(h)
      profile_2d();
    translate([-d_ext/2, 5, h/2])
      cube([d_ext, d_ext, h]);
  }
}


holder();
