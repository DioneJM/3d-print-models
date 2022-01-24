
rack_width_mm = 200;
rack_height_mm = 360;
outer_wire_diameter_mm = 10;
inner_wire_diameter_mm = 3.7;
outer_to_inner_wire_gap_mm = 26.61;
inner_wire_gap_mm = 35;
tray_gap_mm = 22.85;
tray_insert_depth = 25;
tray_insert_height_mm = 112;
tray_wall_thickness_mm = 5;
tray_width_mm = rack_width_mm * 0.75;


module tray_walls() {
    square([tray_width_mm, tray_wall_thickness_mm]);
    translate([0, tray_insert_depth, 0]) 
        square([tray_width_mm, tray_wall_thickness_mm]);
    rotate(a = 90) 
        square([tray_insert_depth + tray_wall_thickness_mm, tray_wall_thickness_mm]);
    rotate(a = 90) 
        translate([0, -tray_width_mm, 0]) 
            square([tray_insert_depth + tray_wall_thickness_mm, tray_wall_thickness_mm]);
}

module tray_bottom() {
    square([,tray_insert_depth + tray_wall_thickness_mm]);
}

module tray() {
    linear_extrude(
        height = rack_height_mm/2, 
        center = false,  
        slices = 20, 
        scale = 1.0, 
        $fn = 316
    ) 
        tray_walls();
    tray_bottom();
}

tray();