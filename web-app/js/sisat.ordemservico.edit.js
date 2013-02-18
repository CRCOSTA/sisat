$(document).ready(function(){

	
	$('#datepickerAcionamento').datepicker({defaultTime: 'value',autoclose:true,language:'pt-BR'});
	$('#datepickerAtendimento').datepicker({defaultTime: 'value',autoclose:true,language:'pt-BR'});
	
	$('#previaInicial').timepicker({defaultTime: 'value',
		showMeridian:false
	});
	
	$('#previaFinal').timepicker({defaultTime: 'value',
		showMeridian:false
	});

	
	$('#datepickerDataLote').datepicker({autoclose:true,language:'pt-BR'});
	
	
	
});
