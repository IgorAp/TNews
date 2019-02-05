var express = require('express');
var router = express.Router();
var denunciaDao = require('../dao/denuncia-dao');
var noticiaDao = require('../dao/noticia-dao');
var sessionController = require('./session-controller');
router.post('/denunciar',sessionController.auteticaSession, async function(req, res, next) {
    let mensagem = "Sua denúncia foi realizada com sucesso!"
    let denuncia = JSON.parse(req.body.denuncia);
    denuncia.idUsuario = req.cookies.session.id;
    await denunciaDao.cadastrarDenuncia(denuncia);
    res.send(mensagem);
});

//verifica se o usuário logado na sessão já votou
router.post("/verificar",sessionController.auteticaSession,async function(req,res){
    let idNoticia = req.body.idNoticia;
    let idUsuario = req.cookies.session.id;
    let verifica = await denunciaDao.consultarDenuncia(idUsuario,idNoticia)
    if(verifica == ""){
        res.send(false);
    }else{
        res.send(true);
    }
    
});
//envia o form de avaliar uma denúncia
router.get('/avaliar/:id',sessionController.auteticaSession, async function(req,res){
    const id =req.params.id;
    let idUsuario = req.cookies.session.id;
    let denuncia = await denunciaDao.find(id);
    let noticia = await noticiaDao.readOne(id);
    let votou = false;
    let verificaDenuncia = await denunciaDao.verificarSeUsuarioVotou(denuncia[0].idDenuncia,idUsuario);
    if(verificaDenuncia ==""){
        console.log("pode votar");
    }else{
        console.log("já votou");
        votou = true
    }
    res.render('noticia/avaliar-denuncia',{denuncia:denuncia[0],noticia:noticia[0],votou:votou});
});
router.post('/avaliar',sessionController.auteticaSession,async function(req,res){
    let idUsuario = req.cookies.session.id;
    let avaliacao = JSON.parse(req.body.avaliacao);
    if(avaliacao.voto != "nulo"){
        let denuncia = await denunciaDao.registrarVoto(avaliacao.voto,avaliacao.idDenuncia,idUsuario);
        await VerificaQuantidadeVotos(denuncia[0]);
    }
    res.send("Obrigado por participar");
});
//verifica se a denuncia já teve votos suficientes para ser encerrada
async function VerificaQuantidadeVotos(denuncia){
    if(denuncia.pros > denuncia.cota){
        await denunciaDao.executarPunicao(1,denuncia.noticia_idnoticia,denuncia.idDenuncia);
    }else if(denuncia.pros > denuncia.cota){
        await denunciaDao.executarPunicao(0,denuncia.noticia_idnoticia,denuncia.idDenuncia);
    }
}
module.exports = router;
