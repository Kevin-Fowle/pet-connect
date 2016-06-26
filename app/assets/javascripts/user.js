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

   // $("#organization-button").on("click", function(event) {
   //  event.preventDefault();
   //  console.log('aaa');
   //  var registerOrganization = $.ajax({
   //    url: "organization/new"

   //  })

  // });

});
