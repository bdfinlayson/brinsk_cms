$ ->
  $("#modal-1").on "change", ->
    if ($(this).is(":checked"))
      $("body").addClass("modal-open")
    else
      $("body").removeClass("modal-open")

  $(".modal-close").on "click", ->
    $(".modal-state:checked").prop("checked", false).change()
