var express = require('express');
var router = express.Router();
var noticiaDao = require('./../dao/noticia-dao');
var categoriaDao = require('./../dao/categoria-dao');
var multpart = require('connect-multiparty');
var multipartMiddleware = multpart();
var sessionController = require('./session-controller');
var primeiraVez = false;
var estado = {
  passo1:"complete",
  passo2:"disabled",
  passo3:"disabled"
}
//var login = sessionController
router.post('/obter/:indice', async function(req, res, next) {
  const filtros = JSON.parse(req.body.filtros);
  let result;
  let indice =  parseInt(req.params.indice);
  if(filtros.categoria != ""){
    if(filtros.estado != ""){
      if(filtros.cidade !=""){
        result = await noticiaDao.buscaPorCategoriaCidade(filtros.cidade,filtros.categoria,indice);
      }
      else{
        result = await noticiaDao.buscaPorCategoriaEstado(filtros.estado,filtros.categoria,indice);
      }
    }
    else{
      result = await noticiaDao.buscaPorCategoria(filtros.categoria,indice);
    }
  }else if(filtros.estado != "" && filtros.cidade == ""){
    result = await noticiaDao.buscaPorEstado(filtros.estado,indice);
  }
  else if(filtros.cidade != ""){
    result = await noticiaDao.buscaPorCidade(filtros.cidade,indice);
  }
  else{
    result = await noticiaDao.buscaTodas(indice);
  }
  res.send(result);
});

//router para cadastro de noticia
router.get('/cadastro',sessionController.auteticaSession,function(req,res){
  estado.passo2 = "disabled";
  estado.passo3 = "disabled";
  res.render('noticia/cadastro-noticia',{title: 'Cadastro Noticia',action:"cadastro",dados:{},button:"cadastrar",login:global.login,estado:estado});
});

//rota para cadastro de uma notícia
router.post('/cadastro',sessionController.auteticaSession,async function(req,res){
  const noticia = req.body;
  let idUsuario = req.cookies.session.id;
  noticia.idnoticia = await noticiaDao.create(noticia,idUsuario);
  estado.passo2 = "complete";
  const categorias = await categoriaDao.read();
  res.render('noticia/cadastro-noticia-dados',{categorias:categorias,dados:noticia,action:"cadastro-dados/"+noticia.idnoticia,estado:estado});
});
router.post('/cadastro-dados/:id',sessionController.auteticaSession,async function(req,res){
  let noticia = req.body;
  noticia.idnoticia = req.params.id;
  noticia.capa = "/images/"+noticia.capa;
  await noticiaDao.createPart2(noticia);
  await categoriaDao.cadastrarCategoriaNoticia(noticia.idnoticia,noticia.categoria);
  estado.passo3 = "complete";
  res.render('noticia/preferencias',{id:req.cookies.session.id,estado:estado,action:"/noticia/cadastro-fim/"+noticia.idnoticia});
});

router.post('/cadastro-fim/:id',sessionController.auteticaSession,async function(req,res){
  const dados = req.body;
  let idUsuario = req.cookies.session.id;
  const idnoticia = req.params.id;
  await noticiaDao.adicionaRelacaoUsuarioNoticia(dados.envolvimento,idUsuario,idnoticia);
  primeiraVez = true;
  res.redirect('/noticia/view/'+idnoticia);
});
//router para excluir noticia 
router.get('/excluir',sessionController.auteticaSession,function(req,res){
  res.render('noticia/excluir-noticia',{title: 'Excluir Noticia'})
});

router.post('/excluir/dados',sessionController.auteticaSession,async function(req,res){
  const not = req.body;
  var obj = await noticiaDao.autentica(not);
  if(obj.autentica){
    await noticiaDao.remove(obj);
  	res.redirect('/');
  }else{
    res.redirect('/noticia/excluir');
  }
});

//rota para realizar o upload de uma imagem
router.post('/uploader', sessionController.auteticaSession,multipartMiddleware, function(req, res) {
  var fs = require('fs');
  const dir = process.cwd();
  fs.readFile(req.files.fileUpload.path, function (err, data) {
      var newPath =  dir+'/public/images/' + req.files.fileUpload.name;
      fs.writeFile(newPath, data, function (err) {
          if (err) console.log({err: err});
          res.status(200);
          res.send("/images/"+req.files.fileUpload.name);
      });
  });
});

//rota para ver uma notícia em detalhes
router.get('/view/:id',async function(req,res){
  const noticia = await noticiaDao.readOne(req.params.id);
  const autores = await noticiaDao.obterAutores(req.params.id);
  const categorias = await categoriaDao.buscarCategoriaNoticia(req.params.id);
  let categoria = "";
  if(categorias[0]!=null){
    categoria = categorias[0].categoria;
  }
  res.render('noticia/view-noticia',{noticia:noticia[0],login:global.login,autores:autores,primeiraVez:primeiraVez,categoria:categoria});
  primeiraVez = false;
});

router.get('/editar/:id',sessionController.auteticaSession,async function(req,res){
  const id = req.params.id;
  const noticia = await noticiaDao.readOne(id);
  res.render('noticia/cadastro-noticia',{title: 'Cadastro Noticia',action:"/noticia/editar/"+id,dados:noticia[0],button:"editar",login:global.login,estado:estado});
});
router.post('/editar/:id',sessionController.auteticaSession,async function (req,res){
  const noticia = req.body;
  let idUsuario = req.cookies.session.id;
  noticia.idnoticia = req.params.id;
  await noticiaDao.update(noticia);
  await noticiaDao.criarRelacionamentoUsuarioNoticia(noticia.idnoticia,idUsuario);
  primeiraVez = true;
  res.redirect('/noticia/view/'+req.params.id);
});

module.exports = router;