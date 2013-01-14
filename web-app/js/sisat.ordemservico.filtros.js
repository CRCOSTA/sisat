$(document).ready(function(){
	
	var trocaStatus;
	
	$('#datepickerInicio').datepicker({autoclose:true,language:'pt-BR'});
	$('#datepickerFinal').datepicker({autoclose:true,language:'pt-BR'});
	
	
	
	window.prepararFormValidarSenha = function(idAtend){
		$('#validarSenha')[0].reset();
		$('#validarSenhaId').val(idAtend);
		$('#modalValidar').show();
	};
	
	window.encaminharParaTecnico = function(idAtend){
		var nomeTecnico=$('#funcionario'+idAtend + ' :selected').text();
		 $.post('http://localhost:8080/SICA-WEB/ordemServico/encaminharParaTecnico',
				 $('#encaminhar'+idAtend).serialize(), 
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
		 $.post('http://localhost:8080/SICA-WEB/ordemServico/validarSenha',
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
	
	window.gravarHistorico = function(idAtend){
		 $.post('http://localhost:8080/SICA-WEB/historicoAtendimento/save',
				 $('#historico').serialize(), 
				 function(data) {  
			 		var idAtend = $('#historicoId').val();
			 		$('#modalHistorico').hide();
			 		$('#historicoPlace'+idAtend).append(data);
			 		});
	};
	
	trocaStatus=function(status,css,idAtend){
		$('#status'+idAtend).removeClass();
 		$('#status'+idAtend).addClass(css);
 		$('#status'+idAtend).html(status);
 		$('#modalstatus'+idAtend).addClass(css);
 		$('#modalstatus'+idAtend).html(status);
	}
	
	
	
	
});
