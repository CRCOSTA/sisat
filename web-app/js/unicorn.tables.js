/**
 * Unicorn Admin Template
 * Diablo9983 -> diablo9983@gmail.com
**/
$(document).ready(function(){
	
	$('.data-table').dataTable({
		"bJQueryUI": true,
		"sPaginationType": "full_numbers",
		"sDom": '<""l>t<"F"fp>',
		"oLanguage":{
		    "sProcessing":   "Processando...",
		    "sLengthMenu":   "Mostrar _MENU_ registros",
		    "sZeroRecords":  "N&atilde;o foram encontrados resultados",
		    "sInfo":         "Mostrando de _START_ atŽ _END_ de _TOTAL_ registros",
		    "sInfoEmpty":    "Mostrando de 0 at&eacute; 0 de 0 registros",
		    "sInfoFiltered": "(filtrado de _MAX_ registros no total)",
		    "sInfoPostFix":  "",
		    "sSearch":       "Buscar:",
		    "sUrl":          "",
		    "oPaginate": {
		        "sFirst":    "Primeiro",
		        "sPrevious": "Anterior",
		        "sNext":     "Seguinte",
		        "sLast":     "&Uacute;ltimo"
		    }
		}
	});
	
	$('input[type=checkbox],input[type=radio],input[type=file]').uniform();
	
	$('select').select2();
	
	$("span.icon input:checkbox, th input:checkbox").click(function() {
		var checkedStatus = this.checked;
		var checkbox = $(this).parents('.widget-box').find('tr td:first-child input:checkbox');		
		checkbox.each(function() {
			this.checked = checkedStatus;
			if (checkedStatus == this.checked) {
				$(this).closest('.checker > span').removeClass('checked');
			}
			if (this.checked) {
				$(this).closest('.checker > span').addClass('checked');
			}
		});
	});	
});
