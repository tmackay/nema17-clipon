// OpenSCAD Ender 3 Clip-On Extruder
// (c) 2020, tmackay
//
// Licensed under a Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) license, http://creativecommons.org/licenses/by-sa/4.0.

// Thickness of bracket wall
wall=3;
// Tolerance for split
tol=0.4;
// Layer height for vertical clearance
layer_h=0.2;
// Width of stepper motor
motor_w=42.3;
// Diagonal width of stator chamfer
chamf_w=52;
// Height of stator
chamf_h=21;
// Collar diameter (hole in metal bracket)
collar=22;
// Circlip offset (thickness of metal bracket)
circlip_o=2.8;
// Thickness of circlip
circlip_h=3;
// Width of circlip
circlip_w=5;
// Circlip opening angle (additional to 90 degree cutout)
circlip_a=30;
// Geometry overlap
AT=1/64;
ST=2*AT;
// Curve resolution
$fn=96;

// Stepper Holder
difference(){
    union(){
        translate([0,0,chamf_h/2])difference(){
            intersection(){
                cube([motor_w+2*wall,motor_w+2*wall,chamf_h],center=true);
                rotate(45)cube([chamf_w+2*wall,chamf_w+2*wall,chamf_h],center=true);
            }
            intersection(){
                cube([motor_w,motor_w,chamf_h+ST],center=true);
                rotate(45)cube([chamf_w,chamf_w,chamf_h+ST],center=true);
            }
        }
        translate([AT-motor_w/2-wall,0,chamf_h/2])mirror([1,0,1]){
            intersection(){
                union(){
                    cylinder(d=collar,h=circlip_o-layer_h+AT);
                    translate([0,0,circlip_o-layer_h])cylinder(d=collar-circlip_w,h=circlip_h+layer_h+AT);
                    translate([0,0,circlip_o+circlip_h])cylinder(d=collar,h=circlip_h+AT);
                }
                translate([-chamf_h/2,-collar/2,0])cube([chamf_h,collar,circlip_o+2*circlip_h+AT]);
            }
        }
    }
    translate([-(circlip_o+2*circlip_h+wall+motor_w/2+AT),-tol/2,-AT])cube([circlip_o+2*circlip_h+wall+ST,tol,chamf_h+ST]);
}

// Circlip
difference(){
    cylinder(d=collar+circlip_w,h=circlip_h);
    translate([0,0,-AT]){
        cylinder(d=collar-circlip_w,h=circlip_h+ST);
        cube([collar+circlip_w,collar+circlip_w,circlip_h+ST]);
        rotate(circlip_a)cube([collar+circlip_w,collar+circlip_w,circlip_h+ST]);
    }
}
translate([collar/2,0,0])cylinder(d=circlip_w,h=circlip_h);
rotate(circlip_a)translate([0,collar/2,0])cylinder(d=circlip_w,h=circlip_h);
