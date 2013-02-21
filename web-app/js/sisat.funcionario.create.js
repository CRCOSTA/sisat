$(document).ready(function(){

	$('input[type=checkbox],input[type=radio]').uniform();
	
	$('select').select2();
	
	jQuery.validator.addMethod("notNull", function(value, element) {
		 console.log(value);
	        console.log(value.toUpperCase()==='NULL');
	    return value.toUpperCase()!=='NULL'  ;
	}, "Campo de preenchimento obrigat&oacute;rio.");
   
	
	$('#createFuncionario').validate({
		rules:{
			'empresa.id':{notNull:true},
	'tipoFuncionario.id':{notNull:true},
			nome:{required:true},
			email:{required:true,email:true},
			celular:{required:true},
			login:{required:true},
			senha:{required:true}
			
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
	
	$("#celular").mask("(99) 9999-9999");
	
	$("#telefone").mask("(99) 9999-9999");
	
	$("#telefone3").mask("(99) 9999-9999");
	
	
});
