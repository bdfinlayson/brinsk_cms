$ ->

  $('.task-state-well > ul').sortable
    connectWith: 'ul'
    stop: (ev, ui) ->
      id = ui.item.data('id')
      state = ev.toElement.parentElement.id

      if ui.item.next().length > 0 && ui.item.prev().length > 0
        if ui.item.next().data('position') == ui.item.prev().data('position')
          position = parseInt(ui.item.prev().data('position'))
        if ui.item.prev().data('position') - ui.item.next().data('position') == 1
          position = parseInt(ui.item.prev().data('position'))
        else
          position = parseInt(ui.item.prev().data('position')) - 1
      else if ui.item.prev().length > 0
        position = parseInt(ui.item.prev().data('position')) - 1
      else if ui.item.next().length > 0
        position = parseInt(ui.item.next().data('position')) + 1
      else
        position = 1
      $.ajax
        url: "/tasks/#{id}"
        method: 'PATCH'
        data:
          task:
            position: position
            state: state
