const bindButtonsToForm = () => {
  if (document.querySelector('#button-yes')) {
    document.querySelector('#button-yes').addEventListener('click', (e) => {
      document.querySelectorAll('.form-fields > div > span > label > input')[0].checked = true
      document.querySelector('.form-container > form').submit()
    });
    document.querySelector('#button-no').addEventListener('click', (e) => {
      document.querySelectorAll('.form-fields > div > span > label > input')[1].checked = true
      document.querySelector('.form-container > form').submit()
    });
    document.querySelectorAll('.form-fields > div > span > label > input').forEach((e) => {
      e.checked = false
      e.addEventListener('change', () => {
        document.querySelector('.form-container > form').submit()
      });
    });
  };
};

export { bindButtonsToForm };
