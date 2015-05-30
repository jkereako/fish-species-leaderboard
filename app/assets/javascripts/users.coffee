class User
  @flashDiv: null

  constructor: (@remoteLinks) ->
    # Bind the unobtrusive JavaScript (UJS) events to our instance methods
    @remoteLinks.bind 'ajax:success', ajaxSuccess
    @remoteLinks.bind 'ajax:error', ajaxError
    @remoteLinks.bind 'ajax:complete', ajaxComplete

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
      @flashDiv.find 'div.message'
      .text data.data.notice.messages

    @flashDiv.fadeIn 'slow'

ready = ->
  json = do $ 'script#client-data'
  .html

  if json?
    clientData = JSON.parse json
    if 'users' is clientData.controller and 'show' is clientData.action
      User.flashDiv = $ 'div#asynchronous-flash'
      user = new User $ '*[data-remote="true"]'

$(document).ready(ready)
$(document).on('page:load', ready)
