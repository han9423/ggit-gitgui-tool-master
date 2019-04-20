spawnCmd = require '../../utils/spawnCmd'
{ exec }  = require 'child_process'
{ red } = require 'chalk'
operator = Symbol 'operator'

class Operator
    constructor: ->
        @addTemp = @addTemp.bind @

    addTemp: (req, res) ->
        base_path = req.headers['cookie'].replace('current_dir=', '')
        tempDirs = req.body['tempdirs[]'] or req.body['tempdirs']
        addToTemp = if tempDirs is 'all' then '.' else "#{tempDirs}".replace /,/g, ' '


        if addToTemp is 'undefined'
            res.send { code: 1, srv_msg: "没有文件被添加至暂存区" }
        else
            exec("git add #{addToTemp}", { cwd: decodeURIComponent base_path }, (err, stdout1, stdin1) ->
                if err
                    console.log red(err)
                    if /Not a git repository/gi.test err.toString()
                        res.send { code: 0, err_msg: '没有.git 请先初始化' }
                else
                    res.send { code: 1, srv_msg: if stdout1 is '' then '暂存区添加成功' else stdout1 }
            )
    addCommit: (req, res) ->
        { data } = req.body
        base_path = req.headers['cookie'].replace('current_dir=', '')
        spawnCmd('git', ['commit', '-m', "'#{data}'"], { cwd: decodeURIComponent base_path }).then((val) ->
            if /干净的工作区/.test val.data
                res.send { code: 1, srv_msg: val.data }
            else
                res.send { code: 1, srv_msg: '创建成功' }
        ).catch((err) ->
            console.log red(err)
            res.send err
        )
    addRemote: (req, res) ->
        base_path = req.headers['cookie'].replace('current_dir=', '')
        { remoteGit } = req.body
        spawnCmd('git', ['remote', 'add', 'origin', remoteGit], { cwd: base_path }).then((rval) ->
            res.send { code: 1, err_msg }
        ).catch((rerr) ->
            res.send rerr
        )
    
if not global[operator]
    global[operator] =  new Operator()

module.exports = global[operator]




