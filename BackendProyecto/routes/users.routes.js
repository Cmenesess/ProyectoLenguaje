var express = require('express');
var router = express.Router();
var userController = require('../controllers/users.controller');

router.post('/client',userController.createClient);
router.post('/admin',userController.createAdmin);
router.post('/userConfirmation', userController.postUser);
router.get('/',userController.showUser)
router.get("/clients",userController.showClients)
router.delete('/',userController.deleteUser)

module.exports = router;