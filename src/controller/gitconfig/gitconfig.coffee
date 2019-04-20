os = require 'os'
fs = require 'fs'
{ red } = require 'chalk'
{ resolve } = require 'path'
{ exec } = require 'child_process'
spawnCmd = require '../../utils/spawnCmd'
configCoffee = Symbol 'configCoffee'
sh_path = process.cwd() + '/keygen.sh'

###
@module config
###



class Config
    constructor: () ->
        # @_readKeygen = @readKeygen.bind @
        console.log process.cwd()
        @getKey = @getKey.bind @

    _readKeygen: ->
        switch process.platform
            when 'linux'
                sshDir = resolve(os.homedir(), '.ssh')
            when  'win32'
                sshDir = resolve(os.homedir(), '.ssh')

        new Promise((resolve, reject) ->
            fs.access(sshDir + '/id_rsa.pub', fs.constants.F_OK, (err1) ->
                if err1
                   exec("git config --global user.email", (stderr, stdout, stdin) ->
                        shell = """ssh-keygen -t rsa -C #{stdout}<< EOF
                                    $HOME/.ssh/id_rsa
                                    y
                                    EOF"""
                        fs.writeFile(sh_path, shell, { mode: 0o777 }, (err2) ->
                            if err2
                                reject { code: 0,  err_msg: err2 }
                            spawnCmd(sh_path).then( ->
                                setTimeout (->
                                    fs.readFile(sshDir + '/id_rsa.pub', { encoding: 'utf-8' },
                                    (err3, val2) ->
                                        if err3
                                            reject { code: 0, err_msg: err3 }
                                        resolve { code: 1, srv_msg: val2 }
                                    )
                                ), 200
                            ).catch((err) ->
                                console.log err
                                reject { code: 0, err_msg: 'ssh-keygen 生成错误' }
                            )
                        )
                   )
                else
                    fs.readFile(sshDir + '/id_rsa.pub', { encoding: 'utf-8' }, (err5, val1) ->
                            if err5
                                reject { code: 0, err_msg: err5 }
                            resolve { code: 1, srv_msg: val1 }
                        )
            )
        )


    # intiConfig

    initConfig: (req, res) ->
        { url } = req if req?
        spawnCmd('git', ['config', '--list']).then((obj) ->
            username = /user\.name/gi.test obj.data
            email = /user\.email/gi.test obj.data
            if username and email
                res.send { code: 1, srv_msg: '已初始化', data_msg: obj.data }
            else
                res.send { code: 0, srv_msg: '未初始化请先选择  $git全局设置$' }
        ).catch((err) ->
            console.log err
        )

    configUser: (req, res) ->
        { body, url } = req if req?
        { username, email } = body
        exec("git config --global user.name #{username}", (err, stdout1, stdin) ->
            if err
                console.log red(err)
            else
                exec("git config --global user.email #{email}", (err, stdout2, stdin) ->
                    if err
                        console.log red(err)
                    else
                        res.send { code: 1, srv_msg: 'git初始配置成功' }
                )
        )
    getKey: (req, res) ->
        { url } = req if req?
        @_readKeygen().then((val) ->
            res.send val
            res.end()
        ).catch((err) ->
            console.log red(err.err_msg)
            res.send err
            res.end()
        )

# unique module
if not global[configCoffee]
    global[configCoffee] = new Config()

module.exports = global[configCoffee]