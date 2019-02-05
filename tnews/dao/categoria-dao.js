const command = require('./connectionFactory');
async function read() {
    const sql = "select * from categoria"
    const result = await command.query(sql);
    return result;
}
async function cadastrarCategoriaUsuario(idUsuario,idCategoria){
    const sql = "insert into categoria_has_user(categoria_idcategoria,user_id) values (?)";
    const dados = [idCategoria,idUsuario];
    const result = await command.query(sql,[dados]);
}
async function cadastrarCategoriaNoticia(idNoticia,idCategoria){
    const sql = "insert into noticia_has_categoria(noticia_idnoticia,categoria_idcategoria) values (?)";
    try {
        await command.query(sql,[[idNoticia,idCategoria]]);
    } catch (error) {
        console.log(error);
    }
}
async function buscarCategoriaNoticia(idNoticia){
    const sql = `select categoria.categoria from categoria join noticia_has_categoria
    on categoria.idcategoria = noticia_has_categoria.categoria_idcategoria
    where noticia_has_categoria.noticia_idnoticia  = ?;`;
    let result;
    try {
        result = await command.query(sql,[[idNoticia]]);
    } catch (error) {
        console.log(error);
    }
    return result;
}
module.exports = {
   read,cadastrarCategoriaUsuario,cadastrarCategoriaNoticia, buscarCategoriaNoticia
}