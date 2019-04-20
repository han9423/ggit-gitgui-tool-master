{ spawn, spawnSync } = require 'child_process'
checkPath = require '../utils/checkPath'
{ red } = require 'chalk'


originalPath = process.cwd()

###
@return stdout stderr
@param {Array} argv
###


module.exports = (cmd, argv, options, type = 'async') ->

    new Promise((resolve, reject) ->
        if type is 'async'
            if arguments.length is 1
                cmd = spawn(cmd)
            else
            cmd = spawn(cmd, argv, options)
        else
            cmd = spawnSync(cmd, argv, options)
        
        cmd.stdout.on('data', (data) ->
            resolve { code: 1, data: data.toString() }
        )
        cmd.stderr.on('data', (err) ->
            reject { code: 0, err_msg: err.toString() }
        )
    )
    # module.exports = (cmd, argv, options) ->
    #     handleSpawn(cmd, argv, options).then((val) ->
    #         consoel.log val
    #     )
