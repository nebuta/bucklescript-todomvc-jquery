var webpack = require('webpack');

module.exports = {
  entry: __dirname + "/js/main.js",
  output: {
    path: __dirname + '/dist',
    filename: 'bundle.js'
  },
  plugins: [
          new webpack.optimize.UglifyJsPlugin()
	],
	externals: {
	    "jquery": "jQuery"
	}
};