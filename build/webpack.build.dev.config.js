var webpack = require('webpack')
var banner = require('./banner')

module.exports = {
  entry: './lib/index.js',
  output: {
    path: './dist',
    filename: 'vue-model-validator.js',
    library: 'VueModelValidator',
    libraryTarget: 'umd'
  },
  plugins: [
    new webpack.BannerPlugin(banner)
  ]
}
