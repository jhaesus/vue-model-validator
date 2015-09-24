# Karma configuration
# Generated on Wed Sep 23 2015 14:25:40 GMT+0300 (EEST)

module.exports = (config) ->
  config.set

    # base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '..'


    # frameworks to use
    # available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['jasmine', 'requirejs']

    coffeePreprocessor:
      options:
        bare: true
        sourceMap: false

    # list of files / patterns to load in the browser
    files: [
      JASMINE
      JASMINE_ADAPTER
      REQUIRE
      REQUIRE_ADAPTER
      'spec/karma.server.coffee'
      {pattern: 'dist/vue-model-validator.js', included: true}
      {pattern: 'node_modules/vue/dist/vue.js', included: true}
      {pattern: 'spec/specs/**/*.spec.coffee', included: true}
    ]


    # list of files to exclude
    exclude: [
    ]


    # preprocess matching files before serving them to the browser
    # available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors:
      '**/*.coffee': ['coffee']
      '!(node_modules)/**/*.js': ['commonjs']

    # test results reporter to use
    # possible values: 'dots', 'progress'
    # available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['dots']


    # web server port
    port: 9876


    # enable / disable colors in the output (reporters and logs)
    colors: true


    # level of logging
    # possible values:
    # - config.LOG_DISABLE
    # - config.LOG_ERROR
    # - config.LOG_WARN
    # - config.LOG_INFO
    # - config.LOG_DEBUG
    logLevel: config.LOG_INFO


    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: false


    # start these browsers
    # available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['PhantomJS', 'Chrome', 'Safari', 'Firefox', 'Opera']


    # Continuous Integration mode
    # if true, Karma captures browsers, runs the tests and exits
    singleRun: false
