// aircon remote dimensions
remote_width_mm = 56;
remote_depth_mm = 15;
remote_height_mm = 164;


bed_depth_mm = 21.5;
handle_height_mm = 50;
handle_width_mm = 150;
handle_wall_thickness_mm = 15;
tray_height_mm = handle_height_mm/2 ;
tray_width_mm = handle_width_mm;
tray_depth_mm = handle_wall_thickness_mm/2;
tray_insert_depth_mm = 50;


module tray_handle(
    tray_width_mm, 
    tray_depth_mm, 
    tray_height_mm
    ) {
        difference() {
            cube([tray_width_mm, tray_depth_mm + handle_wall_thickness_mm, tray_height_mm]);
            translate([-handle_wall_thickness_mm, handle_wall_thickness_mm/2, -handle_wall_thickness_mm/2]) {
                cube([tray_width_mm*2 , tray_depth_mm, tray_height_mm]);
            }
        }
}

module tray_holder(
    tray_width, 
    tray_depth, 
    tray_height,
    tray_insert_depth
    ) {
        cube([tray_width, tray_depth, tray_height]);
        translate([0,tray_depth + tray_insert_depth,0]) {
            cube([tray_width, tray_depth, tray_height]);
        }
        cube([tray_depth, tray_depth + tray_insert_depth, tray_height]);
        translate([tray_width - tray_depth,0,0]) {
            cube([tray_depth, tray_depth + tray_insert_depth, tray_height]);
        }
        translate([0,0,tray_height_mm]) {
            cube([tray_width, tray_depth*2 + tray_insert_depth, handle_wall_thickness_mm]);
        }
}

module tray() {
    tray_handle(handle_width_mm,bed_depth_mm, handle_height_mm);
    translate([0,handle_wall_thickness_mm/2,0]) {
        rotate([180, 0, 0]) {
            tray_holder(tray_width_mm, tray_depth_mm, tray_height_mm, tray_insert_depth_mm);
        }
    }
}

tray();