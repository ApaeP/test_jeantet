// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

document.addEventListener('turbolinks:load', () => {
  document.querySelector('#button-yes').addEventListener('click', (e) => {
    document.querySelectorAll('.answer_container > div > span > label > input')[0].checked = true
    document.querySelector('.container > form').submit()
  });
  document.querySelector('#button-no').addEventListener('click', (e) => {
    document.querySelectorAll('.answer_container > div > span > label > input')[1].checked = true
    document.querySelector('.container > form').submit()
  });

  document.querySelectorAll('.answer_container > div > span > label > input').forEach((e) => {
    e.checked = false
    e.addEventListener('change', () => {
      document.querySelector('.container > form').submit()
    });
  });
});
