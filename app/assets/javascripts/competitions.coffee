class Competition
  # Define the minimum number of competitors per competition
  @competitorMinimum = 2

  constructor: (@form) ->
    selectedCompetitorsCount = 0
    # Add Bootstrap Multiselect to the competitor selection field. This method
    # assumes `@competitorsField` is an HTML `select` element.

    submitButton = @form.find 'input[type="submit"]'
    multiSelectField = @form.find 'select'

    do multiSelectField.multiselect
        # onChange: (option, isChecked, el) =>
        #   selectedCompetitorsCount += if isChecked then 1 else -1
        #   # If the selected number of competitors is greater than the required
        #   # minimum, then enable the submit button.
        #   if selectedCompetitorsCount >= COMPETITOR_MIN
        #     submitButton.attr "disabled", false
        #     submitButton.disabled = false
        #   else
        #     submitButton.attr "disabled", true
        #     submitButton.disabled = true

    submitButton.click (event) =>
      do event.preventDefault
      if false not in (@validate obj for obj in @form.find '.form-control')
        console.log 'Everything is okay'

    @validate = (field) ->
        retVal = true

        if field.value is ''
          retVal = false
        else
          if field.type is 'email'
            pattern = ///[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?///

            if not field.value.match pattern
              retVal = false
        retVal

ready = ->
  clientData = JSON.parse ($ 'script#client-data'
  .html())

  if 'competitions' is clientData.controller
    competition = new Competition $ 'form'

$(document).ready(ready)
$(document).on('page:load', ready)
