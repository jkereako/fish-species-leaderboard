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

aCatch = new Catch $ 'input#catch_species'
