requirejs.config({
    baseUrl: 'bin/js',
    paths: {
        jQuery      : 'http://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min',
        humane      : 'http://cdnjs.cloudflare.com/ajax/libs/humane-js/3.2.2/humane.min',
        app         : 'app.min'
    },
    shim: {
        'app'       : {
            deps    : ['jQuery', 'humane']
        }
    }
});