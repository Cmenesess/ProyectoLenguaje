var express = require('express');
var router = express.Router();
var PaqueteSavaController=require('../controllers/paquete_sava.controller.js')

router.get('/', PaqueteSavaController.list);
router.get('/all',PaqueteSavaController.listAll);
router.put("/edit",PaqueteSavaController.Modify);
router.get('/history',PaqueteSavaController.filterDelivered);
router.get('/orderASCHistory',PaqueteSavaController.orderASCDate);
router.get('/orderDESCHistory',PaqueteSavaController.orderDESCDate);
router.get('/betweenHistory/:start/:end',PaqueteSavaController.filterDate);




module.exports = router;