$(document).ready(function(){
	now = new Date();
	
	$('select').select2();
	
	$('#datepickerDataMovimentacao').datepicker({autoclose:true,language:'pt-BR'});
	$('#dataMovimentacao').val(now.getDate()+'/'+(now.getMonth()+1)+'/'+now.getFullYear());
	
	jQuery.validator.addMethod("notNull", function(value, element) {
		 console.log(value);
	        console.log(value.toUpperCase()==='NULL');
	    return value.toUpperCase()!=='NULL'  ;
	}, "Campo de preenchimento obrigat&oacute;rio.");
	
	$('#entradaDeMaterial').validate({
		rules:{
			dataInclusao:{required:true},
			"material.id":{notNull:true},
			qtd:{required:true}
			
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
		
	
});
