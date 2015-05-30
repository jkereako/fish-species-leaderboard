class Flash
  constructor: (@flashDiv) ->
    @flashDiv.find 'button.close'
    .click (event) ->
      do event.preventDefault
      $ @
      .parent()
      .fadeOut 'slow'

ready = ->
  flash = new Flash $ 'div#asynchronous-flash'

$(document).ready(ready)
$(document).on('page:load', ready)
