const db = require('../models/index');
const generate_token = require('../Middleware/generate_token');
const {CLIENTE,ADMINISTRADOR} = require('../constants/roles.constants');
var bcrypt = require('bcryptjs');


exports.createClient = async (req,res,next) => {
    try {
        const { correo, password,telefono} = req.body;
        var hash = bcrypt.hashSync(password, 8);
        const result = await db.sequelize.transaction(async (t) => {
            let findPerson = await db['User'].findOne({
                where:{
                    username:correo,
                }
            });

            if (findPerson != null) {
                return res.json({message: 'Usuario ya registrado',status:204}).status(204);
            }
            let newPerson = await db['User'].create({
                password:hash,
                phoneNumber:telefono,
                role: CLIENTE,
                username: correo
            },{transaction: t})
            let newClient = await db['Client'].create({
                username: newPerson.id,
                email:newPerson.username
            },{transaction: t})
            const token = await generate_token.generate_token(newPerson);
            await db['User'].update({
                token:token
            },{transaction:t, where: {username: newPerson.username}})

            return res.json({message: 'Creacion completa',status:201}).status(201);
        })
    }catch(err){
        console.log(err)
        next(err)
    }
}

exports.createAdmin = async (req,res,next) => {
    try {
        const { correo, password,telefono} = req.body;
        const result = await db.sequelize.transaction(async (t) => {
            let findPerson = await db['User'].findOne({
                where:{
                    username:correo,
                }
            });
            if (findPerson != null) {
                return res.json({message: 'Usuario ya registrado'}).status(204);
            }
            let newPerson = await db['User'].create({
                password:password,
                role: ADMINISTRADOR,
                username: correo,
                phoneNumber:telefono,
            },{transaction: t})

            const token = await generate_token.generate_token(newPerson);
            await db['User'].update({
                token:token
            },{transaction:t, where: {username: newPerson.username}})

            return res.json({message: 'Creacion completa'}).status(201);
        })
    }catch(err){
        next(err);
    }
}
exports.getInfoClient=async(req,res,next)=>{
    try{
        const { token} = req.body;
        let user = await db['User'].findOne({
            where:{
                token:token,
            },
            include:[
                {model: db.Client}
            ]
        });
        return res.json({username: user.username,phone:user.phoneNumber,sentPackages:user.Clients[0].sentPackages}).status(204);
    }catch(err){
        console.log(err)
        return res.json({token: 'error', message: 'Credenciales no coinciden'}).status(204);
    }
}
exports.postUser= async(req,res,next)=>{
    try {
        const { correo, password} = req.body;
        console.log(req.body)
        let user = await db['User'].findOne({
            where:{
                username:correo,
                password:password
            }
        });

        console.log(user);
        const token = await generate_token.generate_login_token(user);
        console.log(token)
        await db['User'].update({
            token:token
        },{ where: {username: user.username}})

        return res.json({token}).status(202);
    }catch(err){
        const { correo, password} = req.body;
        let user = await db['User'].findOne({
            where:{
                username:correo
            }
        });

        if (user == null) {
            return res.json({message: 'Usuario no existe'}).status(204);
        }

        return res.json({token: 'error', message: 'Credenciales no coinciden'}).status(204);
    }
}
exports.showUser=async(req,res,next)=>{
    try {

        let users = await db['User'].findAll({

        })
        return res.status(200).json(users);

    } catch (error) {
        return res.json({user: 'Hay un problema',}).status(204);
    }
}
exports.showClients=async(req,res,next)=>{
    try {
        
        let users = await db['User'].findAll({
            where:{role:2}
        })
        return res.status(200).json(users);

    } catch (error) {
        return res.json({user: 'Hay un problema',}).status(204);
    }
}
exports.deleteUser=async(req,res,next)=>{
    try {
        await db['User'].destroy({
            where:{
                id: req.body.id
            }
        })
        return res.status(201).json({message:"Se ha eliminado el usuario"})
    } catch (error) {
        return res.json({user: 'Hay un problema',}).status(204);
    }
}