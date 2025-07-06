// Get the input field where the user enters a number
const numberInput = document.getElementById("number");

// Get the button element that triggers the conversion
const convertBtn = document.getElementById("convert-btn");

// Get the output element where the result will be displayed
const result = document.getElementById("output");

// Function to convert an integer to a Roman numeral
function romanize(num) {
    // Define Roman numeral symbols and their corresponding values
    var lookup = {
        M: 1000,
        CM: 900,
        D: 500,
        CD: 400,
        C: 100,
        XC: 90,
        L: 50,
        XL: 40,
        X: 10,
        IX: 9,
        V: 5,
        IV: 4,
        I: 1
    };

    // Initialize an empty string to build the Roman numeral
    var roman = '', i;

    // Loop through the lookup object
    for (i in lookup) {
        // While the number is greater than or equal to the current Roman value
        while (num >= lookup[i]) {
            // Add the Roman symbol to the result string
            roman += i;
            // Subtract its value from the number
            num -= lookup[i];
        }
    }

    // Return the final Roman numeral string
    return roman;
}

// Add a click event listener to the Convert button
convertBtn.addEventListener("click", () => {
    // If the input field is empty
    if (numberInput.value === "") {
        result.textContent = "Please enter a valid number"; // Show error message
    }
    // If the input is less than 1 (Roman numerals start at 1)
    else if (numberInput.value < 1) {
        result.textContent = "Please enter a number greater than or equal to 1";
    }
    // If the input is greater than 3999 (standard Roman numerals usually stop at 3999)
    else if (numberInput.value > 3999) {
        result.textContent = "Please enter a number less than or equal to 3999";
    }
    // If the input is valid
    else {
        // Convert the number and display the result
        result.textContent = romanize(numberInput.value);
    }
});

// Add keydown event listener to the input field
numberInput.addEventListener("keydown", function(event) {
    // If the user presses Enter
    if (event.key === "Enter") {
        convertBtn.click(); // Trigger the Convert button click event
    }
});
