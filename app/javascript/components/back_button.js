const bindBackButton = () => {
  if (document.querySelector('#back-button')) {
    document.querySelector('#back-button').addEventListener('click', (e) => {
      document.querySelector('#back-link').click();
    })
  };
  if (document.querySelector('#back-button-results')) {
    document.querySelector('#back-button-results').addEventListener('click', (e) => {
      document.querySelector('#back-link').click();
    })
  };
};

export { bindBackButton };
