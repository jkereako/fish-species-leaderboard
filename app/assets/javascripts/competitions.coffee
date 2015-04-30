class Competition
  constructor: ->
    args =
      todayBtn: 'linked'
      todayHighlight: true
      autoClose: true

    $ 'input[type="datetime"]'
    .each ->
      $ @
      .datepicker args

competition = new Competition
