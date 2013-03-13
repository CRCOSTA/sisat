window.server={
		serverPath:'http://localhost:8080/SISAT/',
		addMaterialNoEstoque : function(){
			
			 if(!$('#materialForm').valid()) return;
			
			 $.post(this.serverPath + 'estoqueFuncionario/save',
					 $('#materialForm').serialize(), 
					 function(data) {
				 		
				 		$('#alertSuccessMaterial').show();
					 }).fail(function(error) {
						 $('#errorMaterial').show();
						 
				 	 });
		},
		enviarPagamento : function(){
			
			 if(!$('#enviarPagamento').valid()) return;
			
			 $.post(this.serverPath + 'ordemServico/enviarPagamento',
					 $('#enviarPagamento').serialize(), 
					 function(data) {
				 		var idAtend=$('#enviarPagamentoId').val();
				 		window.showSuccessMsg(idAtend,'Atendimento adicionado em lota com sucesso.');
				 		window.trocaStatus("aguardando pagamento","label label-aguardando_pagamento",idAtend);
				 		window.prepararActions(idAtend,'aguardando_pagamento');
				 		
				 		$('#modalenviarPagamento').hide();
				 
					 });
		},
		prepararFormMaterial : function(idAtend){
			
			$('#materialForm')[0].reset();
			$("#selectMaterial").select2('destroy')
			 $.post(this.serverPath + 'movimentacaoDeMaterial/getMaterialList',
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
			
		},
		addMaterial : function(idAtend){
			
			if(!$('#materialForm').valid()) return;
			
			var quantidade=$('#quantidade').val()*(-1), descricao='Codigo da autorizacao -->' + Math.floor(Math.random()*101010),
				dados= {id:idAtend,
					tipo:'Saida',
					'listMaterial.id':$('#selectMaterial').select2('val'),
					'descricao':descricao,
					quantidade:quantidade
					};
			
			 $.post(this.serverPath + 'movimentacaoDeMaterial/saveAjax',
					 dados, 
					 function(data) {  
				 		showSuccessMsg(idAtend,'Material adicionado com sucesso.');
						linha = '<tr><td>'+ descricao+'</td><td>'+$('#selectMaterial').select2('data').materialDesc+ '</td><td>'+ quantidade*(-1) +'</td></tr>';
						
						$('#materiais'+idAtend).append(linha);
						
						$('#modalmaterial').hide();
				 		
				 		}).fail(function(error) {
					 		window.showErrorMsg("Material","Erro ao adicionar material");
					 	});
			
			
		},
		encaminharParaTecnico : function(){
			var nomeTecnico=$('#funcionario :selected').text();
			
			if(!$('#encaminhar').valid()) return;
			
			 $.post(this.serverPath + 'ordemServico/encaminharParaTecnico',
					 $('#encaminhar').serialize(), 
					 function(data) {  
				 		var idAtend = $('#encaminharId').val();
				 		window.showSuccessMsg(idAtend,'Atendimento encaminhado com sucesso.');
				 		$('#modalEncaminhar').hide();
				 		$('#nomefuncionario'+idAtend).html(nomeTecnico);
				 		window.trocaStatus("com o tecnico","label label-com_o_tecnico",idAtend);
				 		window.prepararActions(idAtend,'com_o_tecnico');
				 	 }).fail(function(error) {
				 		window.showErrorMsg("Encaminhar","Erro ao encaminhar atendimento");
				 	 });
		},
		validarSenha : function(){
			
			if(!$('#validarSenha').valid()) return;
			
			 $.post(this.serverPath + 'ordemServico/validarSenha',
					 $('#validarSenha').serialize(), 
					 function(data) {  
				 		var idAtend = $('#validarSenhaId').val();
				 		window.showSuccessMsg(idAtend,'Senha validada com sucesso.');
				 		$('#modalValidar').hide();
				 		window.trocaStatus("senha validada","label label-senha_validada",idAtend);
				 		window.prepararActions(idAtend,'senha_validada');
				 	}).fail(function(error) {
				 		window.showErrorMsg("Validar","Erro ao validar senha");
				 	});
		},
		gravarSaida : function(idAtend){
			
			 $.post(this.serverPath + 'ordemServico/gravarSaida',
					 {id:idAtend}, 
					 function(data) {  
				 		console.log(data);
				 	}).fail(function(error) {
				 		console.error(data);
				 	});
		},
		gravarHistorico : function(){
			
			if(!$('#historico').valid()) return;

			$.post(this.serverPath + 'historicoAtendimento/save',
					 $('#historico').serialize(), 
					 function(data) {  
				 		var d,linha, idAtend = $('#historicoId').val();
				 			window.showSuccessMsg(idAtend,'Hist&oacute;rico adicionado com sucesso.');
				 			$('#modalHistorico').hide();
				 			
				 			d=new Date(data.dataHora);
				 			dataStr = d.getDate() + '/' + (d.getMonth()+1) + '/' + d.getFullYear() + ' ' + d.getHours() + ':'+ d.getMinutes()
				 		
				 			linha = '<tr><td>'+dataStr+'</td><td>'+data.analistaUSS+'</td><td>'+data.historico+'</td></tr>';
				 		
				 			$('#historicoPlace'+idAtend).append(linha);
				 		
				 		}).fail(function(error) {
					 		window.showErrorMsg("Historico","Erro ao gravar hist&oacute;rico.");
					 	});
		},
		fecharAtendimento : function(){
			
  			 if(!$('#fechamento').valid()) return;
			
			 $.post(this.serverPath + 'ordemServico/fecharAtendimento',
					 $('#fechamento').serialize(), 
					 function(data) {  
				 		var idAtend = $('#fechamentoId').val();
				 		window.showSuccessMsg(idAtend,'Atendimento fechado com sucesso.');
				 		$('#modalfechamento').hide();
				 		window.trocaStatus("fechada","label label-fechada",idAtend);
				 		window.prepararActions(idAtend,'fechada');
				 		
				 		}).fail(function(error) {
					 		window.showErrorMsg("Fechamento","Erro ao fechar atendimento");
					 	});
		},
		receberOrdem : function(idAtend){
			 $.post(this.serverPath + 'ordemServico/receberOS',
					 {id:idAtend}, 
					 function(data) {  
						 showSuccessMsg(idAtend,'Checklist recebido com sucesso.');
				 		$('#osNumeroPlace'+idAtend).append('<i class=icon-flag></i>');
					 });
		}
}