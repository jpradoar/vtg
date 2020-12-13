// main
// Copyright (C) Henrik Björkman www.eit.se/hb
// Created by Henrik Björkman 2013-05-15
// Gnu public license v3


// http://en.wikipedia.org/wiki/Tiger_I
// http://www.dailymail.co.uk/news/article-2123736/Back-70-years-mighty-Tiger-tank-Only-surviving-example-works-restored-wartime-specification.html
// http://www.worldwar2aces.com/tiger-tank/tiger-tank.htm


include<henriks_generic_modules.scad>
//include<parameters.scad>
//include<modules.scad>


// x = forward
// y = left
// z = up


// For H0 scale (1:87) use  1000/87 here (or use other desired scale):
//x=1000/87;
//x=40/6.316;
x=1000/(160); // N scale

// Example of measurements in meters of a tiger I tank
// Numbers here are in meters.
length_with_gun=8.45*x;  // 53.5
length=6.316*x;  // 40
width_with_tracks=3.72*x;    // 23.56
height_to_hull=1.78*x;     // 11.27
height_to_cupola=3.00*x;



// We can't print thinner than 1 mm so this may need to be adjusted 
// in small scales
//cannon_outer_diam=2*0.088*x; // Just a guess, inner diam was 88 mm
cannon_outer_diam=3*0.088*x;


wheel_diam=height_to_hull*0.5; // actual wheel dialmeter was 0.80 m
lower_wheel_1_x=length*0.30;
lower_wheel_2_x=length*0.10;
lower_wheel_3_x=-length*0.10;
lower_wheel_4_x=-length*0.30;
upper_front_wheel_x=length*0.86/2;
upper_rear_wheel_x=-length*0.87/2;

lower_inner_wheel_1_x=(lower_wheel_1_x+lower_wheel_2_x)/2;
lower_inner_wheel_2_x=(lower_wheel_2_x+lower_wheel_3_x)/2;
lower_inner_wheel_3_x=(lower_wheel_3_x+lower_wheel_4_x)/2;
lower_inner_wheel_4_x=(lower_wheel_4_x+upper_rear_wheel_x)/2;

// uncomment one of the below

//all_together();



module tracks_outer(factor)
{
  hull()
  {
     all_wheels(factor);
  }
}


module all_wheels(factor)
{
     // upper front wheel
     translate([upper_front_wheel_x, 0, 0.37*height_to_hull])
     rotate([90,0,0])
     h_cylinder(wheel_diam*factor/2,width_with_tracks*0.2);

     // upper rear wheel
     translate([upper_rear_wheel_x, 0, 0.3*height_to_hull])
     rotate([90,0,0])
     h_cylinder(wheel_diam*factor*0.9/2,width_with_tracks*0.175);

     // lower wheels
     translate([lower_wheel_1_x, 0, wheel_diam*0.95/2])
     rotate([90,0,0])
     h_cylinder(wheel_diam*factor/2,width_with_tracks*0.2);

     translate([lower_wheel_2_x, 0, wheel_diam*0.95/2])
     rotate([90,0,0])
     h_cylinder(wheel_diam*factor/2,width_with_tracks*0.2);

     translate([lower_wheel_3_x, 0, wheel_diam*0.95/2])
     rotate([90,0,0])
     h_cylinder(wheel_diam*factor/2,width_with_tracks*0.2);

     translate([lower_wheel_4_x, 0, wheel_diam*0.95/2])
     rotate([90,0,0])
     h_cylinder(wheel_diam*factor/2,width_with_tracks*0.2);
  
     // lower inner wheels
     translate([lower_inner_wheel_1_x, 0, wheel_diam*0.95/2])
     rotate([90,0,0])
     h_cylinder(wheel_diam*factor/2,width_with_tracks*0.15);

     translate([lower_inner_wheel_2_x, 0, wheel_diam*0.95/2])
     rotate([90,0,0])
     h_cylinder(wheel_diam*factor/2,width_with_tracks*0.15);

     translate([lower_inner_wheel_3_x, 0, wheel_diam*0.95/2])
     rotate([90,0,0])
     h_cylinder(wheel_diam*factor/2,width_with_tracks*0.15);

     translate([lower_inner_wheel_4_x, 0, wheel_diam*0.95/2])
     rotate([90,0,0])
     h_cylinder(wheel_diam*factor/2,width_with_tracks*0.15);
}


module tracks()
{
   difference()
   {
      tracks_outer(1);
      translate([0,width_with_tracks*0.10,0])
      tracks_outer(0.7);
   }

   all_wheels(0.9);

}


module body()
{
  // lower body

  translate([0, 0, 0.45*height_to_hull])
  hull()
  {
    cube([length*0.70,width_with_tracks*0.60,height_to_hull*0.45], center=true);
    cube([length,width_with_tracks*0.60,height_to_hull*0.30], center=true);
  }

