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
            translate([width-cutoutWidth, sliderTY+((sliderTotalLength-sliderDispLength)/2)+0.5, -0.1]){
                //cube([cutoutWidth+1, sliderDispLength-1, sliderTZ+1]);
                bezelSquareCutout(
                    heightBottom=0.9,
                    heightTop=2,
                    rTop=sliderDispLength-1,
                    r1Bottom=(sliderDispLength-1)*1.72,
                    r2Bottom=sliderDispLength-1,
                    facets=30
                );
            }
        }
        translate([0, totalLength/2, -0.001]){
            bezelRoundCutout(
                heightBottom=0.9,
                heightTop=2,
                rTop=sliderDispLength*0.72/2,
                r1Bottom=sliderDispLength/2,
                r2Bottom=sliderDispLength*0.72/2,
                facets=30
            );
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

module bezelRoundCutout(
    heightBottom=0.9,
    heightTop=2,
    rTop=5,
    rBottom=7,
    facets=30
){
    cylinder(r=rTop, h=heightTop, $fn=facets);
    cylinder(r1=rBottom, r2=rTop, h=heightBottom, $fn=facets);
}

module longBezelRoundCutout(
    heightBottom=0.9,
    heightTop=2,
    rTop=5,
    rBottom=7,
    facets=30,
    width=20
){
    hull(){
        cylinder(r=rTop, h=heightTop, $fn=facets);
        translate([width, 0, 0])
        cylinder(r=rTop, h=heightTop, $fn=facets);
    }
    hull(){
        cylinder(r1=rBottom, r2=rTop, h=heightBottom, $fn=facets);
        translate([width, 0, 0])
        cylinder(r1=rBottom, r2=rTop, h=heightBottom, $fn=facets);
    }
}

module bezelSquareCutout(
    heightBottom=0.9,
    heightTop=2,
    rTop=5,
    r1Bottom=15,
    r2Bottom=10,
    facets=30
){
    translate([0, 1.5, 0]){
        longBezelRoundCutout(
            heightBottom=0.9,
            heightTop=2,
            rTop=1.5,
            rBottom=1.5*1.72,
            facets=30,
            width=r2Bottom
        );
    }
    translate([0, r2Bottom-1.5, 0]){
        longBezelRoundCutout(
            heightBottom=0.9,
            heightTop=2,
            rTop=1.5,
            rBottom=1.5*1.72,
            facets=30,
            width=r2Bottom
        );
    }
    translate([1.5, 1.5, 0]){
        rotate([0, 0, 90])
        longBezelRoundCutout(
            heightBottom=0.9,
            heightTop=2,
            rTop=1.5,
            rBottom=1.5*1.72,
            facets=30,
            width=r2Bottom-3
        );
    }
    translate([0, 1.5, 0])
    cube([r2Bottom, r2Bottom-3, heightTop]);
}

body();
translate([0, 40, 0])
bezelSquareCutout();