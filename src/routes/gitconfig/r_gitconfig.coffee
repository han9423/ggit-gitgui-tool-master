{ Router } = require 'express'
{ initConfig, getKey, configUser } = require '../../controller/gitconfig/gitconfig'


router = Router()


router.get '/initconfig', initConfig
router.post '/getkey', getKey
router.post '/configuser', configUser

module.exports = router



