use <m3d/fn.scad>
use <m3d/rounded_cube.scad>
include <m3d/math.scad>

cut_d = 6;
cut_h = 6.25;
sponge_size = [70, 20, 115];
alu_to_edge_ox = 95;
wall = 1.2;
box_size_ext = [alu_to_edge_ox+10, sponge_size.y+30, 20];


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
  translate(wall*[1,1,1])
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
  module mount_groove()
  {
    groove_w = cut_d - 0.2;
    depth = 2.2;
    module crossection()
    {
      translate([-groove_w/2 + 20/2, -depth])
        polygon([
          [sin(45)*depth, 0],
          [0, depth],
          [groove_w, depth],
          [groove_w, 0],
        ]);
    }

    rotate([-90, -90, 0])
      linear_extrude(box_size_ext.y)
        crossection();
  }

  module filament_sledge()
  {
    x = sponge_size.y;
    translate(wall*[1,1,1] + [sponge_size.x, 0, 0])
      rotate([90, 0, 90])
        linear_extrude(box_size_ext.x - sponge_size.x - 2*wall)
          polygon([
            [0, 0],
            [x, 0],
            [0, x-wall]
          ]);
  }

  module main()
  {
    difference()
    {
      cube(box_size_ext);
      translate(wall*[1,1,1])
        cube(box_size_ext - wall*[2,2,eps]);
    }
    mount_groove();
    filament_sledge();
  }

  main();
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
