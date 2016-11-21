use <slide-rule-body.scad>
use <slide-rule-slider.scad>
use <slide-rule-scales.scad>
use <slide-rule-cursor.scad>

module slideRule(
    width=153,
    totalLength=28,
    totalHeight=5,
    sliderTY=6,
    sliderTZ=2,
    minorLength=1,
    majorLength=3,
    depth=0.5,
    sliderDispLength=14,
    sliderTotalLength=16,
    sliderHeight=3,
    railHeight=1,
    majorTextSize=2,
    minorTextSize=1.5,
    frontSliderXOffset=13,
    outsideRailLength=2,
    separation=40,
    cutoutWidth=5,
    cursorWidth=18,
    cursorVal=1,
    sliderVal=1,
    assembled=false,
    textPadding=0.6
){
    scaleWidth=width-(2*frontSliderXOffset);
    
    sliderTranslate=assembled ? ([(width-(2*frontSliderXOffset))*log(sliderVal), -separation+sliderTY, sliderTZ]) : ([0, 0, 0]);
    
    cursorTranslate=assembled ? ([frontSliderXOffset-cursorWidth/2+(width-(2*frontSliderXOffset))*log(cursorVal), -1, sliderTZ+1]) : ([0, separation+sliderTotalLength+5, 0]);
    
    //body
    difference(){
        body(
            width=width,
            totalLength=totalLength,
            totalHeight=totalHeight,
            sliderTY=sliderTY,
            sliderTZ=sliderTZ,
            sliderDispLength=sliderDispLength,
            sliderTotalLength=sliderTotalLength,
            sliderHeight=sliderHeight,
            railHeight=railHeight,
            outsideRailLength=outsideRailLength,
            cutoutWidth=cutoutWidth
        );
        translate([frontSliderXOffset, sliderTY+(sliderTotalLength-sliderDispLength)/2, totalHeight]){
            scaleABCDCIK(
                width=scaleWidth,
                minorLength=minorLength,
                majorLength=majorLength,
                depth=depth,
                majorTextSize=majorTextSize,
                minorTextSize=minorTextSize,
                length=sliderDispLength,
                textPadding=textPadding
            );
        }
    }

    //slider
    translate(sliderTranslate)
    difference(){
        difference(){
            translate([0, separation, 0]){
                slider(
                    dispLength=sliderDispLength,
                    totalLength=sliderTotalLength,
                    width=width,
                    height=sliderHeight,
                    railHeight=railHeight
                );
            }
            translate([frontSliderXOffset, separation+((sliderTotalLength-sliderDispLength)/2), sliderHeight]){
                scaleABCDCIK(
                    width=scaleWidth,
                    minorLength=minorLength,
                    majorLength=majorLength,
                    depth=depth,
                    majorTextSize=majorTextSize,
                    minorTextSize=minorTextSize,
                    length=sliderDispLength,
                    textPadding=textPadding
                );
            }
        }
        translate([21, separation+sliderTotalLength-((sliderTotalLength-sliderDispLength)/2)+0.001, 0]){
            rotate([180,0,0]){
                scaleSLT(
                    width=scaleWidth,
                    minorLength=minorLength,
                    majorLength=majorLength,
                    depth=depth,
                    textSize=majorTextSize,
                    length=sliderDispLength+0.002,
                    textPadding=textPadding
                );
            }
        }
    }

    //cursor
    translate(cursorTranslate)
    cursor(
        width=cursorWidth,
        cutoutLength=totalLength,
        thickness=railHeight,
        railLength=outsideRailLength,
        cutoutHeight=(sliderHeight-railHeight)/2
    );
}

slideRule();

