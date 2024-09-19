use <m3d/fn.scad>
include <m3d/math.scad>

cut_d = 6;
cut_h = 6.25;

led_w = 8.2;
led_l = 2.85;
led_angle = 25; // [deg]

wall = 2;
l = 350;
spacing = 1.2;

screw_d = 3;
holes = 3;
hole_d = screw_d + 0.5;
hole_side_clearance = 10;

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

  translate([0, 0, -spacing])
    translate(20/2*[-1, 0, 1])
      rotate([-90, 0, 0])
        linear_extrude(l)
          crossection();
}


module led_strip(l)
{
  w = 3.2;
  h = 0.5;

  module led()
  {
    translate([(led_w-w)/2, 0, 0])
      cube([w, led_l, 1.25]);
  }

  cube([led_w, l, h]);
  for(dy = [5 : 8.5 : l-led_l])
    translate([0, dy, 0])
      led();
}


module mount(mocks=false)
{
  module mount_wall()
  {
    assert(holes >= 2);

    ml = 20 - 2*spacing;
    groove_w = cut_d - 0.5;
    depth = 2;

    module crossection()
    {
      square([ml, wall]); // top mount
      // chamfered froove fill
      translate([-groove_w/2 + 20/2 - spacing, -depth])
        polygon([
          [sin(45)*depth, 0],
          [0, depth],
          [groove_w, depth],
          [groove_w, 0],
        ]);
    }

    module all_holes()
    {
      inter_hole = (l - 2*hole_d/2 - 2*hole_side_clearance) / (holes-1);
      for(dy=[0:holes-1])
        translate([0, hole_side_clearance + dy*inter_hole, 0])
          translate([0, hole_d/2, 20/2-spacing])
            translate([+wall+eps, 0, 0])
              rotate([0, -90, 0])
                cylinder(d=hole_d, h=cut_h+2*eps, $fn=fn(50));
    }

    difference()
    {
      rotate([-90, -90, 0])
        linear_extrude(l)
          crossection();
      all_holes();
    }
  }

  module led_support(mocks)
  {
    w = led_w + 2*1;
    h = w * sin(led_angle);
    x = w * cos(led_angle);
    translate([wall, l, 0])
      rotate([90, 0, 0])
        linear_extrude(l)
          polygon([
            [0, 0],
            [0, h],
            [x, 0]
          ]);

    %if(mocks)
      translate([wall, 0, h])
        rotate([0, led_angle, 0])
          led_strip(l=l);
  }


  mount_wall();
  led_support(mocks);

  %if(mocks)
    alu_profile_20x20(l=l);
}


rotate([0, 0, -45]) // 350mm print on 350mm? sure - diagonal!
  mount(mocks=true);
