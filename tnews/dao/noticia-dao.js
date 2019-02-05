var command = require('./connectionFactory');

async function read(indice){
    const sql = 'select * from noticia where concluida = 1 order by noticia.data limit ? , 5;';
    let result;
    try {
        result = await command.query(sql,[[indice]]);
    } catch (err) {
        console.log(err);
    }
    return result;
}
async function buscaPorCategoria(categoria,indice){
    let sql = `
    select * from noticia join noticia_has_categoria
    on noticia_has_categoria.noticia_idnoticia = noticia.idnoticia
    where noticia_has_categoria.categoria_idcategoria = ? and noticia.concluida = 1 order by noticia.data desc limit ?,5;
    `;
    let result;
    try {
        result = await command.query(sql,[[categoria],[indice]]);
    } catch (error) {
        console.log(error);
    }
    return result;
}
async function buscaPorEstado(estado,indice){
    let sql = `
    select * from noticia where noticia.estado = ? and concluida = 1 order by noticia.data desc limit ?,5	
    `;
    let result;
    try {
        result = await command.query(sql,[[estado],[indice]]);
    } catch (error) {
        console.log(error);
    }
    return result;
}
async function buscaPorCidade(cidade,indice){
    let sql = `
    select * from noticia where noticia.cidade = ? and concluida = 1 order by noticia.data desc limit ?,5	
    `;
    let result;
    try {
        result = await command.query(sql,[[cidade],[indice]]);
    } catch (error) {
        console.log(error);
    }
    return result;
}
async function buscaTodas(indice){
    let sql = `
    select * from noticia where concluida = 1 order by noticia.data limit ?,5;
    `;
    let result;
    try {
        result = await command.query(sql,[[indice]]);
    } catch (error) {
        console.log(error);
    }
    return result;
}
async function buscaPorCategoriaEstado(estado,categoria,indice){
    let sql = `
    select * from noticia join noticia_has_categoria
    on noticia_has_categoria.noticia_idnoticia = noticia.idnoticia
    where noticia_has_categoria.categoria_idcategoria = ? and noticia.estado = ? and concluida = 1
    order by noticia.data desc limit ?,5;       	
    `;
    let result;
    try {
        result = await command.query(sql,[[categoria],[estado],[indice]]);
    } catch (error) {
        console.log(error);
    }
    return result;
}
async function buscaPorCategoriaCidade(cidade,categoria,indice){
    let sql = `
    select * from noticia join noticia_has_categoria
    on noticia_has_categoria.noticia_idnoticia = noticia.idnoticia
    where noticia_has_categoria.categoria_idcategoria = ? and noticia.cidade = ? and concluida = 1
    order by noticia.data desc limit ?,5;       	
    `;
    let result;
    try {
        result = await command.query(sql,[[categoria],[cidade],[indice]]);
    } catch (error) {
        console.log(error);
    }
    return result;
}
async function obterAutores(idnoticia){
    let sql = `select * from user join noticia_has_user
        on noticia_has_user.idUser = user.id
        where noticia_has_user.idNoticia = ?;`;
    let result;
    try {
        result = await command.query(sql,[[idnoticia]]);
    } catch (error) {
        console.log(error);
    }
    return result;
}
async function create(noticia,idUsuario){
    const sql=`insert into noticia (titulo,corpo) values (?)`;
    const not = [noticia.titulo,noticia.corpo];
    let result;
    try {
        result = await command.query(sql,[not]);
        criarRelacionamentoUsuarioNoticia(result.insertId,idUsuario);
        return result.insertId;
    } catch (error) {
        console.log(error);
        return null;
    }
}
async function criarRelacionamentoUsuarioNoticia(idnoticia,idUsuario){
    let sql = "insert into noticia_has_user(idnoticia,iduser,dataEdicao) values(?)";
    let data = new Date();

    let result;
    try {
        result = await command.query(sql,[[idnoticia,idUsuario,data]]);
    } catch (error) {
        console.log(error);
    }
}

async function remove(noticia){
    const sql = "delete from noticia where idnoticia = ?";
    const id = noticia;
    const result = await command.query(sql,[id]);
}
async function readOne(id){
    const sql = 'select * from noticia where idnoticia = ?';
    let result;
    try {
        result = await command.query(sql,[id]);
        incrementaVisualizacao(id);
    } catch (err) {
        console.log(err);
    }
    return result;
}
async function incrementaVisualizacao(id){
    const sql = 'update noticia set visualizacoes = visualizacoes+1 where idnoticia = ?';
    let result;
    try {
        result = await command.query(sql,[id]);
    } catch (err) {
        console.log(err);
    }
}
async function update(noticia){
    const sql = `update noticia set ? where idnoticia = ?`;
    let result;
    try {
        result = await command.query(sql,
            [
                {
                    titulo:noticia.titulo,
                    corpo:noticia.corpo,
                },
                noticia.idnoticia
            ]
        );
    } catch (error) {
        console.log(error);
    }
    return result;
}
async function createPart2(noticia){
    const sql = `update noticia set ? where idnoticia = ?`;
    let result;
    try {
        result = await command.query(sql,
            [
                {
                    estado:noticia.estado,
                    cidade:noticia.cidade,
                    capa:noticia.capa,
                    data:noticia.data
                },
                noticia.idnoticia
            ]
        );
    } catch (error) {
        console.log(error);
    }
    return result;
}
async function adicionaRelacaoUsuarioNoticia(envolvimento,idUsuario,idnoticia){
    let sql = "update noticia_has_user set relacao = ? where idUser = ? and idNoticia = ?";
    let result;
    try {
        result = await command.query(sql,[[envolvimento],[idUsuario],[idnoticia]]);
        concluirCadastro(idnoticia);
    } catch (error) {
        console.log(error);
    }
}
async function concluirCadastro(idnoticia){
    let sql = `update noticia set concluida = 1 where idnoticia = ?;`;
    let result;
    try {
        result = await command.query(sql,[[idnoticia]]);
    } catch (error) {
        console.log(error);
    }
}
async function noticiasEscritasUsuario(idUsuario){
    let sql = `
    select noticia.titulo, noticia.idnoticia from noticia
    join noticia_has_user on noticia.idnoticia = noticia_has_user.idNoticia
    where noticia_has_user.idUser = ?;
    `;
    let result;
    try {
        result = await command.query(sql,[[idUsuario]]);
    } catch (error) {
        console.log(error);
    }
    return result;
}
async function noticiasAcompanhadasPeloUsuario(idUsuario){
    let sql = `select * from noticia join noticias_marcadas
    on noticia.idnoticia = noticias_marcadas.idnoticia
    where noticias_marcadas.idUser = ?;`;
    let result;
    try {
        result = await command.query(sql,[[idUsuario]]);
    } catch (error) {
        console.log(error);
    }
    return result;
}
module.exports = {
    create, 
    remove,
    read,
    readOne,
    update,
    createPart2,
    criarRelacionamentoUsuarioNoticia,
    obterAutores,
    adicionaRelacaoUsuarioNoticia,
    buscaPorCategoria,
    buscaPorCidade,
    buscaPorEstado,
    buscaPorCategoriaCidade,
    buscaPorCategoriaEstado,
    buscaTodas,
    noticiasEscritasUsuario,
    noticiasAcompanhadasPeloUsuario
};
