(function() {
    const root = document.documentElement;
    const storedTheme = localStorage.getItem('resguarda-theme') || 'light';
    document.body.setAttribute('data-theme', storedTheme);

    const applyLogo = () => {
        const theme = document.body.getAttribute('data-theme');
        document.querySelectorAll('[data-logo-light]').forEach(img => {
            const light = img.getAttribute('data-logo-light');
            const dark = img.getAttribute('data-logo-dark');
            img.src = theme === 'dark' ? dark : light;
        });
    };

    const toggleButtons = document.querySelectorAll('[data-toggle-theme]');
    toggleButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            const current = document.body.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
            document.body.setAttribute('data-theme', current);
            localStorage.setItem('resguarda-theme', current);
            applyLogo();
            toggleButtons.forEach(b => b.innerHTML = current === 'dark' ? '<i class="bi bi-moon-stars"></i>' : '<i class="bi bi-brightness-high"></i>');
        });
    });

    applyLogo();

    // Tilt effect
    const tiltCards = document.querySelectorAll('.tilt-card');
    tiltCards.forEach(card => {
        card.addEventListener('mousemove', (e) => {
            const rect = card.getBoundingClientRect();
            const x = e.clientX - rect.left - rect.width / 2;
            const y = e.clientY - rect.top - rect.height / 2;
            const rotateX = (-y / rect.height) * 8;
            const rotateY = (x / rect.width) * 8;
            card.style.setProperty('--tilt-x', `${rotateX}deg`);
            card.style.setProperty('--tilt-y', `${rotateY}deg`);
        });
        card.addEventListener('mouseleave', () => {
            card.style.setProperty('--tilt-x', '0deg');
            card.style.setProperty('--tilt-y', '0deg');
        });
    });
})();