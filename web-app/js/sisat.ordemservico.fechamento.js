$(document).ready(function(){

	
	
	jQuery.validator.addMethod("notNull", function(value, element) {
		 console.log(value);
	        console.log(value.toUpperCase()==='NULL');
	    return value.toUpperCase()!=='NULL'  ;
	}, "Campo de preenchimento obrigat&oacute;rio.");
    
	$('#createForm').validate({
		rules:{
			"empresa.id":{notNull:true},
			"seguradora.id":{notNull:true},
			"bairro.id":{notNull:true},
			formaDeAcionamento:{notNull:true},
			numero:{required:true},
			segurado:{required:true},
			endereco:{required:true},
			cidade:{required:true},
			dataAcionamento:{required:true,date:true},
			dataAtendimento:{required:true,date:true},
			descServico:{required:true},
			previaInicial:{required:true},
			previaFinal:{required:true},
			"modalidade.id":{notNull:true},
			evento:{notNull:true}
			
			
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
	
	
	
	$('#datepickerSaida').datepicker({autoclose:true,language:'pt-BR'});
	$('#horaSaida').timepicker({
		showMeridian:false
	});
	
	
});
