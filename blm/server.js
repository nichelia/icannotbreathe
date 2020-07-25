const express = require('express');
const app = express();

app.use(express.static('dist/blm'));
app.get('/', (req, res) => {
    res.redirect('/');
});
app.all('/*', (req, res) => {
    res.sendFile('dist/blm/index.html', { root: __dirname });
});

app.listen(8080)
