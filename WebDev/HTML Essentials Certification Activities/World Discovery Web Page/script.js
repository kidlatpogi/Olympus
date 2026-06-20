document.addEventListener("DOMContentLoaded", () => {
    const geoButton = document.getElementById("getLocation");
    const infoPanel = document.getElementById("info-panel");
    const titleDisplay = document.getElementById("continent-title");
    const detailsDisplay = document.getElementById("continent-details");
    const mapAreas = document.querySelectorAll("area");

    // Dataset containing continent facts and bounding coordinates approximation
    const continentData = {
        "north-america": {
            title: "North America 🏔️",
            details: "Home to the world's largest island (Greenland), the Grand Canyon, and Denali. Famous river systems include the Mississippi-Missouri network."
        },
        "south-america": {
            title: "South America 🌱",
            details: "Features the magnificent Amazon Rainforest, the Amazon River (largest by water volume), and the longest continental mountain range, the Andes."
        },
        "europe": {
            title: "Europe 🏰",
            details: "Contains the world's smallest country (Vatican City). Key features include the Alps, the Danube River, and centuries of historical architectural landmarks."
        },
        "africa": {
            title: "Africa 🦁",
            details: "The birthplace of humanity. Home to the Sahara (the largest hot desert), the Nile River (longest in the world), and Mount Kilimanjaro."
        },
        "asia": {
            title: "Asia 🌏",
            details: "The largest and most populous continent. It contains Earth's highest point, Mount Everest, alongside deep geographic structures like Lake Baikal."
        },
        "australia-and-oceania": {
            title: "Australia & Oceania 🦘",
            details: "Famous for the Great Barrier Reef, distinct outback landscapes, and unique marsupial biodiversity isolated from the rest of the world."
        }
    };

    // Helper function to render data inside the panel
    function displayInfo(id) {
        if (continentData[id]) {
            titleDisplay.textContent = continentData[id].title;
            detailsDisplay.textContent = continentData[id].details;
            infoPanel.classList.remove("hidden");
            infoPanel.scrollIntoView({ behavior: 'smooth' });
        }
    }

    // 1. Map Click Interactivity
    mapAreas.forEach(area => {
        area.addEventListener("click", (e) => {
            e.preventDefault(); // Stop standard browser navigations if fallback hrefs exist
            displayInfo(area.id);
        });
    });

    // 2. Geolocation API Logic
    geoButton.addEventListener("click", () => {
        if (!navigator.geolocation) {
            alert("Geolocation is not supported by your browser.");
            return;
        }

        geoButton.textContent = "Locating...";

        navigator.geolocation.getCurrentPosition(
            (position) => {
                const lat = position.coords.latitude;
                const lon = position.coords.longitude;

                // Map coordinates to rough continental boundaries
                const continentId = determineContinent(lat, lon);
                displayInfo(continentId);
                geoButton.textContent = "Discover Location";
            },
            (error) => {
                alert("Unable to retrieve your location. Please select manually on the map.");
                geoButton.textContent = "Discover Location";
            }
        );
    });

    // Simple rough geographic fallback matrix mapping Lat/Lon to Continent ID keys
    function determineContinent(lat, lon) {
        if (lat > 10 && lon < -30) return "north-america";
        if (lat <= 10 && lon < -30) return "south-america";
        if (lat > 35 && lon >= -10 && lon < 40) return "europe";
        if (lat <= 35 && lat > -35 && lon >= -20 && lon < 50) return "africa";
        if (lat > -10 && lon >= 40 && lon < 180) return "asia";
        return "australia-and-oceania"; // Default regional calculation boundary rule
    }
});