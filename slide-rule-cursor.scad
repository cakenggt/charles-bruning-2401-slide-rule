module cursor(
    width=18,
    cutoutLength=28,
    thickness=1,
    railLength=2,
    cutoutHeight=1
){
    difference(){
        group(){
            cube([width, railLength+thickness, thickness]);
            cube([width, thickness, thickness*2+cutoutHeight]);
            translate([0, cutoutLength-thickness, 0]){
                cube([width, railLength+thickness, thickness]);
                translate([0, railLength, 0])
                cube([width, thickness, thickness*2+cutoutHeight]);
            }
            translate([0, 0, thickness+cutoutHeight])
            cube([width, cutoutLength+(2*thickness), thickness]);
        }
        //hairline
        translate([thickness, railLength+thickness, thickness+cutoutHeight-0.5])
        hairline(w=width-2*thickness, l=cutoutLength-2*railLength, hairWidth=0.8, h=thickness+1);
    }
}

module hairline(
    w=16,
    l=24,
    h=2,
    hairWidth=0.8
){
    //2 cuboids separated by line
    roundedCuboid(r=1, w=w/2-hairWidth/2, l=l, h=h);
    translate([w/2+hairWidth/2, 0, 0])
    roundedCuboid(r=1, w=w/2-hairWidth/2, l=l, h=h);
}

module roundedCuboid(
    r=1,
    w=8,
    l=24,
    h=2,
    $fn=20
){
    hull(){
        translate([r, r, 0])
        cylinder(r=r, h=h, $fn=$fn);
        translate([w-r, r, 0])
        cylinder(r=r, h=h, $fn=$fn);
        translate([r, l-r, 0])
        cylinder(r=r, h=h, $fn=$fn);
        translate([w-r, l-r, 0])
        cylinder(r=r, h=h, $fn=$fn);
    }
}

cursor();