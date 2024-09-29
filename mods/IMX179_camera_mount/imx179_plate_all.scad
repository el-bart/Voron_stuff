use <m3d/fn.scad>

module front()
{
  difference()
  {
    translate([0, 0, 10.85])
      rotate([0, 90, 0])
        import("models/imx179_front_panel.3mf");
    translate([0, 0, -1])
      cylinder(d=18.5, h=20, $fn=fn(50));
  }
}

module back()
{
  mirror([0, 1, 0])
    translate([0, 0, 5.85])
      rotate([0, -90, 0])
        import("models/imx179_back_panel.3mf");
}

module adapter()
{
  mirror([0, 1, 0])
    translate([0, 0, -0.85])
      rotate([0, 90, 180])
        import("models/imx179_adaptor.3mf");
}


front();
%if(true)
{
  translate([0, 0, 13.0])
  {
    rotate([180, 0, 0])
      back();
    adapter();
  }
}

translate([0, 40, 0])
  back();

translate([40, 20, 0])
  rotate([0, 0, -90])
    adapter();
