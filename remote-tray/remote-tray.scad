// aircon remote dimensions
remote_width_mm = 56;
remote_depth_mm = 15;
remote_height_mm = 164;


bed_depth_mm = 21.5;
handle_height_mm = 40;
handle_width_mm = 80;
tray_height_mm = 10;
tray_thickness_mm = 2;
tray_depth_mm = 10;


module tray_handle(tray_width_mm, tray_depth_mm, tray_height_mm) {
    handle_wall_thickness_mm = 10;
    difference() {
        cube([tray_width_mm, tray_depth_mm + handle_wall_thickness_mm, tray_height_mm]);
        translate([-handle_wall_thickness_mm, handle_wall_thickness_mm/2, -handle_wall_thickness_mm/2]) {
            cube([tray_width_mm*2 , tray_depth_mm, tray_height_mm]);
        }
    }
}

module tray() {
    tray_handle(handle_width_mm,bed_depth_mm, handle_height_mm);
}

tray();