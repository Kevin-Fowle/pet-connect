$(function() {
  var $ownerForm = $("#owner-form");
  $ownerForm.hide();

  $("#owner-button").on("click", function(event) {
    event.preventDefault();
    $ownerForm.show();
  });

});
