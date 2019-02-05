var express = require('express');
var router = express.Router();
var userDao = require('./../dao/user-dao');
var categoriaDao = require('./../dao/categoria-dao');
var crypto = require('crypto');
var sessionController = require('./session-controller');
var mensagem ="";
var noticiaDao = require('../dao/noticia-dao');
/* GET users listing. */
router.get('/', sessionController.auteticaSession,function(req, res, next) {
  res.send('respond with a resource');
});

//rota de cadastro de usuários que responde enviando o formulário de cadastro
router.get('/cadastro',function(req,res){
  res.render('users/cadastro-usuario',{title: 'Cadastro de Usuário',action:"cadastro",dados:{},button:"Cadastrar",mensagem:mensagem});
  if(mensagem!=""){
    mensagem = "";
  }
});

//rota de cadastro de usuários que recebe os dados do formulário
router.post('/cadastro',async function(req,res){
  const usuario = req.body;
  const verifica = await  verificaEmail(usuario.email);
  if(verifica){
    //encriptando a senha do usuário
    usuario.senha = encriptaSenha(usuario.senha);
    userDao.create(usuario);
    res.redirect('/');
  }else{
    mensagem = "O email informado já foi cadastrado";
    res.redirect('/users/cadastro');
  }
  
});

//rota de update que envia o formulário pré prenchido
router.get('/editar',sessionController.auteticaSession,async function(req,res){
  const user = await userDao.findOne(req.cookies.session.id);
  res.render('users/atualizar-usuario',{dados:user[0],title:"Atualizar Usuário",action:"editar/"+req.cookies.session.id,button:"Editar",mensagem});
  if(mensagem!=""){
    mensagem = "";
  }
});

//rota de update que recebe as informações do formulário
router.post('/editar/:id',sessionController.auteticaSession,async function(req,res){
  const user = req.body;
  user.id = req.params.id;
  let verificaSe = true;
  let verificaEm = true;
  if(user.senha!=null){
    user.senha = encriptaSenha(user.senha);
  }
  if(user.senhaAtual!=null){
    verifiaSe = await verifiaSenha(user.id,user.senhaAtual);
  }
  if(user.senhaAtual!=null){
    user.senhaAtual = encriptaSenha(user.senhaAtual);
    verifiaSe = verifiaSenha(user.senhaAtual);
  }
  if(user.email != null){
    verificaEm = await verificaEmailUpdate(user.email,user.id);
  }
  if(verificaSe == true){
    if(verificaEm == true){
      await userDao.update(user);
      mensagem = "Perfil Atualizado com Sucesso!";
    }else{
      mensagem  = "O email informado já está cadastrado";
    }
  }
  else{
    mensagem = "A senha está incorreta!";
  }
  res.redirect('/users/editar');
});

//rota de login que responde enviando o formulário de login
router.get('/login',function(req,res){
  res.render('users/login');
});

//rota de login que recebe os dados do formulário
router.post('/login',async function(req,res){
  var user = req.body;
  user.senha = encriptaSenha(user.senha);
  const userAutenticado = await userDao.autentica(user);
  user.id = userAutenticado.id;
  if(userAutenticado.autentica){
    res.cookie("session",user);
    res.redirect('/');
  }else{
    
    res.redirect('/users/login');
  }
});

//passando a função autenticaSession para ver se o usuário já está logado
router.get('/perfil',sessionController.auteticaSession,async function(req,res){
  const noticias = await noticiaDao.noticiasEscritasUsuario(req.cookies.session.id);
  const noticiasAcompanhadas = await noticiaDao.noticiasAcompanhadasPeloUsuario(req.cookies.session.id);
  res.render('users/perfil',{login:global.login,noticias:noticias,noticiasAcompanhadas:noticiasAcompanhadas});
});
router.post('/acompanhar/:id',sessionController.auteticaSession,async function(req,res){
  let idNoticia = req.params.id;
  let acompanha = req.body.acompanha;
  if(acompanha == "true"){
    userDao.acompanharNoticia(req.cookies.session.id,idNoticia);
  }else if(acompanha == "false"){
    userDao.deixarDeAcompanharNoticia(req.cookies.session.id,idNoticia);
  }
  res.sendStatus(200);
});
router.get('/logout',function(req,res){
  res.redirect('/');
});


router.get('/excluir',sessionController.auteticaSession,function(req,res){
  res.render('users/excluir-usuario',{title: 'Excluir Usuário'});
});

router.post('/excluir/dados',sessionController.auteticaSession,async function(req,res){
  const user = req.body;
  var obj = await userDao.autentica(user);
  if(obj.autentica){
    await userDao.remove(obj);
  	res.redirect('/');
  }else{
    res.redirect('/users/excluir');
  }
});

function encriptaSenha(string){
  return crypto.createHash("sha256").update(string).digest('hex');
}
//função que verifica o se o email informado no cadastro já foi utilizado
async function verificaEmail(email){
  const usuarios = await userDao.read();
  let verifia = true;
  usuarios.forEach(usuario => { 
    if(usuario.email == email){
          verifia =  false;
      }
  });
  return verifia;
}
async function verificaEmailUpdate(email,id){
  const usuarios = await userDao.read();
  let verifia = true;
  usuarios.forEach(usuario => { 
    if(usuario.email == email && id != usuario.id){
          verifia =  false;
      }
  });
  return verifia;
}

//função para comparar se a senha digitada é igual a do banco
async function verifiaSenha(id,senha){
  const result = await userDao.comparaSenha(id);
  if(result[0].senha === senha)
        return true;
    else
        return false;
}
module.exports = router;
