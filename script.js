// 1. Smooth scroll to anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener("click", function(e) {
    e.preventDefault();
    document.querySelector(this.getAttribute("href"))
            .scrollIntoView({ behavior: "smooth" });
  });
});

// 2. Dark / Light mode toggle
const toggleButton = document.createElement('button');
toggleButton.textContent = "🌙 الوضع الليلي";
toggleButton.style.position = 'fixed';
toggleButton.style.top = '20px';
toggleButton.style.left = '20px';
toggleButton.style.zIndex = '1000';
toggleButton.style.padding = '10px';
toggleButton.style.backgroundColor = 'orange';
toggleButton.style.color = 'white';
toggleButton.style.border = 'none';
toggleButton.style.borderRadius = '5px';
toggleButton.style.cursor = 'pointer';

document.body.appendChild(toggleButton);

toggleButton.addEventListener('click', () => {
  document.body.classList.toggle('dark-mode');
  toggleButton.textContent =
    document.body.classList.contains('dark-mode') ? '☀️ الوضع النهاري' : '🌙 الوضع الليلي';
});

// 3. Add dark-mode styles dynamically
const style = document.createElement('style');
style.innerHTML = `
  body.dark-mode {
    background-color: #1c1c1c;
    color: #eee;
  }
  body.dark-mode header,
  body.dark-mode footer {
    background-color: #2c2c2c !important;
    color: orange;
  }
  body.dark-mode a {
    color: #ff9800;
  }
  body.dark-mode nav a {
    color: #ffcc80;
  }
`;
document.head.appendChild(style);

// 4. Animate on scroll using Intersection Observer
const revealElements = document.querySelectorAll('main > *');
const observer = new IntersectionObserver((entries, observer) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.style.transition = 'all 0.8s ease-out';
      entry.target.style.opacity = 1;
      entry.target.style.transform = 'translateY(0)';
      observer.unobserve(entry.target);
    }
  });
}, { threshold: 0.1 });

revealElements.forEach(el => {
  el.style.opacity = 0;
  el.style.transform = 'translateY(40px)';
  observer.observe(el);
});
