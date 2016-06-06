### Check if variable is number ###
isNumber = (obj) ->
    !isNaN(parseFloat(obj))

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

### Show a notice upon request ###
notice = (text) ->
    humane.log text,
        timeout : 5000
        baseCls : 'humane-libnotify'
         
### Change views ###
changeView = (button, oldView, newView) ->
    resetView = $(button).attr 'data-view'
    if resetView
        $(newView).fadeOut ->
            $(resetView).fadeIn ->
                $(button).attr 'data-view', ''
    else
        $(oldView).fadeOut ->
            $(newView).fadeIn ->
                $(button).attr 'data-view', "#{oldView}"

### Change button icon ###
changeIcon = (element, removedClass, addedClass) ->
    $(element).removeClass(removedClass).addClass(addedClass)