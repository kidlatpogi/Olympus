const palindromeTxt = document.getElementById("text-input");
const palindromeBtn = document.getElementById("check-btn");
const result = document.getElementById("result");

palindromeTxt.addEventListener("keydown", function(event) {
    if (event.key === "Enter") {
        palindromeBtn.click();
    }
});

palindromeBtn.addEventListener("click", () => {
    const original = palindromeTxt.value;

    if (original.trim() === "") {
        alert("Please input a value.");
        return;
    }

    const cleaned = original.toLowerCase().replace(/[^a-z0-9]/g, "");
    const reversed = cleaned.split("").reverse().join("");

    if (cleaned === reversed) {
        result.textContent = `"${original}" is a palindrome.`;
    } else {
        result.textContent = `"${original}" is not a palindrome.`;
    }
});
