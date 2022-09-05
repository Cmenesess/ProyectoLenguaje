const db = require("../models/index");
const jwt = require("jsonwebtoken");
const { Op } = require("sequelize");
exports.list = async (req, res, next) => {
  try {
    usuario = jwt.decode(req.header("Authorization"));
    var id = usuario["id"];
    db.SavaPackage.findAll({
      where: {
        ClientId: id,
      },
      include: { model: db.WarehousePackage, include: { model: db.Image } },
    }).then((packages) => {
      return res.status(200).json(packages);
    });
  } catch (err) {
    next(err);
  }
};
exports.listAll = async (req, res, next) => {
<<<<<<< HEAD
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
exports.orderASCDate = async(req, res, next) => {
    try {
        var user= jwt.decode(req.header("Authorization"))
        var id = user["id"];
        db.SavaPackage.findAll({
            where: {
                ClientId:id,
                status: 'Entregado'
            } ,
            order: [['arrival_date_destiny', "ASC"]]
        }).then(packages => {
            return res.status(200).json(packages);
        })
    }catch(err) {
        next(err);
    }
}
exports.orderDESCDate = async(req, res, next) => {
    try {
        var user= jwt.decode(req.header("Authorization"))
        var id = user["id"];
        db.SavaPackage.findAll({
            where: {
                ClientId:id,
                status: 'Entregado'
            } ,
            order: [['arrival_date_destiny', "DESC"]]
        }).then(packages => {
            return res.status(200).json(packages);
        })
    }catch(err) {
        next(err);
    }
}
exports.filterDate = async(req, res, next) => {
    try {
        var user= jwt.decode(req.header("Authorization"))
        var id = user["id"]
        const start = req.params.start;
        const end = req.params.end;
        const parseStart = Date.parse(start);
        const parseEnd = Date.parse(end);
        db.SavaPackage.findAll({
            where: {
                ClientId:id,
                status: 'Entregado',
                arrival_date_destiny: {
                    [Op.and]: {
                        [Op.gte]: parseStart,
                        [Op.lte]: parseEnd
                      }
                }
            }
        }).then(packages => {
            return res.status(200).json(packages);
        })
    }catch(err) {
        next(err);
    }
}
exports.filterDelivered = async(req, res, next) => {
    try {
        var user= jwt.decode(req.header("Authorization"))
        console.log(user)
        var id = user["id"]
        db.SavaPackage.findAll({
            where: {
                ClientId:id,
                status: 'Entregado'
            } 
        }).then(packages => {
            return res.status(200).json(packages);
        })
    }catch(err) {
        next(err);
    }
}
=======
  try {
    db.SavaPackage.findAll({
      include: [
        { model: db.WarehousePackage, attributes: ["tracking_number"] },
        { model: db.Client, attributes: ["email"] },
      ],
    }).then((packages) => {
      return res.status(200).json(packages);
    });
  } catch (err) {
    next(err);
  }
};

exports.listCode = async (req, res, next) => {
  try {
    console.log(req.params.code),
      db.SavaPackage.findAll({
        where: {
          sava_code: { [Op.like]: "%" + req.params.code + "%" },
        },
        include: [
          { model: db.WarehousePackage, attributes: ["tracking_number"] },
          { model: db.Client, attributes: ["email"] },
        ],
      }).then((packages) => {
        return res.status(200).json(packages);
      });
  } catch (err) {
    next(err);
  }
};
exports.Modify = async (req, res, next) => {
  try {
    const {
      savaCode,
      status,
      price,
      weight,
      departureDate,
      arrival_date_destiny,
    } = req.body;
    await db["SavaPackage"].update(
      {
        status: status,
        price: price,
        weight: weight,
        departureDate: departureDate,
        arrival_date_destiny: arrival_date_destiny,
      },
      {
        where: {
          sava_code: savaCode,
        },
      }
    );
    return res.status(200).json({ message: "Se ha modificado exitosamente" });
  } catch (err) {
    next(err);
  }
};
exports.orderASCDate = async (req, res, next) => {
  try {
    var user = jwt.decode(req.header("Authorization"));
    var id = user["id"];
    db.SavaPackage.findAll({
      where: {
        ClientId: id,
        status: "Entregado",
      },
      order: [["arrival_date_destiny", "ASC"]],
    }).then((packages) => {
      return res.status(200).json(packages);
    });
  } catch (err) {
    next(err);
  }
};
exports.orderDESCDate = async (req, res, next) => {
  try {
    var user = jwt.decode(req.header("Authorization"));
    var id = user["id"];
    db.SavaPackage.findAll({
      where: {
        ClientId: id,
        status: "Entregado",
      },
      order: [["arrival_date_destiny", "DESC"]],
    }).then((packages) => {
      return res.status(200).json(packages);
    });
  } catch (err) {
    next(err);
  }
};
exports.filterDate = async (req, res, next) => {
  try {
    var user = jwt.decode(req.header("Authorization"));
    var id = user["id"];
    const start = req.params.start;
    const end = req.params.end;
    const parseStart = Date.parse(start);
    const parseEnd = Date.parse(end);
    db.SavaPackage.findAll({
      where: {
        ClientId: id,
        status: "Entregado",
        arrival_date_destiny: {
          [Op.and]: {
            [Op.gte]: parseStart,
            [Op.lte]: parseEnd,
          },
        },
      },
    }).then((packages) => {
      return res.status(200).json(packages);
    });
  } catch (err) {
    next(err);
  }
};
exports.filterDelivered = async (req, res, next) => {
  try {
    var user = jwt.decode(req.header("Authorization"));
    var id = user["id"];
    db.SavaPackage.findAll({
      where: {
        ClientId: id,
        status: "Entregado",
      },
    }).then((packages) => {
      return res.status(200).json(packages);
    });
  } catch (err) {
    next(err);
  }
};
>>>>>>> refs/remotes/origin/main
