var webpack = require('webpack');

module.exports = {
    entry: {
        app: './web/src/app.js'
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
        }],
        noParse: [/\.elm$/]
    }
};
