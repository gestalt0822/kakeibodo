$(document).on 'change', '#booking_category_id', ->
  $.ajax(
    type: 'GET'
    url: '/bookings/get_sorts'
    data: {
      category_id: $(this).val()
    }
  ).done (date) ->
    $('#select_sort').html(date)
