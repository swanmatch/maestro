$(document).ready(function () {
  $('[data-toggle="offcanvas"]').click(function () {
    $('.row-offcanvas').toggleClass('active');
    $('.inbody').toggleClass('col-xs-offset-4 col-sm-offset-3');
  })
});

