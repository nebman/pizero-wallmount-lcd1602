
print_top    = true;
print_bottom = true;

box_width =     150;
box_height =    90;
box_depth =     35;

lid_h = 8;

wallm_d = 8;
wallm_margin = 10;

nozzle_d = 0.46;
wall_w = 4*nozzle_d;

display_w = 72.2;
display_h = 25.2;

disp_full_w = 80;
disp_full_h = 36;

disp_left = (disp_full_w-display_w)/2;
disp_right = disp_left;
disp_top = 6.7;
disp_bottom = 5.6;

disp_mount_d = 2;
disp_mount_h = 5.0; // 6.5-6.8 for flush mount
disp_mount_margin = 2.5;

disp_butt_d = 13.3;
disp_butt_margin = 4.5;


pizero_h = 65;
pizero_w = 30;
pizero_mount_margin = 3.5;
pizero_mount_h = 5;
pizero_mount_walldistance = 0.5;
pizero_mount_screwhole = 2;

general_clearance = 3;

microusb_w = 37;
microusb_h = 10.9;
microusb_screw_distance = 27.9;
microusb_hole_w = 20.8;
microusb_hole_z = (box_depth-microusb_h)/2;
microusb_screw_d = 3.5;

rj45_w      =   microusb_w;
rj45_h      =   18;
rj45_hole_w =   17;
rj45_hole_z =   max((box_depth-rj45_h)/2, (23-rj45_h)/2);
rj45_screw_distance = microusb_screw_distance;
rj45_screw_d        = microusb_screw_d;

powerjack_d = 8;
powerjack_full_d = 10;
powerjack_z = (box_depth)/2;

if (print_bottom) {
    difference() {
        // create box
        translate([-wall_w, -wall_w, -wall_w])
            cube([box_width+2*wall_w, box_height+2*wall_w, box_depth+wall_w]);

        // cutout inside
        cube([box_width, box_height, box_depth+1]);
        
        
        // cutout wallmounts
        pos = [
            [wallm_margin, wallm_margin],
            [wallm_margin, box_height-wallm_margin],
            [box_width - wallm_margin, box_height-wallm_margin],
            [box_width - wallm_margin, wallm_margin]
        ];
        
        for(a=[0:len(pos)-1]) {
            translate([pos[a][0], pos[a][1], -wall_w-1]) {
                cylinder(h=2+wall_w, r=wallm_d/2, $fn=20);
                
                translate([0,wallm_d/2,0]) 
                cylinder(h=2+wall_w, d=3, $fn=20);
                
            }
        }
        
        // cutout SD card
        translate([7+pizero_mount_walldistance,-wall_w-1,pizero_mount_h-1]) {
            #cube([12,wall_w+2, 5]);
        }
        
        // cutout micro usb
        translate([box_width-1, box_height-microusb_w-general_clearance, microusb_hole_z]) {
            translate([0,(microusb_w-microusb_hole_w)/2,0])
                cube([wall_w+2, microusb_hole_w, microusb_h]);
            
            translate([0,(microusb_w-microusb_screw_distance)/2, microusb_h/2])
                rotate([0,90,0])    
                    cylinder(h=wall_w+2, d=microusb_screw_d, $fn=15);
            translate([0,microusb_w-(microusb_w-microusb_screw_distance)/2, microusb_h/2])
                rotate([0,90,0])    
                    cylinder(h=wall_w+2, d=microusb_screw_d, $fn=15);
        }
        
        // cutout rj45      
        translate([general_clearance * 3, box_height+1, rj45_hole_z]) {
            rotate([00,00,270]) {
                translate([-1,(rj45_w-rj45_hole_w)/2,0])
                    cube([wall_w+2, rj45_hole_w, rj45_h]);
                
                translate([-1,(rj45_w-rj45_screw_distance)/2, rj45_h/2])
                    rotate([0,90,0])    
                        cylinder(h=wall_w+2, d=rj45_screw_d, $fn=15);
                translate([-1,rj45_w-(rj45_w-rj45_screw_distance)/2, rj45_h/2])
                    rotate([0,90,0])    
                        cylinder(h=wall_w+2, d=rj45_screw_d, $fn=15);
            }
        }
        
        //cutout power socket
        if (true)
        translate([box_width-1, max(general_clearance, powerjack_z), powerjack_z])
            rotate([0,90,0])
                cylinder(h=wall_w+2, d=powerjack_d, $fn=20);
    }
    
    //wallmount cover
    translate([wallm_margin-wallm_d/2-0.8, wallm_margin-wallm_d/2, 0]) {
        difference() {
            cube([wallm_d+1.6, wallm_d+2, pizero_mount_h]);
            translate([0.8,-1,-0.8])
            cube([wallm_d, wallm_d+4, pizero_mount_h]);
        }
    }
    translate([box_width-wallm_margin-wallm_d/2-0.8, wallm_margin-wallm_d/2, 0]) {
        difference() {
            cube([wallm_d+1.6, wallm_d+2, pizero_mount_h]);
            translate([0.8,-1,-0.8])
            cube([wallm_d, wallm_d+4, pizero_mount_h]);
        }
    }
    
    // micro usb holder/cover
    translate([box_width+wall_w*2+general_clearance, box_height-microusb_w-general_clearance, -wall_w]) {
        difference() {
            cube([microusb_h, microusb_w, 0.4]);        
            // cutouts
            translate([0,0,-1]) {
                translate([0,(microusb_w-microusb_hole_w)/2,0])
                    cube([microusb_h, microusb_hole_w, wall_w+2]);
                translate([microusb_h/2, (microusb_w-microusb_screw_distance)/2, 0])
                    cylinder(h=wall_w+2, d=microusb_screw_d, $fn=10);
                translate([microusb_h/2, microusb_w-(microusb_w-microusb_screw_distance)/2, 0])
                    cylinder(h=wall_w+2, d=microusb_screw_d, $fn=10);
            }
        }
        
        //support walls
        translate([-wall_w,0,0]) 
            cube([wall_w, microusb_w, 5]);
        translate([microusb_h, 0, 0])
            cube([wall_w, microusb_w, 5]);       
        translate([-wall_w,-wall_w,0]) 
            cube([microusb_h+2*wall_w, wall_w, 2]);
        translate([-wall_w,microusb_w,0]) 
            cube([microusb_h+2*wall_w, wall_w, 2]);
    }
    
    if (true) {
        // pi zero mount
        pos = [
            [pizero_mount_margin, pizero_mount_margin], 
            [pizero_w - pizero_mount_margin, pizero_mount_margin],
            [pizero_w - pizero_mount_margin, pizero_h - pizero_mount_margin],
            [pizero_mount_margin, pizero_h - pizero_mount_margin],
            [pizero_w/2, pizero_h/2]
        ];
        for (a=[0:len(pos)-1]) {
            translate([pizero_mount_walldistance + pos[a][0], pizero_mount_walldistance + pos[a][1], 0])
                difference() {
                    cylinder(h=pizero_mount_h, d=pizero_mount_screwhole+wall_w*2, $fn=20);
                    cylinder(h=pizero_mount_h+1, d=pizero_mount_screwhole, $fn=20);
                }
        }
    }
}

