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

  $(".pet-list").on("click", ".pet-review-button", function(event) {
    event.preventDefault();
    var pet_id = $(this).attr("id");
    console.log(pet_id);
    $("input[name='pet_id']").val(pet_id);
  });

   // $("#organization-button").on("click", function(event) {
   //  event.preventDefault();
   //  console.log('aaa');
   //  var registerOrganization = $.ajax({
   //    url: "organization/new"

   //  })

  // });

});
