### Function to set the aspect ratio upon button press ###
setAspectRatio = (getRatio) ->
    ratio     = $(getRatio).text()
    setWidth  = 0
    setHeight = 0
    switch ratio
        when '16 : 9'
            setWidth  = 1920
            setHeight = 1080
        when '21 : 9'
            setWidth  = 2560
            setHeight = 1080
        when '4 : 3'
            setWidth  = 1024
            setHeight = 768
        when '2 : 1'
            setWidth  = 1024
            setHeight = 512
    $('#w1').val setWidth
    $('#h1').val setHeight
    $('#aspect-ratio-suggestion').text ratio

### Function that calculates the aspect ratio ###
calculateAspectRatio = (w2, h2, w1, h1) ->
    value = undefined
    if 'undefined' != typeof w2
        value = Math.round(w2 / (w1 / h1))
    else if 'undefined' != typeof h2
        value = Math.round(h2 * w1 / h1)
    value

### Function to reduce to smallest, integer ratio using Euclid's Algorithm ###
calculateReducedRatio = (numerator, denominator) ->
    gcd     = undefined
    temp    = undefined
    divisor = undefined

    gcd = (a, b) ->
        if b == 0
            return a
        gcd b, a % b

    # take care of some simple cases
    if !isInteger(numerator) or !isInteger(denominator)
        return ''
    if numerator == denominator
        return '1 : 1'
    # make sure numerator is always the larger number
    if +numerator < +denominator
        temp        = numerator
        numerator   = denominator
        denominator = temp
    divisor = gcd(+numerator, +denominator)
    if 'undefined' == typeof temp then numerator / divisor + ' : ' + denominator / divisor else denominator / divisor + ' : ' + numerator / divisor

### Function for onkeyup action ###
keyupEvent = (event) ->
    w1 = $('#values-wrapper input[name=w1]')
    h1 = $('#values-wrapper input[name=h1]')
    w2 = $('#values-wrapper input[name=w2]')
    h2 = $('#values-wrapper input[name=h2]')

    w1v = w1.val()
    h1v = h1.val()
    w2v = w2.val()
    h2v = h2.val()

    ratio = calculateReducedRatio(w1v, h1v)
    $('#aspect-ratio-suggestion').text ratio

    switch event.target
        when w1[0]
            if !isInteger(w1v) or !isInteger(h1v) or !isInteger(h2v)
                return
            w2.val calculateAspectRatio(undefined, h2v, w1v, h1v)
        when h1[0]
            if !isInteger(h1v) or !isInteger(w1v) or !isInteger(w2v)
                return
            h2.val calculateAspectRatio(w2v, undefined, w1v, h1v)
        when w2[0]
            if !isInteger(w2v) or !isInteger(w1v) or !isInteger(h1v)
                return
            h2.val calculateAspectRatio(w2v, undefined, w1v, h1v)
        when h2[0]
            if !isInteger(h2v) or !isInteger(w1v) or !isInteger(h1v)
                return
            w2.val calculateAspectRatio(undefined, h2v, w1v, h1v)