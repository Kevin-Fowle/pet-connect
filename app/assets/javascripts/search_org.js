$(document).ready(function(event){

  $('#new_organization').on("submit", function(event){
    event.preventDefault();
    var searchForm = $(this);

  });

  $('#name').on("keyup", function(event) {
    var searchField = $(this);
    // console.log(searchField)
    var searchData = searchField.val();
    // console.log(searchData)
    if (searchData.length > 4){
       var searchRequest = $.ajax({
        url: '/organizations/search',
        method: 'GET',
        data: searchField.serialize()
      });

       searchRequest.done(function(response) {
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
});
