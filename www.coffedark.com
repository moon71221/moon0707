<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Order Coffee</title>
  <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="order.css" />
</head>
<body>

  <header class="header">
    <h1>☕ Place Your Coffee Order</h1>
    <p>We’ll brew it fresh, just for you</p>
  </header>

  <main class="order-container">
    <form class="order-form" action="confirmation.html" method="GET">
      <div class="form-group">
        <label for="name">Full Name</label>
        <input type="text" id="name" name="name" placeholder="Enter your name" required />
      </div>

      <div class="form-group">
        <label for="drink">Select Your Drink</label>
        <select id="drink" name="drink" required>
          <option value="">-- Choose a drink --</option>
          <option value="Espresso">Espresso</option>
          <option value="Latte">Latte</option>
          <option value="Cappuccino">Cappuccino</option>
          <option value="Mocha">Mocha</option>
          <option value="Karak">Karak</option>
        </select>
      </div>

      <div class="form-group">
        <label for="size">Size</label>
        <select id="size" name="size" required>
          <option value="">-- Choose a size --</option>
          <option value="Small">Small</option>
          <option value="Medium">Medium</option>
          <option value="Large">Large</option>
        </select>
      </div>

      <div class="form-group">
        <label for="quantity">Quantity</label>
        <input type="number" id="quantity" name="quantity" min="1" max="10" value="1" />
      </div>

      <div class="form-group">
        <label for="notes">Special Notes</label>
        <textarea id="notes" name="notes" placeholder="Add any custom request..."></textarea>
      </div>

      <button type="submit" class="submit-btn">Place Order</button>
    </form>
  </main>

  <footer class="footer">
    <p>📞 Contact us at: 71405679</p>
    <p>© 2025 Coffee Shop. All rights reserved.</p>
  </footer>

</body>
</html>

// ======== Burger menu toggle =======
const menuToggle = document.getElementById('menu-toggle');
const navLinks = document.querySelector('.nav-links');

menuToggle.addEventListener('click', () => {
  navLinks.classList.toggle('open');
  menuToggle.classList.toggle('active');
});

// ======== Smooth scroll with easing =======
document.querySelectorAll('.nav-links a').forEach(link => {
  link.addEventListener('click', e => {
    e.preventDefault();
    const href = link.getAttribute('href');

    if (href.startsWith('#')) {
      document.querySelector(href).scrollIntoView({
        behavior: 'smooth',
        block: 'start'
      });
    } else {
      window.location.href = href;
    }

    // Close menu on mobile after click
    if (navLinks.classList.contains('open')) {
      navLinks.classList.remove('open');
      menuToggle.classList.remove('active');
    }
  });
});

// ======== Typed Text Effect for Hero =======
class TypedText {
  constructor(element, words, wait = 2000) {
    this.element = element;
    this.words = words;
    this.txt = '';
    this.wordIndex = 0;
    this.wait = parseInt(wait, 10);
    this.isDeleting = false;
    this.type();
  }

  type() {
    const current = this.wordIndex % this.words.length;
    const fullTxt = this.words[current];

    if (this.isDeleting) {
      this.txt = fullTxt.substring(0, this.txt.length - 1);
    } else {
      this.txt = fullTxt.substring(0, this.txt.length + 1);
    }

    this.element.innerHTML = `<span class="typed-text">${this.txt}</span>`;

    let typeSpeed = 100;

    if (this.isDeleting) {
      typeSpeed /= 2;
    }

    if (!this.isDeleting && this.txt === fullTxt) {
      typeSpeed = this.wait;
      this.isDeleting = true;
    } else if (this.isDeleting && this.txt === '') {
      this.isDeleting = false;
      this.wordIndex++;
      typeSpeed = 500;
    }

    setTimeout(() => this.type(), typeSpeed);
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const heroTextEl = document.querySelector('.hero .typed-text');
  if (heroTextEl) {
    new TypedText(heroTextEl, [
      'Coffee brewed with passion',
      'Served with love ☕',
      'Make your day better'
    ], 2500);
  }
});

