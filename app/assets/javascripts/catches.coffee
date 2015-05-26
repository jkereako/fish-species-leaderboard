class Catch
  constructor: (@speciesDiv) ->
    DATA = JSON.parse (do $ 'script#species-data'
              .html) if $ 'script#species-data'
                        .length

    if DATA?
      bloodhound = new Bloodhound
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace
        queryTokenizer: Bloodhound.tokenizers.whitespace
        local: DATA

      $ @speciesDiv
        .typeahead
          hint: true
          highlight: true
          minLength: 2
          {name: 'species_sugs'
          source: bloodhound}

# The code below is boilerplate for use with TurboLinks
# see: http://stackoverflow.com/questions/18770517/rails-4-how-to-use-document-ready-with-turbo-links#18770589
ready = ->
  clientData = JSON.parse ($ 'script#client-data'
  .html())

  # Only load this JavaScript if the corresponding controller is showing.
  if 'catches' is clientData.controller
    aCatch = new Catch $ 'input#catch_species'

$(document).ready(ready)
$(document).on('page:load', ready)

aCatch = new Catch $ 'input#catch_species'
