class Competition
  constructor: (@userNameFields) ->
    DATA = JSON.parse (do $ 'script#client-data'
              .html) if $ 'script#client-data'
                        .length
    if DATA?
      bloodhound = new Bloodhound
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace
        queryTokenizer: Bloodhound.tokenizers.whitespace
        remote: {
          url: "#{DATA.ajaxURL}?q=%NAME"
          wildcard: '%NAME'
        }

      # Find all user name text fields
      $ @userNameFields
      .each (idx, obj)->
        $ obj
        .typeahead
          hint: true
          highlight: true
          minLength: 2
          {name: "user_#{idx}"
          source: bloodhound}

    # Arguments for the date picker
    args =
      startDate: 'today'
      todayBtn: 'linked'
      todayHighlight: true
      autoClose: true

    # Add a date picker to each field of type "datetime"
    # $ 'input[type="date"]'
    # .each ->
    #   $ @
    #   .datepicker args

competition = new Competition( $ '[id^=competition_users_attributes]' )