  // upper body
  translate([-length*0.15/2, 0, 0.65*height_to_hull])
  cube([length*0.85,width_with_tracks*0.75,0.4*height_to_hull], center=true);

  // Drivers viewing hatch
  translate([-length*0.15/2 + length*0.85/2, width_with_tracks*0.15, 0.75*height_to_hull])
  cube([length*0.02,width_with_tracks*0.18,height_to_hull*0.1], center=true);


  // front machine gun
  translate([-length*0.15/2 + length*0.85/2, -width_with_tracks*0.15, 0.75*height_to_hull])
  sphere(width_with_tracks*0.035,$fs=0.5);


  // engine hood or whatever, needed to put something there
  translate([-length*0.4, 0, 0.84*height_to_hull])
  cube([length*0.15,length*0.3,height_to_hull*0.1], center=true);

  // mount for turret
  translate([0, 0, 0.84*height_to_hull])
  h_cylinder(width_with_tracks*0.25,height_to_hull*0.1);

  // left hatch (drivers hatch)
  translate([length*0.28, width_with_tracks*0.15, 0.84*height_to_hull])
  h_cylinder(width_with_tracks*0.08,height_to_hull*0.06);

  // right hatch 
  translate([length*0.28, -width_with_tracks*0.15, 0.84*height_to_hull])
  h_cylinder(width_with_tracks*0.08,height_to_hull*0.06);

}


module cannon()
{

    // cannon fitting
    translate([0, 0, -length*0.16])
    //rotate([0,90,0])
    //h_cylinder(2*cannon_outer_diam/2,width_with_tracks*0.75/2);
    cube([length_with_gun*0.12,length_with_gun*0.06,length_with_gun*0.04], center=true);

    h_cylinder(cannon_outer_diam/2,length_with_gun*0.5);

    translate([0, 0, -length_with_gun*0.15])
    h_cylinder(1.8*cannon_outer_diam/2,length_with_gun*0.3);

    translate([0, 0, -length_with_gun*0.10])
    h_cylinder(1.4*cannon_outer_diam/2,length_with_gun*0.4);
    
    translate([0, 0, length_with_gun*0.25])
    h_cylinder(1.4*cannon_outer_diam/2,length_with_gun*0.05);

}

module turret()
{

  // rear part of turret
  translate([-length*0.45/4, 0, height_to_hull*1.1])
  //sphere(8, $fa=5, $fs=0.1); 
  cube([length*0.45/2,length*0.25,height_to_hull*0.42], center=true);

  // center and front part
  hull()
  {
    // front part
    translate([length*0.45/4, 0, height_to_hull*1.06])
    cube([length*0.45/2,length*0.25,height_to_hull*0.4], center=true);

    // center part
    translate([0, 0, height_to_hull*1.1])
    difference()
    {
      h_cylinder(width_with_tracks*0.7/2,height_to_hull*0.42);

      translate([length/2+width_with_tracks*0.75/4, 0, 0])
      cube([length,length,height_to_hull], center=true);
    }
  }


  

  // big hatch
  translate([-length*0.08, 0.14*width_with_tracks, height_to_hull*1.25])
  h_cylinder(0.10*width_with_tracks,height_to_hull*0.25);


  // small hatch
  translate([-length*0.03, -0.2*width_with_tracks, height_to_hull*1.25])
  h_cylinder(0.08*width_with_tracks,height_to_hull*0.15);

  // vent
  translate([-length*0.01, 0, height_to_hull*1.25])
  h_cylinder(0.03*width_with_tracks,height_to_hull*0.2);

  // periscope?
  translate([length*0.12, -0.2*width_with_tracks, height_to_hull*1.25])
  cube([length*0.03,length*0.03,length*0.05], center=true);


  // cannon
  translate([15/40*length, 0, height_to_hull*1.07])
  rotate([90,0,90])
  cannon();
}

module body_and_tracks()
{
  body();

  // right tracks
  mirror([0,1,0])
  translate([0, width_with_tracks*0.4, 0])
  tracks();

  // left tracks
  translate([0, width_with_tracks*0.4, 0])
  tracks();

  // axle to mount turret on
  translate([0, 0, height_to_hull])
  rotate([0,0,90])
  h_cylinder(2,4);

}

module turret_with_mounting_hole()
{
  translate([0, 0, 0.2])
  difference() 
  {
    turret();

    // hole for axle for turret
    translate([0, 0, height_to_hull])
    rotate([0,0,90])
    h_cylinder(2.1,4*1.2);
  }


}


module all()
{
  body_and_tracks();
  turret_with_mounting_hole();
}


// model needs to be printed in 2 pieces,
// preferably in a vertical position, that is standing on its back

// uncomment one of these when exporting to stl:

all();
//body_and_tracks();
//turret_with_mounting_hole();






