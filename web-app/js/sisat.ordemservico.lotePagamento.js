$(document).ready(function(){
	
	
	$('#datepickerDataPagamento').datepicker({autoclose:true,language:'pt-BR'});

	
	$('#formLiquidacaoPagamento').validate({
		rules:{
			numeroLotePagamento:{required:true}
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
