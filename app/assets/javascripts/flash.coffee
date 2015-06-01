# Generic class to handle the display of the Flash div for remote forms.
class Flash
  @flashDiv: null

  constructor: (@ujsElements) ->
    @ujsElements.bind 'ajax:success', ajaxSuccess
    @ujsElements.bind 'ajax:error', ajaxError
    @ujsElements.bind 'ajax:complete', ajaxComplete

    @flashDiv.find 'button.close'
    .click (event) ->
      do event.preventDefault
      $ @
      .parent()
      .fadeOut 'slow'

  ajaxSuccess = (event, data, textStatus, jqXHR) =>
    @flashDiv
    .removeClass()
    .addClass 'alert alert-success'

  ajaxError = (event, jqXHR, textStatus, errorThrown) =>
    @flashDiv
    .removeClass()
    .addClass 'alert alert-danger'

  ajaxComplete = (event, jqXHR, textStatus) =>
    data = jqXHR.responseJSON

    @flashDiv.find 'h4'
    .text data.data.notice.title

    do @flashDiv.find 'div.message'
    .empty

    if 'messages' of data.data.notice
      messageDiv = @flashDiv.find 'div.message'
      messageDiv.append "<p class='small'>#{message}</p>" \
      for message in data.data.notice.messages

    @flashDiv.fadeIn 'slow'

ready = ->
  Flash.flashDiv = $ 'div#asynchronous-flash'
  # Find all UJS remote links and forms
  flash = new Flash $ '*[data-remote="true"]'

$(document).ready(ready)
$(document).on('page:load', ready)
