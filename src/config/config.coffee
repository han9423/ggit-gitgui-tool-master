express = require 'express'
consolidate = require 'consolidate'
{ resolve } = require 'path'
index = require '../routes/index'


class Config

    setEngine: (app) ->
        app.set('view engine', 'html')
        app.set('views', 'views')
        app.engine('html', consolidate.pug)

    setStaticPath: (app) ->
        staticPath = resolve(process.cwd(), './public')
        app.use(express.static(staticPath))

    setPostData: (app) ->
        app.use(express.json())
        app.use(express.urlencoded({
            extended: false,
            limit: 6 * 1024 ** 2
        }))
    setOpenIndex: (app) ->
        app.use(index)
    
module.exports = new Config()



