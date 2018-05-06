//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

$(function(){
  triggers();
});

function triggers(){
  $("#group_select").change(function (){
    $.ajax({
        method: "GET",
        url: "/get_teams",
        data: { group: $(this).val()},
        dataType: 'script',
        success: function(teams){
          populateTeamFilter(JSON.parse(teams));
        }
      });
  });
}

function populateTeamFilter(teams){
  $("#team_select").empty();
  $("#team_select").append("<option value>All</option>");
  for(var i = 0; i < teams.length; i++){
    $("#team_select").append("<option value='" + teams[i]["id"] + "'>" + teams[i]["name"] + "</option>");
  }
}

function drawGraph(){
  var array = [["Month","Actual","Forecast","Baseline"]["jan",1,2,3]];
  var dataTable = new google.visualization.arrayToDataTable(array);

  var chart = new google.visualization.AreaChart(document.getElementById("finance_graph"));

  var options = {width: 960,
                 height: 480,
                 vAxis: {format: "£#,###"}}

  chart.draw(dataTable, options);
}
