express = require 'express'
{ init, currentFile } = require '../controller/init/init'
clone = require '../controller/clone/clone'
configRouter = require './gitconfig/r_gitconfig'
operatorRouter = require './operator/r_operator'
index = require '../controller/homePage/index'

router = express.Router()

router.get('/', index)
router.put('/init/:action', init)
router.put('/clone', clone)
router.use('/config',  configRouter)
router.use('/operator', operatorRouter)



module.exports = router


