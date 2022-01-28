
rack_width_mm = 200;
rack_height_mm = 360;
outer_wire_diameter_offset_mm = 1;
outer_wire_diameter_mm = 12 + outer_wire_diameter_offset_mm;
outer_wire_radius_mm = outer_wire_diameter_mm / 2;
inner_wire_diameter_mm = 3.7;
outer_to_inner_wire_gap_mm = 26.61;
inner_wire_gap_mm = 35;
tray_gap_mm = 22.85;
tray_insert_depth = 50;
tray_insert_height_mm = 112;
tray_wall_thickness_mm = 6;
tray_width_mm = rack_width_mm * 0.75;
tray_height = rack_height_mm/2;


module tray_walls() {
    linear_extrude(
        height = tray_height,
        center = false,  
        slices = 20, 
        scale = 1.0, 
        $fn = 316
    ) {
        square([tray_width_mm, tray_wall_thickness_mm]);
        translate([0, tray_insert_depth, 0]) {
            square([tray_width_mm, tray_wall_thickness_mm]);
        }
        rotate(a = 90) {
            square([tray_insert_depth + tray_wall_thickness_mm, tray_wall_thickness_mm]);
        }
        rotate(a = 90)  {
            translate([0, -tray_width_mm, 0]) {
                square([tray_insert_depth + tray_wall_thickness_mm, tray_wall_thickness_mm]);
            }
        }
    }
}

module tray_bottom() {
    sink_radius_mm = 2.5;
    linear_extrude(height = tray_wall_thickness_mm) {
        difference() {
            square([tray_width_mm, tray_insert_depth + tray_wall_thickness_mm]);

            for(i=[tray_wall_thickness_mm + sink_radius_mm: 15: tray_width_mm - tray_wall_thickness_mm - sink_radius_mm * 2]) {
                translate([i, (tray_insert_depth - tray_wall_thickness_mm - sink_radius_mm)/3, 0]) {
                    circle(r=sink_radius_mm);
                }
                translate([i, (tray_insert_depth - tray_wall_thickness_mm - sink_radius_mm)*2/3, 0]) {
                    circle(r=sink_radius_mm);
                }
                translate([i, (tray_insert_depth - tray_wall_thickness_mm - sink_radius_mm), 0]) {
                    circle(r=sink_radius_mm);
                }
            }
        }
    }
}

module tray_handles() {
    handle_length = tray_width_mm + tray_wall_thickness_mm;
    handle_height_mm = 100;
    rotate(a = [90, 0, 90]) {
        outer_cylinder_radius = (outer_wire_radius_mm)*1.5;
        translate([-tray_wall_thickness_mm - outer_wire_radius_mm+tray_wall_thickness_mm,tray_height-outer_cylinder_radius,-tray_wall_thickness_mm]) {
            difference() {
                rotate(a=[0,0,-90]) {
                    handle_thickness = outer_cylinder_radius * 2.2;
                    translate([-outer_cylinder_radius,-handle_thickness+outer_cylinder_radius,0]) {
                        cube([handle_height_mm, handle_thickness, handle_length]);
                    }
                }
                // this is needed to make a clean cut using the inner cylinder
                // by making it longer than the outer
                translate_offset_z = 5;                 
                handle_length_with_offset = handle_length + translate_offset_z*2;
                handle_cutout_offset_y = tray_wall_thickness_mm;
                translate([0,-handle_cutout_offset_y,-translate_offset_z]) {
                    cylinder(handle_length_with_offset, r = outer_wire_radius_mm);
                }
                translate([outer_wire_radius_mm, -handle_cutout_offset_y,-translate_offset_z]) {
                    rotate([0,0,180]) {
                        cube([outer_wire_diameter_mm, handle_height_mm, handle_length_with_offset]);
                    }
                }
                rotate(a=[0,0,-90]) {
                    handle_thickness = outer_cylinder_radius * 2.2;
                    translate([-outer_cylinder_radius,-handle_thickness+outer_cylinder_radius,4]) {
                        cube([handle_height_mm, outer_cylinder_radius - 10, handle_length-8]);
                    }
                }
            }

        }
    }
}

module tray_funnel(funnel_length_mm) {
    funnel_lip_length_mm = 30;
    cutout_length = funnel_length_mm + tray_wall_thickness_mm ;
    cylinder_offset = 60;
    translate([-tray_wall_thickness_mm, 0, 0]) {
            rotate([180,0,0]) {
                difference() {
                    cube([tray_width_mm + tray_wall_thickness_mm, tray_insert_depth + tray_wall_thickness_mm + funnel_lip_length_mm, funnel_length_mm + tray_wall_thickness_mm]);
                    translate([tray_wall_thickness_mm-4,tray_width_mm - cylinder_offset,-10])
                            rotate([0,90,0])
                                cylinder(tray_width_mm+2, r=cylinder_offset+25);
                }
            }

    }
}

module tray() {
    funnel_length_mm = 70;
    tray_walls();
    tray_bottom();
    tray_handles();
    translate([0, 56, 0]) {
        tray_funnel(funnel_length_mm);
    }
}

tray();