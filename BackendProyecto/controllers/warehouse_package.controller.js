const db = require('../models/index');
const jwt = require("jsonwebtoken");
const generator = require('../helpers/create_sava')

exports.list = async (req, res, next) => {
    try {
        db.WarehousePackage.findAll({
            where:{
                sava_code:null
            },
            include:[
                {model:db.Image},
                {model:db.Client,attributes:['email']}
            ]
        })
        .then(paquetes=>{
            return res.status(200).json(paquetes);
        })
    }catch (err) {
        console.log(err)
        next(err);
    }
}

exports.showByUser = async (req, res, next) => {
    try {
        usuario=jwt.decode(req.header("Authorization"))
        var id=usuario["id"]
        db.WarehousePackage.findAll({
            where: {
                ClientId:id,
                sava_code:null
            },
            include:{
                model:db.Image
            }
        })
        .then(paquetes=>{
            return res.status(200).json(paquetes);
        })
    }catch (err) {
        console.log(err)
        next(err);
    }
}
exports.creationSava=async (req, res, next) => {
    try{
        trackingNumber=req.body.packages
        db.WarehousePackage.findAll({
            include: db.Client,
            where: {
                tracking_number:trackingNumber
            }
        }).then(packages=>{
            client=packages[0].Client
            package_sent=client.sentPackages
            client.sentPackages=client.sentPackages+1
            client.save()
            savaCode=generator.generateSavaCode(package_sent,packages[0].ClientId)
            savaCreated=db.SavaPackage.create({
                ClientId: packages[0].ClientId,
                sava_code: savaCode,
                status: 'En bodega',
            }).then(sava=>{
                total_price=0.0
                total_weight=0.0
                for(var package of packages){
                    total_price+=parseFloat(package.price)
                    total_weight+=parseFloat(package.pounds)
                    package.sava_code=savaCode
                    package.save()
                }
                sava.price=total_price
                sava.weight=total_weight
                sava.save()
                return res.status(200).json(sava);
            })
        })
    }catch (err) {
        next(err);
    }
}
exports.createPackage = async (req, res, next) => {
    try {
        form=JSON.parse(req.body.warehouseForm)
        const{client_name,tracking_number,pounds,price,arrival_date}=form
        let package=await db['WarehousePackage'].findOne({
            where: {
                tracking_number:tracking_number
            }
        })
        if (package != null) {
            return res.json({message: 'Ese tracking Number ya esta registrado'}).status(204);
        }
        db['WarehousePackage'].create({
            tracking_number:tracking_number,
            ClientId:client_name,
            pounds:pounds,
            price:price,
            arrival_date:arrival_date
        }).then(result=>{
            for(file of req.files){
                db['Image'].create({
                    tracking_number:result.tracking_number,
                    source:file.location
                })
            }
            return res.status(200).json({ message: "Se ha creado exitosamente" })
        })
    } catch (err) {
        console.log(err)
        next(err);
    }
}

exports.updatePackage = async (req, res, next) => { 
    console.log(req.params.id)
}

exports.deletePackage = async (req, res, next) => { 

    
}
