{ platform } = require 'os'
{ exec } = require 'child_process'
url = 'http://localhost'

module.exports = (port) ->
    console.log platform()
    switch platform()
        when 'linux'
        then terminal = 'xdg-open'
        when 'win32'
        then terminal = 'start'
        when 'darwin'
        then terminal = 'open'
        else return 'not support this platform'
    exec("#{terminal} #{url}:#{port}")
