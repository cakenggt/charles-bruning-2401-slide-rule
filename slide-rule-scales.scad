//Width X is along the rule
//Length Y is perpendicular to the rule
//Height Z is vertical

module engrave (
    text="text",
    size=1,
    depth=0.5
    ){
    translate([0, 0, -depth/2]){
        linear_extrude(depth){
            text(text=text, font="Liberation Sans:style=Bold", size=size);
        }
    }
}

module scaleCD (
    width=127,
    minorLength=3,
    majorLength=6,
    depth=0.5,
    majorTextSize=2,
    minorTextSize=1.5
    ){
    translate([-2*majorTextSize, majorLength/2, 0]){
        engrave(text="C", size=majorTextSize, depth=depth);
    }
    translate([-2*majorTextSize, (-majorLength/2)-majorTextSize, 0]){
        engrave(text="D", size=majorTextSize, depth=depth);
    }
    //from 1 to 2
    //text for every 0.1
    //marks for every 0.02
    for (i=[1:0.02:2]){
        x = log(i)*width;
        modI = i%0.1;
        length = modI < 0.000001 || modI > 0.09999 ? (i%1 < 0.000001 || i%1 > 0.999999 ? (majorLength+minorLength)/2 : majorLength) : minorLength;
        if (modI < 0.0000001 || modI > 0.099999999){
            dispText = i == 1 ? "1" : str((i-1)*10);
            textSize = i == 1 ? majorTextSize : minorTextSize;
            translate([x-(textSize/2-depth/2), length/2, 0]){
                engrave(text=dispText, size=textSize, depth=depth);
            }
            translate([x-(textSize/2-depth/2), (-length/2)-textSize, 0]){
                engrave(text=dispText, size=textSize, depth=depth);
            }
        }
        translate([x, -length/2, -depth/2]){
            cube([depth, length, depth]);
        }
    }
    //From 2 to 5
    //text for every 1
    //marks for every 0.05
    for (i=[2:0.05:5]){
        x = log(i)*width;
        textMod = i%1;
        length = getLength(
            x=i, 
            major=majorLength, 
            minor=minorLength, 
            modL=1, 
            modM=0.5, 
            modS=0.1
        );
        if (textMod < 0.0000001 || textMod > 0.99999999){
            translate([x-(majorTextSize/2-depth/2), length/2, 0]){
                engrave(text=str(i), size=majorTextSize, depth=depth);
            }
            translate([x-(majorTextSize/2-depth/2), (-length/2)-majorTextSize, 0]){
                engrave(text=str(i), size=majorTextSize, depth=depth);
            }
        }
        translate([x, -length/2, -depth/2]){
            cube([depth, length, depth]);
        }
    }
    //from 5 to 10
    for (i=[5:0.1:10]){
        x = log(i)*width;
        textMod = i%1;
        modI = i%0.5;
        length = modI < 0.000001 || modI > 0.49999 ? (i%1 < 0.000001 || i%1 > 0.999999 ? (majorLength+minorLength)/2 : majorLength) : minorLength;
        if (textMod < 0.0000001 || textMod > 0.99999999){
            dispText = i > 9.999 ? "1" : str(i);
            translate([x-(majorTextSize/2-depth/2), length/2, 0]){
                engrave(text=dispText, size=majorTextSize, depth=depth);
            }
            translate([x-(majorTextSize/2-depth/2), (-length/2)-majorTextSize, 0]){
                engrave(text=dispText, size=majorTextSize, depth=depth);
            }
        }
        translate([x, -length/2, -depth/2]){
            cube([depth, length, depth]);
        }
    }
}

