$(document).ready(function(){

	
	$('#datepickerAcionamento').datepicker({autoclose:true,language:'pt-BR'});
	$('#datepickerAtendimento').datepicker({autoclose:true,language:'pt-BR'});
	$('#dataAcionamento').val(now.getDate()+'/'+(now.getMonth()+1)+'/'+now.getFullYear());
	$('#dataAtendimento').val(now.getDate()+'/'+(now.getMonth()+1)+'/'+now.getFullYear());
	
	$('#previaInicial').timepicker({
		showMeridian:false
	});
	
	$('#previaFinal').timepicker({
		showMeridian:false
	});
	
	
});
