'use strict'; 

require('dotenv').config(); 

const restify = require('restify');
const compression = require('compression');
const server = restify.createServer();
server.use(restify.plugins.bodyParser());
server.use(compression());

server.get('/public/*/*.*', restify.plugins.serveStatic({
    directory: __dirname
}));

server.get('/sencha/*', restify.plugins.serveStatic({
    directory: __dirname,
    default: 'index.html'
}));

server.get('/sencha', (req, res, next) => {
    res.redirect('/sencha/', next)
});
server.get('/', (req, res, next) => {
    res.redirect('/sencha/', next)
});
server.get('/*', (req, res, next) => {
    res.redirect('/sencha/', next)
});

server.listen(process.env.PORT);