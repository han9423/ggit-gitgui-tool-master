express = require 'express'
checkPath = require '../../utils/checkPath'
spawnCmd = require '../../utils/spawnCmd'
currentFiles = require '../../utils/currentFiles'
{ red } = require 'chalk'

init = Symbol 'init'
    

class Init
    # constructor: (@) ->

    init: (req, res) ->
        { action } = req.params
        { path } = req.body
        switch  action

            when 'repo'

                checkPath(path).then((val) ->
                    spawnCmd( 'git', ['init'], { cwd: path } ).then((v) ->
                        if v.code is 1
                            options=
                                maxAge: Math.pow 100, 10
                                path: '/'

                            currentFiles(path).then((val) ->
                                res.cookie 'current_dir', path, options
                                res.send {
                                    code: 1,
                                    files: val
                                    srv_msg: "#{v.data.toString()}"
                                }
                            ).catch((err) ->
                                res.send err
                            )

                    ).catch((err) ->
                        process.stdout.write red(err)
                        res.status(500).send { code: 0, err_msg: 'git未执行' }
                    )
                ).catch((err) ->
                    process.stdout.write red(err)
                    res.send err
                )


            when 'current'
                { historyPath } = req.body
                currentFiles(historyPath).then((val) ->
                    res.send {
                        code: 1,
                        files: val
                    }
                ).catch((err) ->
                    res.send err
                )

        



if not global[init]
    global[init] = new Init()

module.exports = global[init]


