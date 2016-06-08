requirejs.config({
    baseUrl: 'js',
    paths: {
        jQuery      : '//ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min',
        app         : 'app.min'
    },
    shim: {
        'app'       : {
            deps    : ['jQuery']
        }
    }
});