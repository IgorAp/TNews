function verificaLogin(req){
    var login;
    if(req.cookies.session != undefined){
      if(req.cookies.session !=1){
        login = true;
      }else{
        login = false;
      }
    }
    else
      login = false;
      return login;
  }
  function auteticaSession(req, res, next) {
    if(req.cookies.session[0] == 1) {
      res.redirect('/users/login');
    }else{
      next();
    }
  }
module.exports = {verificaLogin,auteticaSession}