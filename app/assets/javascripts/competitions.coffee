class Competition
  constructor: ->
    # Arguments for the date picker
    args =
      startDate: 'today'
      todayBtn: 'linked'
      todayHighlight: true
      autoClose: true

    # Add a date picker to each field of type "datetime"
    $ 'input[type="datetime"]'
    .each ->
      $ @
      .datepicker args

competition = new Competition
