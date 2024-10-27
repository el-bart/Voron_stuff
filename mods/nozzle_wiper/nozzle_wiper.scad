use <m3d/fn.scad>
use <m3d/rounded_cube.scad>
include <m3d/math.scad>

cut_d = 6;
cut_h = 6.25;
sponge_size = [70, 20, 115];
alu_to_edge_ox = 95;

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


module silicon_sponge_mock(h_cut)
{
  s = [sponge_size.x, sponge_size.z, sponge_size.y];
  intersection()
  {
    translate([0, 0, h_cut])
      rotate([-90, 0, 0])
        side_rounded_cube(s, 10);
    cube(sponge_size);
  }
}


module bed_mock()
{
  s = [350, 350, 14];
  translate([-s.x+alu_to_edge_ox, -s.y, 21.75-s.z + 20])
    cube(s);
}


module max_nozzle_pos()
{
  wall = 0.5;
  s = [110, 10, 10];
  translate([-s.x + alu_to_edge_ox, 0, 42])
    difference()
    {
      cube(s);
      translate([-wall, -wall, -eps])
        cube(s + [0,0,2*eps]);
    }
}


module nozzle_wiper(mocks)
{
  %if(mocks)
  {
    translate([0, -100, 0])
      alu_profile_20x20(200);
    silicon_sponge_mock(40);
    bed_mock();
    max_nozzle_pos();
  }
}


nozzle_wiper(mocks=$preview);
