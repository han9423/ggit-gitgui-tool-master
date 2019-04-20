require('source-map-support').install()
https = require 'https'
http = require 'http'
fs = require 'fs'
opBrowser = require '../utils/opBrowser'
{ red , green, blue } = require 'chalk'
app = require '../app'

srv = http.createServer app

###
@param {Object} server
###


handle_inuse = ->
    console.log red 'port 1031 in use, change 5s later...'
    setTimeout (->
        srv.listen(1033, 'localhost', ->
            console.log blue 'port change to 1033'
            opBrowser 1033
        )
    ), 5000

srv.on('error', (err) ->
    switch err.code
        when 'EADDRINUSE'
        then  handle_inuse()

        when 'ACCESS'
        then console.log red 'no access'
)



srv.listen(1031, 'localhost', () ->
    address = srv.address() if srv?
    console.log green("App running on #{address.address} #{address.port}")
    console.log '3s 后跳转到浏览器...'
    setTimeout(->
        opBrowser address.port
    , 3000)
)
 













