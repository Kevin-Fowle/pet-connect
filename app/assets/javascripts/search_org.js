$(document).ready(function(event){

  $('#new_organization').on("submit", function(event){
    event.preventDefault();
    var searchForm = $(this);

  })

  $('#organization_name').on("keypress", function(event) {
    var searchField = $(this)
    console.log(searchField)
    var data = searchField.val()
    console.log(data);
  })
})
