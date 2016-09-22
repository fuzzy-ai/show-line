// show-line.coffee
// Shows a line or two of HTML.

import http from 'http';
import https from 'https';

let config = {
  address: process.env['ADDRESS'] || "0.0.0.0",
  port: process.env['PORT'] || 80,
  key: process.env['KEY'],
  cert: process.env['CERT'],
  title: process.env['TITLE'] || "Show line",
  line: process.env['LINE'] || "This is the line."
};

let body = `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>${config.title}</title>
  </head>
  <body>
  <h1>${config.title}</h1>
  <p>${config.line}</p>
  </body>
</html>`;

let bodyLength = Buffer.byteLength(body);

let handler = function(req, res, next) {

  res.writeHead(200, {
    'Content-Length': bodyLength,
    'Content-Type': 'text/html'
  }
  );

  res.write(body);
  return res.end();
};

if (config.key != null) {
  var server = https.createServer({key: config.key, cert: config.cert}, handler);
} else {
  var server = http.createServer(handler);
}

server.on('error', function(err) {
  console.error(err);
  return process.exit(1);
}
);

server.listen(config.port, config.address, () => console.log(`Listening on port ${config.port}`)
);
