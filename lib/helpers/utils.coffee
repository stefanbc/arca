### Check if variable is number ###
isNumber = (obj) ->
    !isNaN(parseFloat(obj))

### Check if a value is a positive number ###
isInteger = (value) ->
    /^[0-9]+$/.test  value

### Check if variable is empty ###
empty = (data) ->
    if typeof data is 'number' or typeof data is 'boolean'
        return false
    if typeof data is 'undefined' or data is null
        return true
    if typeof data.length isnt 'undefined'
        return data.length == 0
    count = 0
    for i of data
        if data.hasOwnProperty(i)
            count++
    count == 0

### Animate element ###
animateElement = (element) ->
  $(element).addClass 'animated pulse'
  $(element).on 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
    $(this).removeClass 'animated pulse'

### Change views ###
changeView = (button, oldView, newView) ->
    animateElement button
    resetView = $(button).attr 'data-view'
    if resetView
        $(newView).fadeOut '200', ->
            $(resetView).fadeIn '200', ->
                $(button).attr 'data-view', ''
    else
        $(oldView).fadeOut '200', ->
            $(newView).fadeIn '200', ->
                $(button).attr 'data-view', oldView

resetValues = (button, inputs, ratio_suggestion) ->
    $(button).addClass 'fa-spin'
    $(inputs).val ''
    $(ratio_suggestion).text ''
    setInterval (->
        $(button).removeClass 'fa-spin'
        return
    ), 1000

### Change button icon ###
changeIcon = (element, removedClass, addedClass) ->
    $(element).removeClass(removedClass).addClass(addedClass)