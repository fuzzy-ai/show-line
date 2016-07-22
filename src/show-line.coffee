# show-line.coffee
# Shows a line or two of HTML.

http = require 'http'
https = require 'https'

config =
  address: process.env['ADDRESS'] or "0.0.0.0"
  port: process.env['PORT'] or 80
  key: process.env['KEY']
  cert: process.env['CERT']
  title: process.env['TITLE'] or "Show line"
  line: process.env['LINE'] or "This is the line."

body = """
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>#{config.title}</title>
  </head>
  <body>
  <h1>#{config.title}</h1>
  <p>#{config.line}</p>
  </body>
</html>
"""

bodyLength = Buffer.byteLength body

handler = (req, res, next) ->

  res.writeHead 200,
    'Content-Length': bodyLength
    'Content-Type': 'text/html'

  res.write body
  res.end()

if config.key?
  server = https.createServer {key: config.key, cert: config.cert}, handler
else
  server = http.createServer handler

server.on 'error', (err) ->
  console.error err
  process.exit 1

server.listen config.port, config.address, ->
  console.log "Listening on port #{config.port}"
