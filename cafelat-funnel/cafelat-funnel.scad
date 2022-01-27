// portafilter dimensions
portafilter_diameter_mm = 57.81;
portafilter_rim_thickness_mm = 4.26;
portafilter_lip_height_mm = 3.42;

funnel_depth_mm = 10;
funnel_thickness_mm = 1;
funnel_steepness_degrees = 55;

module funnel() {
    rotate_extrude(angle=360) {
        rotate(a = [funnel_steepness_degrees,funnel_steepness_degrees,0]) {
            square([funnel_thickness_mm,funnel_depth_mm]);
        }
    }
}

funnel();