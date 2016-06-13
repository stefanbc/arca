### When the page finishes loading ###
$ ->
    $('#info-button').on 'click', ->
        changeView this, '#calculator-wrapper', '#info-wrapper'
    $('.aspect-ratio-button button').on 'click', ->
        setAspectRatio this
    $('#values-wrapper input').keyup keyupEvent
    $('#reset-button span').on 'click', ->
        resetValues this, '#values-wrapper input', '#aspect-ratio-suggestion'