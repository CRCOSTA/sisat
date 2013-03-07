$(document).ready(function(){

	$('select').select2();
	
	jQuery.validator.addMethod("notNull", function(value, element) {
		 console.log(value);
	        console.log(value.toUpperCase()==='NULL');
	    return value.toUpperCase()!=='NULL'  ;
	}, "Campo de preenchimento obrigat&oacute;rio.");
   
	
	$('#createSeguradora').validate({
		rules:{
			nome:{required:true},
			"empresa.id":{notNull:true}
			
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
