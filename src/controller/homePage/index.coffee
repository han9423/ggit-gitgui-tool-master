{ exec } = require 'child_process'
{ red } = require 'chalk'
spawnCmd = require '../../utils/spawnCmd'


module.exports = (req, res) ->
    { url } = req if req?
    spawnCmd('git').then( (val) ->
        res.render('index.pug', { index: 'dasdsa' })
        ).catch((err) ->
            console.log(err)
            if err
                res.render('no-git.pug')
    )
    
