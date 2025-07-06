const numberInput = document.getElementById("number");
const convertBtn = document.getElementById("convert-btn");
const result = document.getElementById("output");

function romanize(num) {
    var lookup = {M:1000,CM:900,D:500,CD:400,C:100,XC:90,L:50,XL:40,X:10,IX:9,V:5,IV:4,I:1},
        roman = '',i;

    for ( i in lookup ) {
        while ( num >= lookup[i] ) {
        roman += i;
        num -= lookup[i];
        }
    }
    return roman;
}

convertBtn.addEventListener("click", () => {
    if(numberInput.value === "") {
        output.textContent = "Please enter a valid number";
    }
    else if(numberInput.value < 1){
        output.textContent = "Please enter a number greater than or equal to 1";
    }
    else if(numberInput.value > 3999){
        output.textContent = "Please enter a number less than or equal to 3999";
    }
    else {
        output.textContent = romanize(numberInput.value);
    }
});

numberInput.addEventListener("keydown", function(event) {
    if (event.key === "Enter") {
        convertBtn.click();
    }
});