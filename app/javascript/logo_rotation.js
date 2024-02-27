document.addEventListener('DOMContentLoaded', function() {
  const wineWords = ['wʌɪn', 'vino', 'vin', 'wein', 'вино'];
  const logoElement = document.getElementById('wineLogo');

  let currentWordIndex = 0;

  function rotateLogoText() {
    logoElement.textContent = '/' + wineWords[currentWordIndex] + '/';
    currentWordIndex = (currentWordIndex + 1) % wineWords.length;
  }

  setInterval(rotateLogoText, 4000);
});
