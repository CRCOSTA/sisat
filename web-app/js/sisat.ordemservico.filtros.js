$(document).ready(function(){
	
	var trocaStatus,server='http://localhost:8080/SISAT/';
	
	$('#datepickerInicio').datepicker({autoclose:true,language:'pt-BR'});
	$('#datepickerFinal').datepicker({autoclose:true,language:'pt-BR'});
	$('#datepickerSaida').datepicker({autoclose:true,language:'pt-BR'});
	$('#horaSaida').timepicker({
		showMeridian:false
	});
	$('#fotoFile').uploadify({
        'swf'      : '/SISAT/images/uploadify.swf',
        'uploader' : '/SISAT/imagem/upload',
        'uploadLimit' : 8,
        'queueSizeLimit' : 8,
        'buttonText' : 'Selecionar Arquivos',
        'width'    : 150,
        'fileDesc' : 'Allowed Types: (*.jpg,*.png,*.gif)',
        'fileExt' : '*.jpg;*.JPG;*.gif;*.GIF;*.png;*.PNG',
        'onUploadStart' : function(file) {
        	$('#fotoFile').uploadify('settings','formData',{'idAtend':$('#uploadFotoId').val()});
        }
        // Your options here
    });
	
	window.prepararFormUploadFoto = function(idAtend){
		$('#uploadFotoId').val(idAtend);
		$('#modaluploadfoto').show();
	};
	
	window.prepararFormValidarSenha = function(idAtend){
		$('#validarSenha')[0].reset();
		$('#validarSenhaId').val(idAtend);
		$('#modalValidar').show();
	};
	
	window.encaminharParaTecnico = function(){
		var nomeTecnico=$('#funcionario :selected').text();
		 $.post(server + 'ordemServico/encaminharParaTecnico',
				 $('#encaminhar').serialize(), 
				 function(data) {  
			 		var idAtend = $('#encaminharId').val();
			 		$('#modalEncaminhar').hide();
			 		$('#nomefuncionario'+idAtend).html(nomeTecnico);
			 		trocaStatus("com o tecnico","label label-com_o_tecnico",idAtend);
			 		$('#validarSenhaBtn'+idAtend).show();
			 		});
	};
	
	window.prepararFormEncaminhar = function(idAtend){
		$('#encaminhar')[0].reset();
		$('#encaminharId').val(idAtend);
		$('#modalEncaminhar').show();
	};
	
	
	window.validarSenha = function(){
		 $.post(server + 'ordemServico/validarSenha',
				 $('#validarSenha').serialize(), 
				 function(data) {  
			 		var idAtend = $('#validarSenhaId').val();
			 		$('#modalValidar').hide();
			 		trocaStatus("senha validada","label label-senha_validada",idAtend);
			 		$('#validarSenhaBtn'+idAtend).hide();
			 		$('#encaminharBtn'+idAtend).hide();
			 		});
	};
	
	window.prepararFormHistorico = function(idAtend){
		$('#historico')[0].reset();
		$('#historicoId').val(idAtend);
		$('#modalHistorico').show();
	};
	
	window.gravarHistorico = function(){
		 $.post(server + 'historicoAtendimento/save',
				 $('#historico').serialize(), 
				 function(data) {  
			 		var idAtend = $('#historicoId').val();
			 		$('#modalHistorico').hide();
			 		$('#historicoPlace'+idAtend).append(data);
			 		});
	};
	
	window.prepararFormFechamento = function(idAtend){
		$('#fechamento')[0].reset();
		$('#fechamentoId').val(idAtend);
		$('#modalfechamento').show();
	};
	
	window.fecharAtendimento = function(){
		 $.post(server + 'ordemServico/fecharAtendimento',
				 $('#fechamento').serialize(), 
				 function(data) {  
			 		var idAtend = $('#fechamentoId').val();
			 		$('#modalfechamento').hide();
			 		trocaStatus("fechada","label label-fechada",idAtend);
			 		
			 		});
	};
	
	trocaStatus=function(status,css,idAtend){
		$('#status'+idAtend).removeClass();
 		$('#status'+idAtend).addClass(css);
 		$('#status'+idAtend).html(status);
 		$('#modalstatus'+idAtend).addClass(css);
 		$('#modalstatus'+idAtend).html(status);
	};
	
	
	
	
	
	
	
});
