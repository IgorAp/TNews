var express = require('express');
var router = express.Router();
var comentarioDao = require('./../dao/comentario-dao');
var userDao = require('./../dao/user-dao');
var sessionController = require('./session-controller');

router.post('/cadastrar',sessionController.auteticaSession, async function(req, res, next) {
    const comentario = JSON.parse(req.body.comentario);
    comentario.idUser = req.cookies.session.id;
    const result = await comentarioDao.create(comentario);
    res.send("foi");
});
  
router.post('/:id',async function(req,res){
    const pagina = JSON.parse(req.body.pagina);
    const idNoticia = req.params.id;
    const comentarios = await comentarioDao.read(idNoticia,pagina);
    res.send(comentarios);
})
router.post('/respostas/:id',async function(req,res){
    const idComentario= JSON.parse(req.body.idComentario);
    const idNoticia = req.params.id;
    const comentarios = await comentarioDao.readRespostas(idNoticia,idComentario);
    res.send(comentarios);
});
 module.exports = router;