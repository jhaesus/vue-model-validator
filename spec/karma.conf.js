module.exports = function (config) {
  config.set({
    port: 9876,
    basePath: '..',
    frameworks: ['mocha', 'expect', 'commonjs'],

    files: [
      'node_modules/vue/dist/vue.js',
      'src/**/*.coffee',
      'spec/shared.coffee',
      'spec/specs/**/*.coffee'
    ],
    exclude: [],

    preprocessors: {
      'node_modules/vue/dist/vue.js': ['commonjs'],
      'spec/shared.coffee': ['coffee', 'commonjs'],
      'src/**/*.coffee': ['coffee', 'coverage', 'commonjs'],
      'spec/specs/**/*.coffee': ['coffee', 'commonjs']
    },
    coffeePreprocessor: {
      options: {
        bare: true,
        sourceMap: false
      }
    },

    colors: true,
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,

    autoWatch: false,
    singleRun: false,

    reporters: ['progress', 'coverage'],
    coverageReporter: {
      type: 'lcov',
      dir: 'coverage/'
    },

    browsers: ['PhantomJS']
  })
}
