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

  $(".button-collapse").sideNav();

  $('.modal-trigger').leanModal();

  $(".pet-list").on("click", ".pet-review-button", function(event) {
   event.preventDefault();
   var petId = $(this).attr("id");
   var petSubmitId = $("input[name='pet_id']").val(petId);
  });

  $(".pet-list").on("submit", "#rating-form", function(event) {
    event.preventDefault();
    var petId = $(".pet-review-button").attr("id");
    console.log(petId);

  });




   // $("#organization-button").on("click", function(event) {
   //  event.preventDefault();
   //  console.log('aaa');
   //  var registerOrganization = $.ajax({
   //    url: "organization/new"

   //  })

  // });

});
