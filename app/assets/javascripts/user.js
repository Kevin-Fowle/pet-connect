$(function() {

  $(".pet-list").on("click", ".pet-header", function(event) {
    event.preventDefault();
  });

  $(".button-collapse").sideNav();

  $('.modal-trigger').leanModal();

  $(".modal-trigger").on("click", function(event) {
    event.preventDefault();
  });

  $(".pet-list").on("click", ".pet-review-button", function(event) {
   event.preventDefault();
   var petId = $(this).attr("id");
   var petSubmitId = $("input[name='pet_id']").val(petId);
  });

  $(".pet-list").on("submit", "#rating-form", function(event) {
    event.preventDefault();
    var petId = $(".pet-review-button").attr("id");
    console.log(petId);

    var url = $(this).attr('action');
    var data = $(this).serialize() + "&ratable_id=" + petId + "&ratable_type=Pet";

    var request = $.ajax({
      url: url,
      method: 'post',
      data: data
    });

    request.done(function(response){
      console.log(response);
    });

  });


   // $("#organization-button").on("click", function(event) {
   //  event.preventDefault();
   //  console.log('aaa');
   //  var registerOrganization = $.ajax({
   //    url: "organization/new"

   //  })

  // });

});