// ======== Scroll-triggered fade-in animations with Intersection Observer =======
const animatedElements = document.querySelectorAll('[data-animate]');

const observerOptions = {
  root: null,
  rootMargin: '0px',
  threshold: 0.15
};

const observer = new IntersectionObserver((entries, obs) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('animate-fade-in');
      obs.unobserve(entry.target); // Animate only once
    }
  });
}, observerOptions);

animatedElements.forEach(el => observer.observe(el));

// ======== Parallax effect on hero background =======
const hero = document.querySelector('.hero');

window.addEventListener('scroll', () => {
  if (!hero) return;
  const scrollPos = window.scrollY;
  hero.style.backgroundPositionY = `${scrollPos * 0.5}px`;
});

/* ========== Reset & Base ========== */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Cairo', sans-serif;
  background-color: #fffaf3;
  color: #3e2c23; /* بني غامق هادي */
  line-height: 1.6;
  scroll-behavior: smooth;
  min-height: 100vh;
  padding: 40px 20px;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 40px;
}

a {
  text-decoration: none;
  color: inherit;
  cursor: pointer;
}

img {
  max-width: 100%;
  display: block;
  border-radius: 15px;
  box-shadow: 0 8px 20px rgb(62 44 35 / 0.15);
  transition: transform 0.4s ease;
}

img:hover {
  transform: scale(1.05);
}

/* ========== Navbar (optional snippet for consistency) ========== */
.navbar {
  background-color: #3e2c23;
  color: white;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px 30px;
  position: sticky;
  top: 0;
  z-index: 1000;
  box-shadow: 0 3px 10px rgb(0 0 0 / 0.2);
}

.logo {
  font-size: 26px;
  font-weight: 700;
  letter-spacing: 2px;
}

/* ========== Content Section ========== */
.content {
  max-width: 500px;
  flex: 1 1 400px;
  color: #3e2c23;
}

.highlight-text {
  color: #f7c873; /* أصفر ذهبي ناعم */
  font-size: 3.2rem;
  font-weight: 900;
  margin-bottom: 15px;
  text-transform: uppercase;
  letter-spacing: 3px;
  text-shadow: 0 0 10px #f7c873bb;
}

.main-heading {
  font-size: 2.8rem;
  font-weight: 700;
  margin-bottom: 20px;
  color: #5c3d2e;
  text-shadow: 0 0 6px #cfa35baa;
}

.sub-heading {
  font-size: 1.3rem;
  font-weight: 400;
  line-height: 1.6;
  margin-bottom: 40px;
  color: #6e5a43;
}

/* ========== Buttons ========== */
.buttons {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
}

.btn {
  display: inline-block;
  padding: 14px 32px;
  font-weight: 700;
  border-radius: 30px;
  cursor: pointer;
  transition: all 0.3s ease;
  text-align: center;
  user-select: none;
  box-shadow: 0 0 15px transparent;
  border: none;
}

.btn-yellow {
  background-color: #f7c873;
  color: #3e2c23;
  box-shadow: 0 0 15px #f7c873cc;
}

.btn-yellow:hover {
  background-color: #ffd54f;
  box-shadow: 0 0 25px #ffd54fcc;
  color: #2c1a00;
}

.btn-secondary {
  background-color: transparent;
  border: 2px solid #f7c873;
  color: #f7c873;
  box-shadow: 0 0 15px transparent;
}

.btn-secondary:hover {
  background-color: #f7c873;
  color: #3e2c23;
  box-shadow: 0 0 25px #f7c873cc;
}

/* ========== Image Container ========== */
.image-container {
  flex: 1 1 400px;
  max-width: 500px;
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 15px 40px rgb(247 200 115 / 0.4);
  transition: transform 0.4s ease;
}

.image-container:hover {
  transform: scale(1.05);
}