module scaleAB (
    width=127,
    minorLength=3,
    majorLength=6,
    depth=0.5,
    majorTextSize=2,
    minorTextSize=1.5
    ){
    translate([-2*majorTextSize, majorLength/2, 0]){
        engrave(text="A", size=majorTextSize, depth=depth);
    }
    translate([-2*majorTextSize, (-majorLength/2)-majorTextSize, 0]){
        engrave(text="B", size=majorTextSize, depth=depth);
    }
    for (p=[0:1]){
        //from 1 to 2
        //text for every 1
        //marks for every 0.05
        for (i=[1:0.05:2]){
            x = (p*width/2)+log(i)*width/2;
            textMod = i%1;
            length = getLength(
                x=i, 
                major=majorLength, 
                minor=minorLength, 
                modL=1, 
                modM=0.5, 
                modS=0.1
            );
            if (textMod < 0.0000001 || textMod > 0.99999999){
                translate([x-(majorTextSize/2-depth/2), length/2, 0]){
                    engrave(text=str(i), size=majorTextSize, depth=depth);
                }
                translate([x-(majorTextSize/2-depth/2), (-length/2)-majorTextSize, 0]){
                    engrave(text=str(i), size=majorTextSize, depth=depth);
                }
            }
            translate([x, -length/2, -depth/2]){
                cube([depth, length, depth]);
            }
        }
        //From 2 to 5
        //text for every 1
        //marks for every 0.1
        for (i=[2:0.1:5]){
            x = (p*width/2)+log(i)*width/2;
            textMod = i%1;
            modI = i%0.5;
            length = modI < 0.000001 || modI > 0.4999 ? (majorLength+minorLength)/2 : minorLength;
            if (textMod < 0.0000001 || textMod > 0.99999999){
                translate([x-(majorTextSize/2-depth/2), length/2, 0]){
                    engrave(text=str(i), size=majorTextSize, depth=depth);
                }
                translate([x-(majorTextSize/2-depth/2), (-length/2)-majorTextSize, 0]){
                    engrave(text=str(i), size=majorTextSize, depth=depth);
                }
            }
            translate([x, -length/2, -depth/2]){
                cube([depth, length, depth]);
            }
        }
        //from 5 to 10
        for (i=[5:0.2:10]){
            x = (p*width/2)+log(i)*width/2;
            textMod = i%1;
            modI = i%1;
            length = modI < 0.000001 || modI > 0.99999 ? (majorLength+minorLength)/2 : minorLength;
            if (textMod < 0.0000001 || textMod > 0.99999999){
                dispText = i > 9.999 ? "1" : str(i);
                translate([x-(majorTextSize/2-depth/2), length/2, 0]){
                    engrave(text=dispText, size=majorTextSize, depth=depth);
                }
                translate([x-(majorTextSize/2-depth/2), (-length/2)-majorTextSize, 0]){
                    engrave(text=dispText, size=majorTextSize, depth=depth);
                }
            }
            translate([x, -length/2, -depth/2]){
                cube([depth, length, depth]);
            }
        }
    }
}

module scaleABCD(
    width=127,
    minorLength=3,
    majorLength=6,
    depth=0.5,
    majorTextSize=2,
    minorTextSize=1.5,
    ySeparation=14
    ){
    translate([0, ySeparation, 0]){
        scaleAB(
            width=width,
            minorLength=minorLength,
            majorLength=majorLength,
            depth=depth,
            majorTextSize=majorTextSize,
            minorTextSize=minorTextSize
        );
    }
    scaleCD(
        width=width,
        minorLength=minorLength,
        majorLength=majorLength,
        depth=depth,
        majorTextSize=majorTextSize,
        minorTextSize=minorTextSize
    );
}

module scaleL(
    width=127,
    minorLength=1,
    majorLength=2,
    depth=0.5,
    textSize=2
    ){
    translate([width+textSize, majorLength, 0]){
        engrave(text="L", size=textSize, depth=depth);
    }
    for (i=[10:-0.05:-0.05]){
        x = (i/10)*width;
        textMod = i%1;
        length = getLength(
            x=i, 
            major=majorLength, 
            minor=minorLength, 
            modL=1, 
            modM=0.5, 
            modS=0.1
        );
        if (textMod < 0.0000001 || textMod > 0.99999999){
            dispText = i > 9.999 || i < 0.00001 ? "" : str(10-i);
            translate([x-(textSize/2-depth/2), length, 0]){
                engrave(text=dispText, size=textSize, depth=depth);
            }
        }
        translate([x, 0, -depth/2]){
            cube([depth, length, depth]);
        }
    }
    translate([0, 0, -depth/2]){
        cube([depth, majorLength, depth]);
    }
    translate([width, 0, -depth/2]){
        cube([depth, majorLength, depth]);
    }
}

function getLength(x, major, minor, modL, modM, modS) = 
    x%modL < 0.000001 || x%modL > (modL-0.000001) ? 
    (minor+major)/2 : 
    (
        x%modM < 0.000001 || x%modM > (modM-0.000001) ? 
        major : 
        ( 
            x%modS < 0.00001 || x%modS > (modS-0.000001) ?
            (minor+major)/2 :
            minor
        )
    );

scaleABCD();
translate([0, 30, 0]){
    scaleL();
}