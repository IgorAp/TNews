const command = require('./connectionFactory');
async function create(comentario) {
    const sql = "insert into comentario(user_iduser,comentario_idcomentario,noticia_idnoticia,nivel,corpo) values (?)";
    let result;
    try{
        const dados = [comentario.idUser,comentario.idcomentario,comentario.idNoticia,comentario.nivel,comentario.corpo];
        result = await command.query(sql,[dados]);
    }catch(error){
        console.log(error);
    }
    return result;
}
async function read(idNoticia,indice){
    const sql = `select comentario.idcomentario,user.nome,user.sobrenome,comentario.corpo from comentario inner join user on 
    comentario.user_iduser = user.id 
    where comentario.noticia_idnoticia = ? and comentario.comentario_idcomentario is null  order by comentario.idcomentario desc limit ?,3;`;
    let result;
    try {
        result = await command.query(sql,[idNoticia,indice]);
    } catch (error) {
        console.log(error);
    }
    return result;
}
async function readRespostas(idNoticia,idComentario){
    const sql = `
    select comentario.corpo, user.nome,user.sobrenome from comentario 
    inner join user on comentario.user_iduser = user.id
    where comentario.comentario_idcomentario = ? and comentario.noticia_idnoticia = ? order by comentario.idcomentario desc;
    `;
    try {
        result = await command.query(sql,[idComentario,idNoticia]);
    } catch (error) {
        console.log(error);
    }
    return result;
}
module.exports = {create,read,readRespostas}