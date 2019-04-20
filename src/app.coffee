###
@author sewerganger <wanghan9423@outlook.com>
@copyright random
@version 0.01
@license MIT
@description  build a git gui tool on broswer
###

express = require 'express'
{ setStaticPath, setPostData, setOpenIndex } = require './config/config'

app = express()

setStaticPath app
setPostData app
setOpenIndex app

module.exports = app


