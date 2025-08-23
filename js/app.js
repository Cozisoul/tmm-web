const form = document.getElementById('contact-form');
form.addEventListener('submit', e => {
  e.preventDefault();
  alert("Message sent. Thank you!");
  form.reset();
});
