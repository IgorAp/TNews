var express = require('express');
var router = express.Router();
var noticiaDao = require('../dao/noticia-dao');
var denunciaDao = require('../dao/denuncia-dao');
var categoriaDao = require('../dao/categoria-dao');
var sessionController = require('./session-controller');
router.get('/', async function(req, res, next) {
  const noticias = await noticiaDao.buscaTodas(0);
  const categorias = await categoriaDao.read();
  let idUsuario;
  let podeVotar;
  let idDenuncia;
  let idNoticia;
  let idAuxiliar = 0;
  global.login = sessionController.verificaLogin(req);
  if(global.login){
    idUsuario = req.cookies.session.id;
    idNoticia = await denunciaDao.buscaNoticiaRegiao(idUsuario);
    if(idNoticia != ""){
      idDenuncia = await denunciaDao.verificarAptoVoto(idNoticia[0].idnoticia,idUsuario);
      if(idDenuncia == ""){
        idAuxiliar = idNoticia[0].idnoticia;
        podeVotar = true;
      }
      else{
        podeVotar = false;
      }
    }
  }
  else{
    console.log("deslogado");

  }
 res.render('index', { title: 'Express',login:global.login,noticias:noticias,podeVotar:podeVotar,idNoticia:idAuxiliar,categorias:categorias});
});

module.exports = router;
