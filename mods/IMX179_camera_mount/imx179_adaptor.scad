use <m3d/fn.scad>
use <m3d/threaded_inserts/cnc_kitchen.scad>


ti_side_off = 14;

module adapter()
{
  difference()
  {
    mirror([0, 1, 0])
      translate([0, 0, -0.85])
        rotate([0, 90, 180])
          import("models/imx179_adaptor.3mf");
    //fix threaded inset hole, to make it fit nicely
    for(dx=[-1,+1])
      for(dy=[-1,+1])
        translate(ti_side_off*[dx, dy, 0])
          rotate([180, 0, 0])
            ti_cnck_m2();
  }
}

rotate([0, 0, -90])
  adapter();
