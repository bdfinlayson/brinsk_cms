$ ->
  $('#archive-all').on 'click', ->
    if confirm("Are you sure?")
      ids = []
      $('#completed').find('li').each (i, e) ->
        ids.push($(e).data('id'))
      $.ajax
        url: "/tasks/archive_batch"
        method: 'PATCH'
        data:
          task:
            ids: ids
      console.log "archived tasks: #{ids}"
      $('#completed').empty()


  $('.task').on 'click', ->
    console.log 'clicked task:', @
    $('#modal-content-edit-task').empty()
    $('#empty-modal-edit-task > label').click()
    $.ajax
      url: "/tasks/#{$(@).data('id')}/edit"
      method: 'GET'
      success: (template) ->
        $('#modal-content-edit-task').append(template)

  $('.task-state-well > ul').sortable
    connectWith: 'ul'
    placeholder: "task-placeholder"
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
