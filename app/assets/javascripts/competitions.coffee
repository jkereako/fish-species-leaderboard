class Competition
  @flashDiv: null

  constructor: (@form) ->
    # Bind the unobtrusive JavaScript (UJS) events to our instance methods
    @form.bind 'ajax:success', ajaxSuccess
    @form.bind 'ajax:error', ajaxError
    @form.bind 'ajax:complete', ajaxComplete

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
    if 'competitions' is clientData.controller
      Competition.flashDiv = $ 'div#asynchronous-flash'
      competition = new Competition $ 'form'

$ document
.ready ready
$ document
.on 'page:load', ready
