




function moveEvent(event, dayDelta, minuteDelta, allDay){

    jQuery.ajax({
        data: 'id=' + event.id + '&title=' + event.title + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta + '&all_day=' + allDay + '&authenticity_token=' + authenticity_token,
        dataType: 'script',
        type: 'post',
        url: window.location.href+"/move"
    });
}

function resizeEvent(event, dayDelta, minuteDelta){
    jQuery.ajax({
        data: 'id=' + event.id + '&title=' + event.title + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta + '&authenticity_token=' + authenticity_token,
        dataType: 'script',
        type: 'post',
        url: window.location.href+"/resize"
    });
}


function refetch_events_and_close_dialog() {
  $('#calendar').fullCalendar( 'refetchEvents' );
  $('.dialog:visible').dialog('destroy');
}

function createEvent(title,start,end,allDay){
    //alert(window.location.href);
    jQuery.ajax({
      url:  "schedules/new",
      data: 'title=' + title + '&starttime=' + start + '&endtime=' + end + '&all_day=' + allDay + '&authenticity_token=' + authenticity_token,
      success: function(data) {
        $('#event_desc').html(data['form']);
      }
    });

    $('#desc_dialog').dialog({
        title: "努力",
        modal: true,
        width: 300,
        close: function(event, ui){
            $('#desc_dialog').dialog('destroy');
        }
        
    });
}

function showEventDetails(event){
    //$('#edit_event').html(event.title);
    editEvent(event.id);
    $('#desc_dialog').dialog({
        title: "努力",
        modal: true,
        width: 300,
        buttons: {
            "delete": function(){
                deleteEvent(event.id,"false");
            }
        },
        close: function(event, ui){
            $('#desc_dialog').dialog('destroy');
        }
        
    });
    
}


function editEvent(event_id){
    jQuery.ajax({
      url:  window.location.href+"/"+event_id + "/edit",
      success: function(data) {
        $('#event_desc').html(data['form']);
      }
    });
}

function deleteEvent(event_id, delete_all){
  jQuery.ajax({
    data: 'authenticity_token=' + authenticity_token + '&delete_all=' + delete_all,
    dataType: 'script',
    type: 'delete',
    url: window.location.href+"/"+event_id,
    success: refetch_events_and_close_dialog
  });
}




