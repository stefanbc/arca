### Function to set the aspect ratio upon button press ###
setAspectRatio = (getRatio) ->
    ratio     = $(getRatio).text()
    setWidth  = 0
    setHeight = 0
    switch ratio
        when '16:9'
            setWidth  = 1920
            setHeight = 1080
        when '21:9'
            setWidth  = 2560
            setHeight = 1080
        when '4:3'
            setWidth  = 1024
            setHeight = 768
        when '2:1'
            setWidth  = 1024
            setHeight = 512
    $('#w1').val setWidth
    $('#h1').val setHeight
    $('#aspect-ratio-suggestion').text ratio

### Function that calculates the aspect ratio ###
calculateAspectRatio = (w1, h1, w2, h2) ->
    value = undefined
    # solve for width
    if 'undefined' != typeof width
        value = if round() then Math.round(width / (numerator / denominator)) else width / (numerator / denominator)
    else if 'undefined' != typeof height
        value = if round() then Math.round(height * numerator / denominator) else height * numerator / denominator
    value
