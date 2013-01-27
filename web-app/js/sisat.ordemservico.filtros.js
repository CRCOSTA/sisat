$(document).ready(function(){
	
	var trocaStatus,server='http://localhost:8080/SISAT/';
	
	$('#datepickerInicio').datepicker({autoclose:true,language:'pt-BR'});
	$('#datepickerFinal').datepicker({autoclose:true,language:'pt-BR'});
	$('#datepickerSaida').datepicker({autoclose:true,language:'pt-BR'});
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
	
	window.receberOrdem = function(idAtend){
		 $.post(server + 'ordemServico/receberOS',
				 {id:idAtend}, 
				 function(data) {  
					 showSuccessMsg(idAtend,'Checklist recebido com sucesso.');
			 		$('#osNumeroPlace'+idAtend).append('<i class=icon-flag></i>');
				 });
	}
	
	window.enviarPagamento = function(idAtend){
		 $.post(server + 'ordemServico/enviarPagamento',
				 $('#enviarPagamento').serialize(), 
				 function(data) {  
			 		showSuccessMsg(idAtend,'Atendimento adicionado em lota com sucesso.');
			 		trocaStatus("aguardando pagamento","label label-aguardando_pagamento",idAtend);
			 		prepararActions(idAtend,'aguardando_pagamento');
			 
				 });
	}
	
	
	window.prepararActions = function(idAtend,status){
		
		$('#actionGroup'+ idAtend + ' button').hide();
		$('#actionGroup'+ idAtend + ' button:.'+ status).show();
		$('#statusAtendimento'+ idAtend).val(status);
		
		
	}
	
	window.prepararFormMaterial = function(idAtend){
		
		$('#materialForm')[0].reset();
		$("#selectMaterial").select2('destroy')
		 $.post(server + 'movimentacaoDeMaterial/getMaterialList',
				 {id:idAtend}, 
				 function(data) {  
					var options='',jsonMaterial ,materiais=data;
					
					$("#selectMaterial").select2({
				        placeholder: "Selecione o material...",
			            data:{results:data}
				    });
			 		
			 		$('#modalmaterial').show();
			 		$('#idAtend').val(idAtend);
			 		
			 		});
		
	}
	
	window.addMaterial = function(idAtend){
		var quantidade=$('#quantidade').val()*(-1), descricao='Codigo da autorizacao -->' + Math.floor(Math.random()*101010),
			dados= {id:idAtend,
				tipo:'Saida',
				'listMaterial.id':$('#selectMaterial').select2('val'),
				'descricao':descricao,
				quantidade:quantidade
				};
		
		 $.post(server + 'movimentacaoDeMaterial/saveAjax',
				 dados, 
				 function(data) {  
			 		showSuccessMsg(idAtend,'Material adicionado com sucesso.');
					linha = '<tr><td>'+ descricao+'</td><td>'+$('#selectMaterial').select2('data').materialDesc+ '</td><td>'+ quantidade*(-1) +'</td></tr>';
					
					$('#materiais'+idAtend).append(linha);
					
					$('#modalmaterial').hide();
			 		
			 		}).fail(function(error) {
				 		showErrorMsg("Material","Erro ao adicionar material");
				 	});
		
		
		
		
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
	
	window.encaminharParaTecnico = function(){
		var nomeTecnico=$('#funcionario :selected').text();
		 $.post(server + 'ordemServico/encaminharParaTecnico',
				 $('#encaminhar').serialize(), 
				 function(data) {  
			 		var idAtend = $('#encaminharId').val();
			 		showSuccessMsg(idAtend,'Atendimento encaminhado com sucesso.');
			 		$('#modalEncaminhar').hide();
			 		$('#nomefuncionario'+idAtend).html(nomeTecnico);
			 		trocaStatus("com o tecnico","label label-com_o_tecnico",idAtend);
			 		prepararActions(idAtend,'com_o_tecnico');
			 	 }).fail(function(error) {
			 		showErrorMsg("Encaminhar","Erro ao encaminhar atendimento");
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
			 		showSuccessMsg(idAtend,'Senha validada com sucesso.');
			 		$('#modalValidar').hide();
			 		trocaStatus("senha validada","label label-senha_validada",idAtend);
			 		prepararActions(idAtend,'senha_validada');
			 	}).fail(function(error) {
			 		showErrorMsg("Validar","Erro ao validar senha");
			 	});;
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
			 		var d,linha, idAtend = $('#historicoId').val();
			 			showSuccessMsg(idAtend,'Hist&oacute;rico adicionado com sucesso.');
			 			$('#modalHistorico').hide();
			 			
			 			d=new Date(data.dataHora);
			 			dataStr = d.getDate() + '/' + (d.getMonth()+1) + '/' + d.getFullYear() + ' ' + d.getHours() + ':'+ d.getMinutes()
			 		
			 			linha = '<tr><td>'+dataStr+'</td><td>'+data.analistaUSS+'</td><td>'+data.historico+'</td></tr>';
			 		
			 			$('#historicoPlace'+idAtend).append(linha);
			 		
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
			 		showSuccessMsg(idAtend,'Atendimento fechado com sucesso.');
			 		$('#modalfechamento').hide();
			 		trocaStatus("fechada","label label-fechada",idAtend);
			 		prepararActions(idAtend,'fechada');
			 		
			 		});
	};
	
	trocaStatus=function(status,css,idAtend){
		$('#status'+idAtend).removeClass();
 		$('#status'+idAtend).addClass(css);
 		$('#status'+idAtend).html(status);
 		$('#modalstatus'+idAtend).addClass(css);
 		$('#modalstatus'+idAtend).html(status);
	};
	
	
	showSuccessMsg=function(idAtend,msg){
		$('#msgTxt'+idAtend).html(msg);
		$('#alertSuccess'+idAtend).show();
		window.setTimeout(function(){$('#alertSuccess'+idAtend).hide();},1000*5);
		
	}
	
	showErrorMsg=function(action,msg){
		$('#msgError'+action).html(msg);
		$('#error'+action).show();
		window.setTimeout(function(){$('#error'+action).hide();},1000*5);
	}
	
	
});
