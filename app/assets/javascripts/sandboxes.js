$(function(){
  //peopleSandboxTriggers();
});

document.addEventListener("turbolinks:load", function() {
  peopleSandboxTriggers();
})

function peopleSandboxTriggers(){
  $(".show_button").click(function (){
    var id = $(this).attr("id").replace("show","sub")
    console.log(id)
    $("#" + id).toggle()
  });
}
