const command = require('./connectionFactory');
async function cadastrarDenuncia(denuncia) {
    let cota = parseInt(denuncia.visualizacoes/2)+1;
    let sql = "insert into denuncia (detalhes,flag,noticia_idnoticia,user_id,cota) values (?)";
    let result;
    try {
        let dados = [denuncia.detalhes,denuncia.categoria,denuncia.idNoticia,denuncia.idUsuario,cota]; 
        result = await command.query(sql,[dados]);
    } catch (error) {
        console.log(error);
    }
}
async function consultarDenuncia(idUsuario,idNoticia){
   let sql = "select idDenuncia from denuncia where noticia_idnoticia = ? and user_id = ? ";
   let result;
   try {
       result = await command.query(sql,[idNoticia,idUsuario]);
   } catch (error) {
       console.log(error);
   } 
   return result;
}
async function find(idNoticia){
    let sql = "select * from denuncia where noticia_idnoticia = ?";
    let result;
    try {
        result = await command.query(sql,[[idNoticia]]);
    } catch (error) {
        console.log(error);
    }
    return result;
}
async function buscaDenuncia(idDenuncia){
    let sql = "select * from denuncia where idDenuncia = ?";
    let result;
    try {
        result = await command.query(sql,[[idDenuncia]]);
    } catch (error) {
        console.log(error);
    }
    return result;
}
async function registrarVoto(voto,idDenuncia,idUsuario){
    let sql;
    if(voto == "concordo"){
        sql = "update denuncia set pros = pros+1 where idDenuncia = ?";
    }else{
        sql = "update denuncia set contras = contras+1 where idDenuncia = ?";
    }
    let result;
    try {
        result = await command.query(sql,[idDenuncia]);
        await registrarVotoUsuario(idUsuario,idDenuncia);
    } catch (error) {
        console.log(error);
    }
    return await buscaDenuncia(idDenuncia);
}
async function registrarVotoUsuario(idUsuario,idDenuncia){
    let sql = "insert into votosusuarios(idUsuario,id_Denuncia) values (?)";
    let result;
    try {
        await command.query(sql,[[idUsuario,idDenuncia]]);
        result = await find(idNoticia);
    } catch (error) {
        console.log(error);
    }
    return result;
}
async function verificarAptoVoto(idNoticia,idUsuario){
    let sql = `select votosusuarios.id_Denuncia from votosusuarios
    join denuncia on votosusuarios.id_Denuncia = denuncia.idDenuncia
    where votosusuarios.idUsuario = ? 
    and denuncia.noticia_idnoticia = ?;`;
    let result;
    try {
        result = await command.query(sql,[[idUsuario],[idNoticia]]);
    } catch (error) {
        console.log(error);
    }
    return result;
}
async function buscaNoticiaRegiao(idUsuario){
    let sql = `select idnoticia from noticia join user
    on noticia.cidade = user.cidade join denuncia
    on denuncia.noticia_idnoticia = noticia.idnoticia
    where user.id = ? and status = 0  order by noticia.idnoticia limit 1`;
    let result;
    try {
        result = await command.query(sql,[[idUsuario]]);
    } catch (error) {
        console.log(error);
    }
    return result;
}
//Seta 0 ou 1 no campo denunciada da tabela noticia
//se for 1 a notícia foi punida
async function executarPunicao(punicao,idnoticia,idDenuncia){
    let sql = "update noticia set denunciada = ? where idnoticia = ?";
    let result;
    try {
        result = await command.query(sql,[[punicao],[idnoticia]]);
    } catch (error) {
        console.log(error);
    }
    let sql2 = "update denuncia set status = 1 where idDenuncia = ?";
    try {
        result = await command.query(sql2,[[idDenuncia]]);
    } catch (error) {
        console.log(error);
    }
}
async function verificarSeUsuarioVotou(idDenuncia,idUsuario){
    let sql = "select * from votosusuarios where idUsuario = ? and id_Denuncia = ?";
    let result;
    
    try {
        result = await command.query(sql,[[idUsuario],[idDenuncia]]);
    } catch (error) {
        console.log(error);
    }
    return result;
}
module.exports = {cadastrarDenuncia,consultarDenuncia, find,registrarVoto,verificarAptoVoto,buscaNoticiaRegiao,executarPunicao, verificarSeUsuarioVotou}