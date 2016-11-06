$ ->
  $('.task-state-well').sortable
    connectWith: 'ul'
    receive: (ev, ui) ->
      console.log ev, ui
