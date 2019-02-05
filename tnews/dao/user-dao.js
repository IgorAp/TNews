var command = require('./connectionFactory');

async function read(){
    const sql = "select * from user";
    const result = await command.query(sql);
    return result;
}

async function update(user){
    const sql = `update user set ? where id = ?`;
    const result = await command.query(sql,
        [
            {
                nome: user.nome,
                sobrenome: user.sobrenome,
                email:user.email,
                senha: user.senha,
                cidade: user.cidade,
                estado: user.estado,
                cep: user.cep
            },
            user.id
        ]);
   return result;
}

async function create(user){
    const sql=`insert into user (nome,sobrenome,email,senha,cidade,estado,cep) values (?)`;
    const usuario = [user.nome,user.sobrenome,user.email,user.senha,user.cidade,user.estado,user.cep];
    const result = await command.query(sql,[usuario]);
}

async function findOne(id){
    const sql = "select * from user where id=?";
    const result = await command.query(sql,[id]);
    return result;
}

async function remove(user){
    const sql = "delete from user where id = ?";
    const id = user.idUser;
    const result = await command.query(sql,[id]);
}
async function autentica(user){
    var obj = {
      autentica:false,
      id:null
    };
    const sql = "select * from user where email = ? and senha = ? limit 1";
    const result = await command.query(sql,[user.email,user.senha]);
    if(result[0] != undefined){
        obj.id =result[0].id;
        obj.autentica = true;
    }
    return obj;
}
async function comparaSenha(id){
    const  sql = "select senha from user where id = ?";
    const result = await command.query(sql,[id]);
    return result;
}
async function acompanharNoticia(idUsuario,idNoticia){
    let sql = "insert into noticias_marcadas(idnoticia,idUser) values(?)";
    let result;
    try {
       result = await command.query(sql,[[idNoticia,idUsuario]]); 
    } catch (error) {
        console.log(error);
    }
}

async function deixarDeAcompanharNoticia(idUsuario,idNoticia){
    let sql = "delete from noticias_marcadas where idnoticia = ? and idUser = ?";
    let result;
    try {
       result = await command.query(sql,[[idNoticia],[idUsuario]]); 
    } catch (error) {
        console.log(error);
    }
}

module.exports = {read,update,create,findOne,remove,autentica,comparaSenha,deixarDeAcompanharNoticia,acompanharNoticia};
