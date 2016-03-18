var webpack = require('webpack');
var ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = {
    entry: {
        app: './web/src/app.js',
        style: './web/style.css'
    },
    output: {
        path: './web/build',
        filename: '[name].js'
    },
    module: {
        loaders: [{
            test: /\.elm$/,
            exclude: [/elm-stuff/, /node_modules/],
            loader: 'elm-webpack'
        }, {
            test: /\.css$/,
            loader: ExtractTextPlugin.extract("style-loader", "css-loader")
        }],
        noParse: [/\.elm$/]
    },
    plugins: [
        new ExtractTextPlugin("style.css")
    ]
};
