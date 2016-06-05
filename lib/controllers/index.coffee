### When the page finishes loading ###
$ ->
    $('#info-button').on 'click', ->
        changeIcon this, 'fa-question', 'fa-arrow-left'
        changeView this, '#info-wrapper'