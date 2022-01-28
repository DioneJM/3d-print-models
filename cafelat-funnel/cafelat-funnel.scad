// portafilter dimensions
portafilter_diameter_mm = 57.81;
portafilter_rim_thickness_mm = 4.26;
portafilter_lip_height_mm = 3.42;

cutoff_height_mm = 20;
funnel_height_mm = cutoff_height_mm + 40;
funnel_thickness_mm = 10;
funnel_steepness_degrees = 45;
funnel_diameter_mm = 56;
slant_angle_degrees = funnel_steepness_degrees > 90 ? 0 : 90 - funnel_steepness_degrees;
funnel_length_mm = funnel_height_mm / sin(funnel_steepness_degrees); // hypotenuse also assumes angle is 45

module funnel() {
    translate([0,0,-cutoff_height_mm-funnel_thickness_mm])
        difference() {
            rotate_extrude(angle=360) {
                // need to offset by a slight amount as the rotation is causing
                // the resulting object to be non-manifold
                // source: https://forum.openscad.org/Preview-OK-Render-gets-only-half-tp33306p33315.html
                offset(delta=-0.001) 
                    rotate(a = [funnel_steepness_degrees,funnel_steepness_degrees,0]) {
                        square([funnel_thickness_mm,funnel_length_mm]);
                    }
            }
            translate([0,0,cutoff_height_mm/2-0.01]) // translate by cutoff_height/2 to bring cube bottom to the origin as the cube is centered
                cube([cutoff_height_mm*10, cutoff_height_mm*10, cutoff_height_mm], center=true);
            cylinder(h = funnel_height_mm, d = funnel_diameter_mm);
        }
}

funnel();