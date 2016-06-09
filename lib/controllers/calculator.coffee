### Function to set the aspect ratio upon button press ###
setAspectRatio = (getRatio) ->
    ratio = $(getRatio).text()
    width = height = 0

    ratioArray = { 
        '16 : 9' : '1920,1080',
        '21 : 9' : '2560,1080',
        '4 : 3'  : '1024,768',
        '2 : 1'  : '1024,512'  
    }
    resolution = ratioArray[ratio].split ','
    width  = resolution[0]
    height = resolution[1]

    $('#w1').val width
    $('#h1').val height
    $('#aspect-ratio-suggestion').text ratio

### Function that calculates the aspect ratio ###
calculateAspectRatio = (w2, h2, w1, h1) ->
    if 'undefined' != typeof w2
        value = Math.round(w2 / (w1 / h1))
    else if 'undefined' != typeof h2
        value = Math.round(h2 * w1 / h1)
    value

### Function to reduce to smallest, integer ratio using Euclid's Algorithm ###
calculateReducedRatio = (width, height) ->
    gcd = (a, b) ->
        if b == 0
            return a
        gcd b, a % b

    if !isInteger(width) or !isInteger(height)
        return ''
    if width == height
        return '1 : 1'
    if +width < +height
        temp   = width
        width  = height
        height = temp

    divisor = gcd(+width, +height)
    if 'undefined' == typeof temp then width / divisor + ' : ' + height / divisor else height / divisor + ' : ' + width / divisor

### Function for onkeyup action ###
keyupEvent = (event) ->
    w1 = $('#w1')
    h1 = $('#h1')
    w2 = $('#w2')
    h2 = $('#h2')

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