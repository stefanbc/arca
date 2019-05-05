export default class Arca {

    setAspectRatio = function(getRatio) {
    var height, ratio, ratioArray, resolution, width;
    ratio = $(getRatio).text();
    width = height = 0;
    ratioArray = {
        '16 : 9': '1920,1080',
        '21 : 9': '2560,1080',
        '4 : 3': '1024,768',
        '2 : 1': '1024,512'
    }

    resolution = ratioArray[ratio].split(',');
    width = resolution[0];
    height = resolution[1];
    $('#w1').val(width);
    $('#h1').val(height);
    $('#w2').val('');
    $('#h2').val('');
    return $('#aspect-ratio-suggestion').text(ratio);
    }

    calculateAspectRatio = function(w2, h2, w1, h1) {
    var value;
    if ('undefined' !== typeof w2) {
        value = Math.round(w2 / (w1 / h1));
    } else if ('undefined' !== typeof h2) {
        value = Math.round(h2 * w1 / h1);
    }
    return value;
    }

    calculateReducedRatio = function(width, height) {
    var divisor, gcd, temp;
    gcd = function(a, b) {
        if (b === 0) {
        return a;
        }
        return gcd(b, a % b);
    }
    if (!isInteger(width) || !isInteger(height)) {
        return '';
    }
    if (width === height) {
        return '1 : 1';
    }
    if (+width < +height) {
        temp = width;
        width = height;
        height = temp;
    }
    divisor = gcd(+width, +height);
    if ('undefined' === typeof temp) {
        return width / divisor + ' : ' + height / divisor;
    } else {
        return height / divisor + ' : ' + width / divisor;
    }
    }

    keyupEvent = function(event) {
    var h1, h1v, h2, h2v, ratio, w1, w1v, w2, w2v;
    w1 = $('#w1');
    h1 = $('#h1');
    w2 = $('#w2');
    h2 = $('#h2');
    w1v = w1.val();
    h1v = h1.val();
    w2v = w2.val();
    h2v = h2.val();
    ratio = calculateReducedRatio(w1v, h1v);
    $('#aspect-ratio-suggestion').text(ratio);
    switch (event.target) {
        case w1[0]:
        if (!isInteger(w1v) || !isInteger(h1v) || !isInteger(h2v)) {
            return;
        }
        return w2.val(calculateAspectRatio(void 0, h2v, w1v, h1v));
        case h1[0]:
        if (!isInteger(h1v) || !isInteger(w1v) || !isInteger(w2v)) {
            return;
        }
        return h2.val(calculateAspectRatio(w2v, void 0, w1v, h1v));
        case w2[0]:
        if (!isInteger(w2v) || !isInteger(w1v) || !isInteger(h1v)) {
            return;
        }
        return h2.val(calculateAspectRatio(w2v, void 0, w1v, h1v));
        case h2[0]:
        if (!isInteger(h2v) || !isInteger(w1v) || !isInteger(h1v)) {
            return;
        }
        return w2.val(calculateAspectRatio(void 0, h2v, w1v, h1v));
    }
    }

};

const run = new Arca();