//Width X is along the rule
//Length Y is perpendicular to the rule
//Height Z is vertical
module slider (
    dispLength=10, 
    totalLength=12, 
    width=80,
    height=3, 
    railHeight=1,
    subtraction=false
    ){
    widthOffset = subtraction ? -2 : 0;
    width = subtraction ? width+4 : width;
    //display
    translate([widthOffset, (totalLength-dispLength)/2, 0]){
        cube([width, dispLength, height]);
    }
    //rails
    translate([widthOffset, 0, (height/2)-(railHeight/2)]){
        cube([width, totalLength, railHeight]);
    }
    if (subtraction){
        translate([widthOffset, (totalLength-dispLength)/2, height-1]){
            cube([width, dispLength, height]);
        }
        translate([widthOffset, (totalLength-dispLength)/2, -0.4]){
            cube([width, dispLength, height]);
        }
    }
}

//Default slider
slider();

//Slider that will be used for subtraction
translate([0, 15, 0]){
    slider(subtraction=true);
}