.image-container img {
  border-radius: 20px;
  filter: drop-shadow(0 0 12px #f7c873aa);
  transition: transform 0.5s ease;
}

.image-container:hover img {
  transform: scale(1.1);
}

/* ========== Responsive for Mobile ========== */
@media (max-width: 768px) {
  body {
    flex-direction: column;
    padding: 20px 15px;
    gap: 30px;
    align-items: center; /* توسيط العناصر */
  }

  .content,
  .image-container {
    flex: 1 1 100%;
    max-width: 100%;
    text-align: center;
  }

  .highlight-text {
    font-size: 2.4rem;
    letter-spacing: 2px;
  }

  .main-heading {
    font-size: 2rem;
  }

  .sub-heading {
    font-size: 1.1rem;
    margin-bottom: 30px;
  }

  .buttons {
    justify-content: center;
    gap: 15px;
  }

  .btn {
    padding: 12px 28px;
    font-size: 1rem;
  }

  .image-container {
    box-shadow: 0 10px 30px rgb(247 200 115 / 0.35);
    border-radius: 15px;
    margin: 0 auto;
  }

  img {
    border-radius: 15px;
  }
}

/* Animate fade-in for about content */
.animate-fade-in {
  opacity: 1 !important;
  transform: translateY(0) !important;
  transition: opacity 0.6s ease, transform 0.6s ease;
}

[data-animate] {
  opacity: 0;
  transform: translateY(30px);
}

/* Hero text cool loading animation */
.overlay .char {
  opacity: 0;
  display: inline-block;
  transform: translateY(20px);
}

@keyframes fadeUp {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Toggle menu active state */
.menu-toggle.active {
  color: #f7c873;
  transform: rotate(90deg);
  transition: transform 0.4s ease, color 0.4s ease;
}

/* ========== Reset & Base ========== */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Cairo', sans-serif;
    background-color: #fffaf3;
    color: #333;
    line-height: 1.6;
    scroll-behavior: smooth;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

/* الروابط والصور */
a {
    text-decoration: none;
    color: inherit;
}

img {
    max-width: 100%;
    display: block;
    border-radius: 10px;
}

/* ========== Navbar ========== */
.navbar {
    background-color: #3e2c23;
    color: white;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 30px;
    position: sticky;
    top: 0;
    z-index: 1000;
}

.logo {
    font-size: 24px;
    font-weight: bold;
}

.nav-links {
    list-style: none;
    display: flex;
    gap: 25px;
}

.nav-links li a {
    color: white;
    font-weight: 500;
    transition: color 0.3s ease;
}

.nav-links li a:hover,
.nav-links li a.active {
    color: #f7c873;
}

.menu-toggle {
    display: none;
    font-size: 28px;
    cursor: pointer;
}

/* ========== Hero Section ========== */
.hero {
    background: url('https://images.unsplash.com/photo-1509042239860-f550ce710b93') no-repeat center center/cover;
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
}

.overlay {
    background-color: rgba(0, 0, 0, 0.65);
    padding: 40px 30px;
    border-radius: 10px;
    text-align: center;
    color: #fff;
    max-width: 700px;
}

.overlay h1 {
    font-size: 48px;
    margin-bottom: 15px;
}

.overlay p {
    font-size: 20px;
}

/* ========== About Section ========== */
.about-section {
    padding: 80px 20px;
    background-color: #fdf6ee;
    flex-grow: 1;
}

.container {
    max-width: 1200px;
    margin: auto;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: center;
    gap: 50px;
}

.about-img {
    flex: 1 1 400px;
}

.about-content {
    flex: 1 1 400px;
}

.about-content h2 {
    font-size: 36px;
    color: #5c3d2e;
    margin-bottom: 20px;
}

.about-content p {
    font-size: 18px;
    margin-bottom: 15px;
}

/* ========== Footer ========== */
footer {
    background-color: #3e2c23;
    color: white;
    text-align: center;
    padding: 20px;
    font-size: 14px;
}

/* ========== Responsive ========== */
@media (max-width: 768px) {
    body {
        padding: 20px 10px;
    }

    .container {
        flex-direction: column;
        text-align: center;
    }

    .nav-links {
        display: none;
        flex-direction: column;
        background-color: #3e2c23;
        position: absolute;
        top: 60px;
        right: 0;
        width: 200px;
        padding: 15px;
    }

    .nav-links.open {
        display: flex;
    }

    .menu-toggle {
        display: block;
    }

    .about-img,
    .about-content {
        flex: 1 1 100%;
    }

    .overlay h1 {
        font-size: 36px;
    }

    .overlay p {
        font-size: 16px;
    }
}

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Coffee Spot</title>
<link rel="stylesheet" href="about.css">
    <link href="https://fonts.coffeedark.com/css2?family=Cairo:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar">
        <div class="logo">Coffee Spot</div>
        <ul class="nav-links">
            <li><a href="index.html">Home</a></li>
            <li><a href="menu.html">Menu</a></li>
            <li><a href="about.html" class="active">About</a></li>
            <li><a href="contact.html">Contact</a></li>
        </ul>
        <div class="menu-toggle" id="menu-toggle">&#9776;</div>
    </nav>

    <!-- Hero -->
    <header class="hero">
        <div class="overlay">
            <h1>About Us</h1>
            <p>Coffee brewed with passion and served with love ☕</p>
        </div>
    </header>

    <!-- About Section -->
    <section class="about-section">
        <div class="container">
            <div class="about-img" data-animate>
                <img src="https://images.unsplash.com/photo-1509042239860-f550ce710b93" alt="Coffee">
            </div>
            <div class="about-content" data-animate>
                <h2>Our Story</h2>
                <p>
                    Founded in 2020, Coffee Spot was born from a deep love for specialty coffee and a desire to create a space where people can relax, connect, and enjoy.
                </p>
                <p>
                    We source the finest beans and roast them to perfection. Whether you're grabbing a quick espresso or staying for a slow latte, every cup is crafted with care.
                </p>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <p>© 2025 Coffee Spot. All rights reserved.</p>
    </footer>

    <script src="script.js"></script>
</body>
</html>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Order Confirmed</title>
  <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&display=swap" rel="stylesheet" />
  <style>
    body {
      font-family: 'Cairo', sans-serif;
      background: linear-gradient(135deg, #3e2c23, #1a0e00);
      color: #f4e9d9;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
      padding: 20px;
      text-align: center;
    }

    .confirmation-box {
      background: rgba(62, 44, 35, 0.7);
      padding: 40px 30px;
      border-radius: 20px;
      box-shadow: 0 10px 25px rgba(0,0,0,0.6);
      max-width: 600px;
    }

    h1 {
      font-size: 2.8rem;
      color: #f7c873;
      margin-bottom: 20px;
      text-shadow: 0 0 10px #d79a2f;
    }

    p {
      font-size: 1.3rem;
      margin-bottom: 10px;
      color: #f4e9d9;
    }

    .number {
      font-weight: bold;
      color: #f7c873;
      text-shadow: 0 0 5px #d79a2f;
    }

    a {
      display: inline-block;
      margin-top: 25px;
      padding: 10px 20px;
      background-color: #f7c873;
      color: #3e2c23;
      text-decoration: none;
      border-radius: 10px;
      font-weight: bold;
      transition: background 0.3s ease;
    }

    a:hover {
      background-color: #d79a2f;
    }
  </style>
</head>
<body>

  <div class="confirmation-box">
    <h1>✅ Order Confirmed!</h1>
    <p>Your coffee order has been successfully received.</p>
    <p>You will receive a message shortly from our team.</p>
    <p class="number">📱 Contact Number: 71405679</p>
    <a href="menu.html">Back to Menu</a>
  </div>

</body>
</html>

/* Existing styles (unchanged) */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Cairo', sans-serif;
  background: linear-gradient(135deg, #3e2c23, #1a0e00);
  color: #f4e9d9;
  padding: 60px 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
}

.contact-container {
  background: rgba(62, 44, 35, 0.8);
  padding: 40px 30px;
  border-radius: 20px;
  max-width: 600px;
  width: 100%;
  box-shadow:
    0 15px 40px rgba(30, 15, 0, 0.7),
    inset 0 0 20px rgba(247, 200, 115, 0.4);
  text-align: center;
}

h1 {
  font-size: 2.8rem;
  background: linear-gradient(90deg, #f7c873, #d79a2f);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  text-shadow: 0 0 10px #f7c873aa;
  margin-bottom: 10px;
}

.subtitle {
  font-size: 1.2rem;
  color: #d4b45a;
  margin-bottom: 25px;
}

.contact-form input,
.contact-form textarea {
  width: 100%;
  padding: 15px;
  margin-bottom: 20px;
  border: none;
  border-radius: 10px;
  background: #fffaf3;
  font-size: 1rem;
  color: #3e2c23;
  box-shadow: 0 0 10px rgba(247, 200, 115, 0.3);
}

.contact-form textarea {
  resize: vertical;
}

.contact-form button {
  background-color: #f7c873;
  color: #3e2c23;
  padding: 14px 30px;
  font-weight: bold;
  border: none;
  border-radius: 30px;
  cursor: pointer;
  font-size: 1.1rem;
  transition: all 0.3s ease;
  box-shadow: 0 0 20px #f7c873aa;
}

.contact-form button:hover {
  background-color: #ffd54f;
  box-shadow: 0 0 30px #ffd54faa;
}

.contact-info {
  margin-top: 30px;
  font-size: 1rem;
  color: #f7c873;
}

.contact-info a {
  color: #f7c873;
  text-decoration: none;
}

.contact-info a:hover {
  text-decoration: underline;
}

/* Responsive improvements for mobile */
@media (max-width: 480px) {
  body {
    padding: 30px 15px;
    min-height: auto;
    align-items: flex-start;
  }

  .contact-container {
    padding: 25px 20px;
    border-radius: 15px;
    max-width: 100%;
  }

  h1 {
    font-size: 2.2rem;
    margin-bottom: 8px;
  }

  .subtitle {
    font-size: 1rem;
    margin-bottom: 18px;
  }

  .contact-form input,
  .contact-form textarea {
    padding: 12px;
    font-size: 0.95rem;
    margin-bottom: 15px;
  }

  .contact-form button {
    padding: 12px 25px;
    font-size: 1rem;
    border-radius: 25px;
  }

  .contact-info {
    font-size: 0.9rem;
    margin-top: 20px;
  }
}

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Contact Us - Coffee Shop</title>
  <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="contact.css" />
</head>
<body>
  <div class="contact-container">
    <h1>Contact Us</h1>
    <p class="subtitle">We’d love to hear from you ☕</p>

    <form class="contact-form">
      <input type="text" name="name" placeholder="Your Name" required />
      <input type="email" name="email" placeholder="Your Email" required />
      <textarea name="message" rows="5" placeholder="Your Message" required></textarea>
      <button type="submit">Send Message</button>
    </form>

    <div class="contact-info">
      <p><strong>Phone:</strong> <a href="tel:+97471405679">+974 71405679</a></p>
      <p><strong>Email:</strong> hello@coffeeshop.qa</p>
    </div>
  </div>
</body>
</html>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>About Coffee</title>
  <link rel="stylesheet" href="style.css" />
  <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&display=swap" rel="stylesheet" />
</head>
<body>
  <div class="content">
    <p class="highlight-text">Best Coffee</p>
    <h3 class="main-heading">Make Your Day With Our Coffee</h3>
    <h5 class="sub-heading">
      Welcome to our coffee and enjoy forever.<br />
      That would be really nice!
    </h5>

    <div class="buttons">
      <a href="order.html" class="btn btn-yellow">Order Here</a>
      <a href="about.html" class="btn btn-secondary">About Us</a>
    </div>
  </div>

  <div class="image-container">
    <img src="https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg" alt="Coffee Cup" />
  </div>
  <script src="script.js"></script>

</body>
</html>

/* Reset & base */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Cairo', sans-serif, Arial, sans-serif;
  background: linear-gradient(135deg, #3e2c23, #1a0e00);
  color: #f4e9d9;
  line-height: 1.6;
  padding: 50px 20px;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

/* Header with glow and gold gradient */
.header {
  text-align: center;
  margin-bottom: 60px;
  user-select: none;
}

.header h1 {
  font-size: 3.8rem;
  font-weight: 900;
  background: linear-gradient(90deg, #f7c873, #d79a2f);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  text-shadow:
    0 0 8px #f7c873aa,
    0 0 15px #d79a2fbb,
    0 0 20px #f7c873dd;
  margin-bottom: 15px;
  letter-spacing: 4px;
}

.header p {
  font-size: 1.5rem;
  font-weight: 600;
  color: #d4b45a;
  text-shadow: 0 0 10px #cfa35baa;
  font-style: italic;
}

/* Menu container with subtle glass effect */
.menu-container {
  max-width: 960px;
  margin: 0 auto;
  display: flex;
  gap: 50px;
  flex-wrap: wrap;
  justify-content: center;
  backdrop-filter: blur(12px);
  background: rgba(62, 44, 35, 0.6);
  border-radius: 30px;
  padding: 40px 30px;
  box-shadow:
    inset 0 0 30px rgba(247, 200, 115, 0.5),
    0 25px 50px rgba(30, 15, 0, 0.7);
  transition: box-shadow 0.5s ease;
}

.menu-container:hover {
  box-shadow:
    inset 0 0 50px rgba(247, 200, 115, 0.8),
    0 30px 60px rgba(40, 20, 0, 0.9);
}

/* Each category card with deep shadows and highlights */
.menu-category {
  flex: 1 1 300px;
  background: linear-gradient(145deg, #4d3a22, #6b4c28);
  border-radius: 30px;
  padding: 35px 30px;
  box-shadow:
    0 12px 25px rgba(0,0,0,0.8),
    inset 0 -5px 15px #d79a2f44,
    inset 0 5px 15px #f7c87333;
  color: #f7c873;
  cursor: default;
  position: relative;
  overflow: hidden;
  transition: transform 0.35s cubic-bezier(.22,.61,.36,1), box-shadow 0.35s ease;
}

.menu-category::before {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: radial-gradient(circle at center, rgba(247,200,115,0.2), transparent 70%);
  opacity: 0;
  transition: opacity 0.4s ease;
  pointer-events: none;
  z-index: 0;
}

.menu-category:hover::before {
  opacity: 1;
}

.menu-category:hover {
  transform: translateY(-15px) scale(1.05);
  box-shadow:
    0 18px 45px rgba(255, 223, 90, 0.85),
    inset 0 -8px 20px #d79a2f66,
    inset 0 8px 20px #f7c87355;
  z-index: 10;
}

.menu-category h2 {
  font-size: 2.2rem;
  font-weight: 900;
  margin-bottom: 30px;
  text-shadow:
    0 0 6px #f7c873bb,
    0 0 15px #d79a2fbb;
  letter-spacing: 3px;
  position: relative;
  z-index: 2;
}

/* Menu list styling */
.menu-category ul {
  list-style: none;
  position: relative;
  z-index: 2;
}

.menu-category ul li {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px 0;
  border-bottom: 1px solid #d79a2f44;
  transition: background-color 0.3s ease;
}

.menu-category ul li:last-child {
  border-bottom: none;
}

.menu-category ul li:hover {
  background: rgba(247, 200, 115, 0.2);
  border-radius: 15px;
}

.item-name {
  font-weight: 800;
  font-size: 1.2rem;
  color: #fff4d1;
  max-width: 40%;
  text-shadow: 0 0 6px #d79a2fcc;
}

.item-desc {
  font-style: italic;
  font-size: 1rem;
  color: #d4b45a;
  flex: 1;
  margin: 0 20px;
  letter-spacing: 0.05em;
  user-select: none;
}

.item-price {
  font-weight: 900;
  font-size: 1.3rem;
  color: #f7c873;
  min-width: 65px;
  text-align: right;
  text-shadow: 0 0 6px #f7c873cc;
}

/* Footer styling */
.footer {
  margin-top: 60px;
  text-align: center;
  font-weight: 600;
  font-size: 1rem;
  color: #d4b45a;
  user-select: none;
  text-shadow: 0 0 8px #d79a2fbb;
}

/* Responsive */
@media (max-width: 768px) {
  .menu-container {
    flex-direction: column;
    padding: 30px 15px;
  }
  
  .menu-category {
    width: 100%;
    margin-bottom: 30px;
  }
}
/* ====== Glow on Click Animation ====== */
.menu-category.clicked {
  animation: glowFlash 0.8s ease-out;
}

@keyframes glowFlash {
  0% {
    box-shadow: 0 0 0 rgba(255, 215, 100, 0);
  }
  50% {
    box-shadow: 0 0 30px 12px rgba(255, 215, 100, 0.8);
  }
  100% {
    box-shadow: 0 0 0 rgba(255, 215, 100, 0);
  }
}

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Coffee Shop Menu</title>
  <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="menu.css" />
</head>
<body>

  <header class="header">
    <h1>☕ Coffee Shop Menu</h1>
    <p>Discover your perfect brew</p>
  </header>

  <main class="menu-container">

    <section class="menu-category">
      <h2>Espresso Drinks</h2>
      <ul>
        <li>
          <span class="item-name">Espresso</span>
          <span class="item-desc">Strong and bold single shot</span>
          <span class="item-price">5 QAR</span>
        </li>
        <li>
          <span class="item-name">Americano</span>
          <span class="item-desc">Espresso with hot water</span>
          <span class="item-price">6 QAR</span>
        </li>
        <li>
          <span class="item-name">Cappuccino</span>
          <span class="item-desc">Espresso with steamed milk & foam</span>
          <span class="item-price">7 QAR</span>
        </li>
      </ul>
    </section>

    <section class="menu-category">
      <h2>Milk-based Drinks</h2>
      <ul>
        <li>
          <span class="item-name">Latte</span>
          <span class="item-desc">Espresso with steamed milk</span>
          <span class="item-price">6 QAR</span>
        </li>
        <li>
          <span class="item-name">Mocha</span>
          <span class="item-desc">Latte with chocolate syrup</span>
          <span class="item-price">7 QAR</span>
        </li>
        <li>
          <span class="item-name">Flat White</span>
          <span class="item-desc">Smooth espresso with velvety milk</span>
          <span class="item-price">6 QAR</span>
        </li>
      </ul>
    </section>

    <section class="menu-category">
      <h2>Cold Drinks</h2>
      <ul>
        <li>
          <span class="item-name">Iced Espresso</span>
          <span class="item-desc">Chilled shot of bold espresso</span>
          <span class="item-price">5 QAR</span>
        </li>
        <li>
          <span class="item-name">Iced Cappuccino</span>
          <span class="item-desc">Foamy chilled milk with espresso</span>
          <span class="item-price">6 QAR</span>
        </li>
        <li>
          <span class="item-name">Iced Latte</span>
          <span class="item-desc">Cold milk and rich espresso</span>
          <span class="item-price">6 QAR</span>
        </li>
        <li>
          <span class="item-name">Iced Mocha</span>
          <span class="item-desc">Cold chocolate coffee mix</span>
          <span class="item-price">7 QAR</span>
        </li>
      </ul>
    </section>

    <section class="menu-category">
      <h2>Specials</h2>
      <ul>
        <li>
          <span class="item-name">Karak Chai</span>
          <span class="item-desc">Spiced Qatari milk tea</span>
          <span class="item-price">2 QAR</span>
        </li>
        <li>
          <span class="item-name">Hot Chocolate</span>
          <span class="item-desc">Rich cocoa with steamed milk</span>
          <span class="item-price">4 QAR</span>
        </li>
        <li>
          <span class="item-name">Affogato</span>
          <span class="item-desc">Vanilla ice cream & espresso</span>
          <span class="item-price">7 QAR</span>
        </li>
        <li>
          <span class="item-name">Honey Latte</span>
          <span class="item-desc">Sweetened with natural honey</span>
          <span class="item-price">6 QAR</span>
        </li>
      </ul>
    </section>

  </main>

  <footer class="footer">
    <p>© 2025 Coffee Shop. All rights reserved.</p>
  </footer>

</body>
</html>

/* Reset & base */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Cairo', sans-serif;
  background: linear-gradient(135deg, #3e2c23, #1a0e00);
  color: #f4e9d9;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  padding: 40px 20px;
}

/* Header */
.header {
  text-align: center;
  margin-bottom: 50px;
}

.header h1 {
  font-size: 3rem;
  background: linear-gradient(90deg, #f7c873, #d79a2f);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  text-shadow: 0 0 12px #f7c873aa;
}

.header p {
  color: #d4b45a;
  font-style: italic;
  font-size: 1.2rem;
  margin-top: 10px;
}

/* Form container */
.order-container {
  max-width: 600px;
  margin: 0 auto;
  background: rgba(62, 44, 35, 0.6);
  border-radius: 20px;
  padding: 40px 30px;
  box-shadow: 0 20px 50px rgba(0, 0, 0, 0.6);
  backdrop-filter: blur(10px);
}

.order-form .form-group {
  margin-bottom: 25px;
}

.order-form label {
  display: block;
  margin-bottom: 8px;
  color: #f7c873;
  font-weight: 700;
}

.order-form input,
.order-form select,
.order-form textarea {
  width: 100%;
  padding: 12px;
  border-radius: 10px;
  border: none;
  background-color: #fffaf3;
  color: #3e2c23;
  font-size: 1rem;
  outline: none;
}

.order-form textarea {
  resize: vertical;
  min-height: 100px;
}

/* Submit button */
.submit-btn {
  width: 100%;
  padding: 14px;
  font-size: 1.1rem;
  font-weight: bold;
  border: none;
  border-radius: 30px;
  background: #f7c873;
  color: #3e2c23;
  cursor: pointer;
  transition: background 0.3s ease, box-shadow 0.3s ease;
  box-shadow: 0 0 15px #f7c87388;
}

.submit-btn:hover {
  background: #ffd54f;
  box-shadow: 0 0 25px #ffd54fcc;
}

/* Footer */
.footer {
  margin-top: 60px;
  text-align: center;
  color: #d4b45a;
  font-size: 0.95rem;
  text-shadow: 0 0 5px #d79a2f88;
}

/* Responsive Styles */
@media (max-width: 480px) {
  body {
    padding: 20px 15px;
  }
  
  .header h1 {
    font-size: 2rem;
  }
  
  .header p {
    font-size: 1rem;
  }
  
  .order-container {
    padding: 25px 20px;
    border-radius: 15px;
  }
  
  .order-form label {
    font-size: 0.9rem;
  }
  
  .order-form input,
  .order-form select,
  .order-form textarea {
    padding: 10px;
    font-size: 0.9rem;
  }
  
  .submit-btn {
    padding: 12px;
    font-size: 1rem;
    border-radius: 25px;
  }
  
  .footer {
    font-size: 0.85rem;
    margin-top: 40px;
  }
}
