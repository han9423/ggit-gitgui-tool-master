{ isAbsolute } = require 'path'
originalPath = process.cwd()


module.exports = (path) ->
    new Promise((resolve, reject) ->
        if isAbsolute(path)
            try
                process.chdir path
            catch error
                reject { code: 0, err_msg: "#{path} 没有这个路径" }
            
            resolve { code: 1 }
        else
            reject { code: 0, err_msg: "#{path} 不是绝对路径" }
    )