$ ->
  $('.dataTable').dataTable
    aaSorting: []
    scrollY: ($('.content-wrapper').height() - 50) * 70 / 100
    paging: false
    scrollCollapse: false
    responsive: true
    bInfo: false
    orderClasses: true
