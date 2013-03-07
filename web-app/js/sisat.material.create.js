$(document).ready(function(){

	
	$('#createMaterial').validate({
		rules:{
			descricao:{required:true},
			marca:{required:true},
			valorCompra:{required:true},
			valorVenda:{required:true},
			estoqueMinimo:{required:true},
			estoqueAtual::{required:true}
			
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
