$(function() {
  var $ownerForm = $("#owner-form");
  $ownerForm.hide();

  $("#owner-button").on("click", function(event) {
    event.preventDefault();
    $ownerForm.show();
  });

  $(".pet-list").on("click", ".pet-header", function(event) {
    event.preventDefault();
  });

});
