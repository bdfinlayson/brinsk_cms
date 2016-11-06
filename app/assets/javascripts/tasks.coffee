$ ->

  $('.task-state-well > ul').sortable
    connectWith: 'ul'
    stop: (ev, ui) ->
      id = ui.item.data('id')
      state = ev.toElement.parentElement.id
      position = ui.item.data('position')
      $.ajax
        url: "/tasks/#{id}"
        method: 'PATCH'
        data:
          task:
            position: position
            state: state
