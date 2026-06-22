// World Trivia Functional script.js

document.addEventListener('DOMContentLoaded', () => {
    // Contact form submission handling
    const contactForm = document.getElementById('contact-form');
    if (contactForm) {
        contactForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const name = document.getElementById('contact-name').value;
            alert(`Thank you for your message, ${name}! Our editorial team will get back to you shortly.`);
            contactForm.reset();
        });
    }

    // Subscribe button click handling
    const subscribeBtn = document.getElementById('btn-subscribe');
    if (subscribeBtn) {
        subscribeBtn.addEventListener('click', () => {
            alert('Thank you for subscribing to our Puzzle of the Day! Check your inbox tomorrow morning.');
        });
    }
});
