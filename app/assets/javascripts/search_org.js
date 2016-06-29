$(document).ready(function(event){

  $('#search-bar').on("submit", function(event){
    event.preventDefault();
    $("#owner-form").show();
    $(this).hide();
    $('#search_results').hide();

  });

  $('.add-hospital-form').on("submit", function(event){
    event.preventDefault();
    var searchForm = $(this);

  });

  $('#name').on("keyup", function(event) {
    var searchField = $(this);
    // console.log(searchField)
    var searchData = searchField.val();
    console.log(searchData);
    if (searchData.length > 4) {
       var searchRequest = $.ajax({
        url: '/organizations/search',
        method: 'GET',
        data: searchField.serialize()
      });

       searchRequest.done(function(response) {
         console.log(response);
        $("#search_results").html(response);
      });
     }
  });

  $('#search_results').on('click', 'h5', function(event){
    event.preventDefault();
    var hospitalName = $(this).text();
    $('#name').val(hospitalName);
    $('#submit_button').val('Select');

  });

  $("#add-org-button").on("click", function() {
    $("#search-field").focus();
  });
});

$(document).ready(function(event){

  $('#approve_pet_owner').on("click", function(event){
    event.preventDefault();

  });

});
