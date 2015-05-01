class Competition
  constructor: (@userNameFields) ->
    # Find all user name text fields
    $ @userNameFields
    .each (idx, obj)->
      do $ obj
      .multiselect

competition = new Competition( $ '#competition_competitors' )
