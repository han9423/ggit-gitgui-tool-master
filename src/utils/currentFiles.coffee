fs = require 'fs'
{ red } = require 'chalk'
original = process.cwd()

# fileDir = (name) ->
    # fs.stat(name)

module.exports = ( path ) ->

    new Promise( (resolve, reject) ->
        fs.readdir( path, (err, dir) ->
            if err
                process.chdir original
                reject { code: 0, err_msg: "#{path}目录读取错误" }
            else
                process.chdir original
                resolve dir
        )
    )
