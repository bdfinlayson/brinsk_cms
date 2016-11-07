$ ->

  $('.task-state-well > ul').sortable
    connectWith: 'ul'
    stop: (ev, ui) ->
      id = ui.item.data('id')
      state = ev.toElement.closest('ul').id
      ids = []
      positions = []
      $(ev.toElement.closest('ul')).find('li').each (i, e) =>
        positions.push(i)
        $(e).attr('data-position', i)
        ids.push($(e).data('id'))
      console.log state, id, ids, positions
      $.ajax
        url: "/tasks/update_batch"
        method: 'PATCH'
        data:
          task:
            state: state
            ids: ids
            positions: positions
