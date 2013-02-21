$(document).ready(function(){

	
	$('#createTipoFuncionario').validate({
		rules:{
			descTipoFunc:{required:true},
			
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
