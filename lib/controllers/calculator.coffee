do ->
  selectors = undefined
  lastTarget = undefined

  round = ->
    $('input[name=round]:checked').length == 1

  reset = ->
    lastTarget = undefined
    setRatio 1920, 1080
    return

  setRatio = (x1, y1) ->
    # ratios
    $('#arc input[name=x1]').val x1
    $('#arc input[name=y1]').val y1
    $('#arc input[name=x2]').val ''
    $('#arc input[name=y2]').val ''
    onKeyup {}
    return

  ###*
  # Reduce a numerator and denominator to it's smallest, integer ratio using Euclid's Algorithm
  ###

  reduceRatio = (numerator, denominator) ->
    gcd = undefined
    temp = undefined
    divisor = undefined
    # from: http://pages.pacificcoast.net/~cazelais/euclid.html

    gcd = (a, b) ->
      if b == 0
        return a
      gcd b, a % b

    # take care of some simple cases
    if !isInteger(numerator) or !isInteger(denominator)
      return '? : ?'
    if numerator == denominator
      return '1 : 1'
    # make sure numerator is always the larger number
    if +numerator < +denominator
      temp = numerator
      numerator = denominator
      denominator = temp
    divisor = gcd(+numerator, +denominator)
    if 'undefined' == typeof temp then numerator / divisor + ' : ' + denominator / divisor else denominator / divisor + ' : ' + numerator / divisor

  ratio2css = (numerator, denominator) ->
    width = undefined
    height = undefined
    if +numerator > +denominator
      width = 200
      height = solve(width, undefined, numerator, denominator)
    else
      height = 200
      width = solve(undefined, height, numerator, denominator)
    {
      width: width + 'px'
      height: height + 'px'
      lineHeight: height + 'px'
    }

  ###*
  # Determine whether a value is a positive integer (i.e. only numbers)
  ###

  isInteger = (value) ->
    /^[0-9]+$/.test value

  ###*
  # Solve for the 4th value
  # @param int num2 Numerator from the right side of the equation
  # @param int den2 Denominator from the right side of the equation
  # @param int num1 Numerator from the left side of the equation
  # @param int den1 Denominator from the left side of the equation
  # @return int
  ###

  solve = (width, height, numerator, denominator) ->
    value = undefined
    # solve for width
    if 'undefined' != typeof width
      value = if round() then Math.round(width / (numerator / denominator)) else width / (numerator / denominator)
    else if 'undefined' != typeof height
      value = if round() then Math.round(height * numerator / denominator) else height * numerator / denominator
    value

  ###*
  # Handle a keyup event
  ###

  onKeyup = (evt) ->
    x1 = undefined
    y1 = undefined
    x2 = undefined
    y2 = undefined
    x1v = undefined
    y1v = undefined
    x2v = undefined
    y2v = undefined
    ratio = undefined
    lastTarget = evt.target
    x1 = $('#arc input[name=x1]')
    y1 = $('#arc input[name=y1]')
    x2 = $('#arc input[name=x2]')
    y2 = $('#arc input[name=y2]')
    x1v = x1.val()
    y1v = y1.val()
    x2v = x2.val()
    y2v = y2.val()
    # display new ratio
    ratio = reduceRatio(x1v, y1v)
    $('#ratio').html ratio
    $('#visual-ratio').css ratio2css(x1v, y1v)
    resizeSample()
    switch evt.target
      when x1[0]
        if !isInteger(x1v) or !isInteger(y1v) or !isInteger(y2v)
          return
        x2.val solve(undefined, y2v, x1v, y1v)
        fadeIt x2
      when y1[0]
        if !isInteger(y1v) or !isInteger(x1v) or !isInteger(x2v)
          return
        y2.val solve(x2v, undefined, x1v, y1v)
        fadeIt y2
      when x2[0]
        if !isInteger(x2v) or !isInteger(x1v) or !isInteger(y1v)
          return
        y2.val solve(x2v, undefined, x1v, y1v)
        fadeIt y2
      when y2[0]
        if !isInteger(y2v) or !isInteger(x1v) or !isInteger(y1v)
          return
        x2.val solve(undefined, y2v, x1v, y1v)
        fadeIt x2
    return

  hideSample = ->
    $('#visual-ratio').html('Example').css backgroundImage: 'none'
    return

  showSample = ->
    img = undefined
    img = document.createElement('IMG')
    img.src = $('input[name=sample-url]').val()
    img.onload = resizeSample
    $('#visual-ratio').html('').append img
    return

  resizeSample = ->
    img = undefined
    imgRatio = undefined
    width = undefined
    height = undefined
    boxRatio = undefined
    imgW = undefined
    imgH = undefined
    css = undefined

    cropToWidth = ->
      img.css
        width: width + 'px'
        height: 'auto'
      img.css
        top: 0 - Math.round((img.height() - height) / 2) + 'px'
        left: 0
      return

    cropToHeight = ->
      img.css
        width: 'auto'
        height: height + 'px'
      img.css
        top: 0
        left: 0 - Math.round((img.width() - width) / 2) + 'px'
      return

    boxToWidth = ->
      img.css
        width: width + 'px'
        height: 'auto'
      img.css
        top: Math.round((height - img.height()) / 2) + 'px'
        left: 0
      return

    boxToHeight = ->
      img.css
        width: 'auto'
        height: height + 'px'
      img.css
        top: 0
        left: Math.round((width - img.width()) / 2) + 'px'
      return

    if 0 == $('input[name=sample-display]:checked').length
      return
    img = $('#visual-ratio img')
    imgRatio = img.width() / img.height()
    width = $('#visual-ratio').width()
    height = $('#visual-ratio').height()
    boxRatio = width / height
    if 'crop' == $(selectors.crop).val()
      if imgRatio > boxRatio
        cropToHeight()
      else
        cropToWidth()
    else
      # box
      if imgRatio > boxRatio
        boxToWidth()
      else
        boxToHeight()
    return

  selectors =
    crops: 'input[name=crop]'
    crop: 'input[name=crop]:checked'
  # END: onKeyup
  $('#arc input').keyup onKeyup
  # recalculate when the user changes the rounding
  $('input[name=round]:checked').click (evt) ->
    onKeyup target: lastTarget
    return
  # reset values
  $('a.reset').click (evt) ->
    evt.preventDefault()
    reset()
    return
  # show sample
  $('input[name=sample-display]').click (evt) ->
    if true == @checked
      $('#croptions').show()
      showSample()
    else
      $('#croptions').hide()
      hideSample()
    return
  $(selectors.crops).click (evt) ->
    resizeSample()
    return
  $('input[name=sample-url]').keyup (evt) ->
    hideSample()
    showSample()
    return
  $('#ratios').change (evt) ->
    vals = $(this).val().split('x')
    setRatio vals[0], vals[1]
    return
  # hit the function to get things in the right state
  onKeyup {}
  return
# fix google ads display
document.getElementById('aswift_0_expand').style.position = 'absolute'