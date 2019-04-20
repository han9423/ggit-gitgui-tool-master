express = require 'express'
{ addTemp, addCommit , addRemote } = require '../../controller/operator/operator'


router = express.Router()

router.post('/addtemp', addTemp)
router.post('/addCommit', addCommit)
router.post('/addRemote', addRemote)
module.exports = router
