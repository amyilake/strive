# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@MorrisLine = ->
  Morris.Line
    element: 'schedules_chart_line'
    data: $('#schedules_chart_line').data('schedules')
    xkey: "starttime"
    ykeys: ykeys($('#schedules_chart_line').data('goals'))
    labels: labels($('#schedules_chart_line').data('goals'))



@MorrisBar= ->
  Morris.Bar
    element: 'schedules_chart_bar'
    data: $('#schedules_chart_bar').data('schedules')
    xkey: "starttime"
    ykeys: ykeys($('#schedules_chart_bar').data('goals'))
    labels: labels($('#schedules_chart_bar').data('goals'))

@MorrisDonut= ->
   Morris.Donut
     element: 'schedules_chart_donut'
     data: $('#schedules_chart_donut').data('schedules')

labels = (goals) -> 
         for i in [0...goals.length]
            goals[i].title+"(小時)"

ykeys = (goals) ->
				for i in [0...goals.length]
            goals[i].title
