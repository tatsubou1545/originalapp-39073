document.addEventListener('DOMContentLoaded', function() {
  // animation呼び出し
  if (document.querySelectorAll('.js-scroll-trigger').length) {
    scrollAnimation();
  }

  // animation関数
  function scrollAnimation() {
    window.addEventListener('scroll', function() {
      document.querySelectorAll('.js-scroll-trigger').forEach(function(trigger) {
        let position = trigger.getBoundingClientRect().top + window.pageYOffset,
            scroll = window.pageYOffset,
            windowHeight = window.innerHeight;

        if (scroll > position - windowHeight + 200) {
          trigger.classList.add('is-active');
        }
      });
    });
  }
  window.dispatchEvent(new Event('scroll'));
});