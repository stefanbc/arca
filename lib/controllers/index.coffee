### When the page finishes loading ###
$ ->
    $('#info-button').on 'click', ->
        changeView this, '#calculator-wrapper', '#info-wrapper'