checkPath = require '../../utils/checkPath'
readline = require 'readline'
{ exec } = require 'child_process'
{ red } = require 'chalk'


# check uri
checkUri = (uri) ->
    base_check =  ///
                        ^((ht|f)tps?):
                        \/\/([\w\-]+
                        (\.[\w\-]+)*\/)*
                        [\w\-]+(\.[\w\-]+)*
                        \/?(\?([\w\-\.,@?^=%&:\/~\+#]*
                        )+)?
                        ///
    base_check.test uri

module.exports = (req, res) ->
    { uri, localpath } = req.body
    if checkUri
        checkPath(localpath).then(() ->
            exec("git clone #{uri}", { cwd: localpath }, (err, stdout, stdin) ->
                console.log  stdin.toString()
                if err
                    process.stdout.write red(err)
                    res.send { code: 0, err_msg: err.toString() }
                    res.end()
                else
                    res.send { code: 1, srv_msg: stdin.toString() }
                    res.end()
            )
        ).catch((err) ->
            ###
                {code:0, err_msg:没有这个目录}
            ###
            res.send err
        )
    else
        res.send { code: 0, err_msg: 'uri地址格式不正确' }




