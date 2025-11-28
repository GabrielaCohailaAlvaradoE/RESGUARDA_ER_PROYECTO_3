document.addEventListener('DOMContentLoaded', () => {
    const body = document.body;
    const themeToggle = document.getElementById('themeToggle');
    const savedTheme = localStorage.getItem('resguarda-theme');
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    const brandLogos = document.querySelectorAll('.brand-logo');

    const applyTheme = (mode) => {
        body.setAttribute('data-theme', mode);
        localStorage.setItem('resguarda-theme', mode);
        if (themeToggle) {
            const icon = themeToggle.querySelector('i');
            if (icon) {
                icon.className = mode === 'dark' ? 'bi bi-moon-stars-fill' : 'bi bi-brightness-high-fill';
            }
            themeToggle.setAttribute('aria-label', mode === 'dark' ? 'Cambiar a modo claro' : 'Cambiar a modo oscuro');
        }
        brandLogos.forEach(logo => {
            const light = logo.dataset.light;
            const dark = logo.dataset.dark;
            logo.src = mode === 'dark' ? dark : light;
        });
    };

    applyTheme(savedTheme || (prefersDark ? 'dark' : 'light'));

    if (themeToggle) {
        themeToggle.addEventListener('click', () => {
            const current = body.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
            applyTheme(current);
        });
    }

    // Parallax tilt
    const tiltCards = document.querySelectorAll('.tilt-card');
    const isTouch = 'ontouchstart' in window || navigator.maxTouchPoints > 0;

    if (!isTouch) {
        tiltCards.forEach(card => {
            const wrapper = card.closest('.parallax-wrapper') || card;
            wrapper.addEventListener('mousemove', (e) => {
                const rect = card.getBoundingClientRect();
                const x = e.clientX - rect.left;
                const y = e.clientY - rect.top;
                const midX = rect.width / 2;
                const midY = rect.height / 2;
                const rotateY = ((x - midX) / midX) * 10;
                const rotateX = -((y - midY) / midY) * 10;

                card.style.setProperty('--tilt-x', `${rotateX}deg`);
                card.style.setProperty('--tilt-y', `${rotateY}deg`);
                card.style.setProperty('--tilt-scale', '1.02');
                card.classList.add('tilt-active');
            });

            wrapper.addEventListener('mouseleave', () => {
                card.style.setProperty('--tilt-x', '0deg');
                card.style.setProperty('--tilt-y', '0deg');
                card.style.setProperty('--tilt-scale', '1');
                card.classList.remove('tilt-active');
            });
        });
    }

    // Password toggle
    document.querySelectorAll('.toggle-password').forEach(btn => {
        btn.addEventListener('click', () => {
            const input = btn.closest('.input-group').querySelector('input[type="password"], input[type="text"]');
            if (!input) return;
            const isHidden = input.getAttribute('type') === 'password';
            input.setAttribute('type', isHidden ? 'text' : 'password');
            const icon = btn.querySelector('i');
            if (icon) {
                icon.className = isHidden ? 'bi bi-eye-slash' : 'bi bi-eye';
            }
            btn.setAttribute('aria-pressed', isHidden ? 'true' : 'false');
            btn.setAttribute('aria-label', isHidden ? 'Ocultar contraseña' : 'Mostrar contraseña');
        });
    });
});