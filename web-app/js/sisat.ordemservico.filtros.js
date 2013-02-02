$(document).ready(function(){
	
	
	$('#datepickerInicio').datepicker({autoclose:true,language:'pt-BR'});
	$('#datepickerFinal').datepicker({autoclose:true,language:'pt-BR'});
	$('#datepickerSaida').datepicker({autoclose:true,language:'pt-BR'});
	$('#datepickerDataLote').datepicker({autoclose:true,language:'pt-BR'});
	$('#horaSaida').timepicker({
		showMeridian:false
	});
	$('#funcionarioId').select2();
	
	
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
	
	
	
	
	window.prepararActions = function(idAtend,status){
		
		$('#actionGroup'+ idAtend + ' button').hide();
		$('#actionGroup'+ idAtend + ' button:.'+ status).show();
		$('#statusAtendimento'+ idAtend).val(status);
		
		
	}
	
	
	window.prepararFormEnviarPagamento = function(idAtend){
		$('#enviarPagamento')[0].reset()
		$('#enviarPagamentoId').val(idAtend);
		$('#modalenviarPagamento').show();
	};
	
	window.prepararFormUploadFoto = function(idAtend){
		$('#uploadFotoId').val(idAtend);
		$('#modaluploadfoto').show();
	};
	
	window.prepararFormValidarSenha = function(idAtend){
		$('#validarSenha')[0].reset();
		$('#validarSenhaId').val(idAtend);
		$('#modalValidar').show();
	};
	
	
	
	window.prepararFormEncaminhar = function(idAtend){
		$('#encaminhar')[0].reset();
		$('#encaminharId').val(idAtend);
		$('#modalEncaminhar').show();
	};
	
	
	
	
	window.prepararFormHistorico = function(idAtend){
		$('#historico')[0].reset();
		$('#historicoId').val(idAtend);
		$('#modalHistorico').show();
	};
	
	
	
	window.prepararFormFechamento = function(idAtend){
		$('#fechamento')[0].reset();
		$('#fechamentoId').val(idAtend);
		$('#modalfechamento').show();
	};
	
	
	
	window.trocaStatus=function(status,css,idAtend){
		$('#status'+idAtend).removeClass();
 		$('#status'+idAtend).addClass(css);
 		$('#status'+idAtend).html(status);
 		$('#modalstatus'+idAtend).removeClass();
 		$('#modalstatus'+idAtend).addClass(css);
 		$('#modalstatus'+idAtend).html(status);
	};
	
	
	window.showSuccessMsg=function(idAtend,msg){
		$('#msgTxt'+idAtend).html(msg);
		$('#alertSuccess'+idAtend).show();
		window.setTimeout(function(){$('#alertSuccess'+idAtend).hide();},1000*5);
		
	}
	
	window.showErrorMsg=function(action,msg){
		$('#msgError'+action).html(msg);
		$('#error'+action).show();
		window.setTimeout(function(){$('#error'+action).hide();},1000*5);
	}
	
	
});
