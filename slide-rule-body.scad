//Width X is along the rule
//Length Y is perpendicular to the rule
//Height Z is vertical
use <slide-rule-slider.scad>

module body (
    width=153,
    totalLength=28,
    totalHeight=5,
    sliderTY=6,
    sliderTZ=2,
    sliderDispLength=14,
    sliderTotalLength=16,
    sliderHeight=3,
    railHeight=1,
    outsideRailLength=2,
    cutoutWidth=5
    ){
    difference(){
        difference(){
            difference(){
                difference(){
                    cube([width, totalLength, totalHeight]);
                    translate([0, sliderTY, sliderTZ])
                    slider(
                        dispLength=sliderDispLength,
                        totalLength=sliderTotalLength,
                        width=width,
                        height=sliderHeight,
                        railHeight=railHeight,
                        subtraction=true
                    );
                }
                outsideRails(
                    width=width,
                    totalLength=totalLength,
                    railHeight=railHeight,
                    outsideRailLength=outsideRailLength,
                    railTZ=sliderTZ+(sliderHeight/2)-(railHeight/2)
                );
            }
            translate([width-cutoutWidth, sliderTY+((sliderTotalLength-sliderDispLength)/2), -0.5]){
                cube([cutoutWidth+1, sliderDispLength, sliderTZ+1]);
            }
        }
        translate([0, totalLength/2, -0.001]){
            cylinder(r=sliderDispLength*0.72/2, h=2, $fn=30);
            cylinder(r1=sliderDispLength/2, r2=sliderDispLength*0.72/2, h=0.9, $fn=30);
        }
    }
}

module outsideRails (
    width=153,
    totalLength=28,
    railHeight=1,
    outsideRailLength=2,
    railTZ
    ){
    incWidth=2;
    translate([-incWidth/2, -1, railTZ]){
        cube([width+incWidth, outsideRailLength+1, railHeight]);
    }
    translate([-incWidth/2, totalLength-outsideRailLength, railTZ]){
        cube([width+incWidth, outsideRailLength+1, railHeight]);
    }
}

body();