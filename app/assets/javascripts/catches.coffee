class Catch
  constructor: (@speciesList, @inputField) ->
    bloodhound = new Bloodhound
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace
      queryTokenizer: Bloodhound.tokenizers.whitespace
      local: @speciesList

    $ @inputField
      .typeahead
        hint: true
        highlight: true
        minLength: 2
        {name: 'species'
        source: bloodhound}

# The code below is boilerplate for use with TurboLinks
# see: http://stackoverflow.com/questions/18770517/rails-4-how-to-use-document-ready-with-turbo-links#18770589
ready = ->
  json = do $ 'script#client-data'
  .html

  if json?
    clientData = JSON.parse json

    # Only load this JavaScript if the corresponding controller is showing.
    if 'catches' is clientData.controller and 'species' of clientData
      aCatch = new Catch clientData.species, $ 'input#catch_species'

$ document
.ready ready
$ document
.on 'page:load', ready
