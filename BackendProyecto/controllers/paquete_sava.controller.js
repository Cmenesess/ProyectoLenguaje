const db = require('../models/index');
const jwt = require("jsonwebtoken");
exports.list = async (req, res, next) => {
    try {
        usuario=jwt.decode(req.header("Authorization"))
        var id=usuario["id"]
        db.SavaPackage.findAll({
            where: {
                ClientId:id,
            },include:
                {model:db.WarehousePackage,include:{model:db.Image}},
            
        }).then(packages=>{
            return res.status(200).json(packages);
        })
    }catch (err) {
        next(err);
    }
}
exports.listAll = async (req, res, next) => {
    try {
        db.SavaPackage.findAll({
            include:[
                {model:db.WarehousePackage,attributes:['tracking_number']},
                {model:db.Client,attributes:['email']}
            ]
        }).then(packages=>{
            return res.status(200).json(packages);
        })
    }catch (err) {
        next(err);
    }
}
exports.Modify = async(req,res,next)=>{
    try{
        const{savaCode,status,price,weight,departureDate,arrival_date_destiny}=req.body;
        await db['SavaPackage'].update({status:status,price:price,weight:weight,departureDate:departureDate,arrival_date_destiny:arrival_date_destiny},{
        where:{
            sava_code:savaCode,
        }
    }) 
    return res.status(200).json( {message:"Se ha modificado exitosamente"})
    }catch(err){
        next(err);
    }
}