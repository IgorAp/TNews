$(document).ready(function() {
    $('#summernote').summernote({
      placeholder: 'Escreva o corpo da notícia aqui',
      height: 160,
      lang: 'pt-BR',
      callbacks: {
        onImageUpload: function(files) {
          var dados = $('#summernote').summernote('code');
          console.log(dados);
          var imgNode;
          var form = new FormData();
          form.append('fileUpload', files[0]); // para apenas 1 arquivo
          //var name = event.target.files[0].content.name; // para capturar o nome do arquivo com sua extenção
          var http = new XMLHttpRequest();
          http.onreadystatechange = function(){
            console.log(http.responseText);
            var imgNode = "<img class='img-fluid' src="+http.responseText+"></img>";
            dados = dados+imgNode;
            $("#summernote").summernote('code', dados);
          }
          http.open("POST","/noticia/uploader",false);
          http.send(form);
          
        }
      }
    });
});