if (print_top) {
    translate([0, box_height + wall_w + 3, 0]) {
        difference() {
            // faceplate
            translate([-wall_w, -wall_w, -wall_w])
            cube([box_width+2*wall_w, box_height+2*wall_w, wall_w]);
            
            // cutout for 1602A
            translate([box_width/2 - display_w/2, box_height/2 - display_h/2, -wall_w-1])
            cube([display_w, display_h, 2+wall_w]);
            
            // cutout for display button
            translate([box_width/2 + display_w/2 + max(disp_butt_margin + disp_butt_d/2, min(display_h/2, (box_width-display_w)/4)), box_height/2, -wall_w-1])
            cylinder(h=2+wall_w, r=disp_butt_d/2, $fn=40);
        }
        
        // inset
        difference() {
            cube([box_width, box_height, wall_w+lid_h]);
            
            translate([wall_w, wall_w, -1])
            cube([box_width-2*wall_w, box_height-2*wall_w, wall_w+lid_h+2]);
        }
        
        
        // mounting holes display
        translate([box_width/2-display_w/2-disp_left, box_height/2-display_h/2-disp_bottom, 0]) {
            translate([disp_mount_margin, disp_mount_margin, 0]) {
                difference() {
                    cylinder(h=disp_mount_h-wall_w, r=(disp_mount_d/2)+0.8, $fn=20);
                    cylinder(h=disp_mount_h+wall_w+1, r=(disp_mount_d/2), $fn=20);
                }
            }
            translate([disp_full_w-disp_mount_margin, disp_mount_margin, 0]) {
                difference() {
                    cylinder(h=disp_mount_h-wall_w, r=(disp_mount_d/2)+0.8, $fn=20);
                    cylinder(h=disp_mount_h+wall_w+1, r=(disp_mount_d/2), $fn=20);
                }
            }
            translate([disp_full_w-disp_mount_margin, disp_full_h - disp_mount_margin, 0]) {
                difference() {
                    cylinder(h=disp_mount_h-wall_w, r=(disp_mount_d/2)+0.8, $fn=20);
                    cylinder(h=disp_mount_h+wall_w+1, r=(disp_mount_d/2), $fn=20);
                }
            }
            translate([disp_mount_margin, disp_full_h-disp_mount_margin, 0]) {
                difference() {
                    cylinder(h=disp_mount_h-wall_w, r=(disp_mount_d/2)+0.8, $fn=20);
                    cylinder(h=disp_mount_h+wall_w+1, r=(disp_mount_d/2), $fn=20);
                }
            }
            
        }
    }
}