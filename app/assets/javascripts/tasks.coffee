$ ->
  $('.task-state-well > ul').sortable
    connectWith: 'ul'
    receive: (ev, ui) ->
      console.log ev, ui
