$(document).ready(function(event){

  $('#new_organization').on("submit", function(event){
    event.preventDefault();
    var searchForm = $(this);

  })

  $('#name').on("keyup", function(event) {
    var searchField = $(this)
    // console.log(searchField)
    var searchData = searchField.val()
    // console.log(searchData)
    if (searchData.length > 4){
       var searchRequest = $.ajax({
        url: '/organizations/search',
        method: 'GET',
        data: searchField.serialize()
       })

       searchRequest.done(function(response) {
        console.log(response);
        $("#search_results").html(response)
        // console.log($(response).find($('ul')))
       })
     }
  })
})
