$(document).ready(function(){

	
	$('#createEmpresa').validate({
		rules:{
			nome:{required:true},
			cnpj:{required:true},
			contato:{required:true},
			endereco:{required:true},
			cep:{required:true},
			telefone1:{required:true}
			
		},
		errorClass: "help-inline",
		errorElement: "span",
		highlight:function(element, errorClass, validClass) {
			$(element).parents('.control-group').addClass('error');
		},
		unhighlight: function(element, errorClass, validClass) {
			$(element).parents('.control-group').removeClass('error');
		},
		ignore:""
	});
	
	$("#cep").mask("999999-999");
	
	$("#telefone1").mask("(99) 9999-9999");
	
	$("#telefone2").mask("(99) 9999-9999");
	
	$("#telefone3").mask("(99) 9999-9999");
	
	
});
