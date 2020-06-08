var express = require('express');
var app = express();

app.use(express.static('dist/blm'));
app.get('/', function (req, res,next) {
    res.redirect('/');
});
app.all('/*', function(req, res, next) {
    res.sendFile('dist/blm/index.html', { root: __dirname });
});

app.listen(8080)
