use <slide-rule-complete.scad>

module multiplication(
    v1=2,
    v2=3
){
    sliderVal=v1*v2>10?(v1/10):v1;
    cursorVal=v1*v2>10?(v1*v2/10):v1*v2;
    slideRule(
        assembled=true,
        cursorVal=cursorVal,
        sliderVal=sliderVal
    );
}

module log(
    x=3
){
    slideRule(
        assembled=true,
        cursorVal=10,
        sliderVal=x
    );
}

module squareRoot(
    x=4
){
    slideRule(
        assembled=true,
        cursorVal=sqrt(x),
        sliderVal=1
    );
}

//multiplication(2, 6);
//log(3);
squareRoot(5);