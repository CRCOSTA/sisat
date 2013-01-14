$(document).ready(function(){

	
	var geocoder = new google.maps.Geocoder(), now = new Date();
	
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
	
	$('#confirmMapa').click(function() {
		 $("#create").removeAttr("disabled");
	});
	 
    $('#btnMapa').click(function() {
    	  var endereco,bairro,cidade,enderecoCompleto;
    	  bairro=$('#bairro').find(":selected").text();
    	  endereco=$('#endereco').val();
    	  cidade=$('#cidade').val();

    	  enderecoCompleto = endereco + " " + bairro.split("-")[0] +" "+ cidade;
    	  
    	  if (geocoder) {
    	      geocoder.geocode({ 'address': enderecoCompleto }, function (results, status) {
    	         if (status == google.maps.GeocoderStatus.OK) {
        	
    	            var latlng = results[0].geometry.location;
    	           
    	            $('#geometryLocation').attr('value',latlng.lat()+","+latlng.lng());
            	    
    	            var myOptions = {
    	              zoom: 20,
    	              center: latlng,
    	              mapTypeId: google.maps.MapTypeId.ROADMAP
    	            };
    	            var map = new google.maps.Map(document.getElementById("map_canvas"),
    	                myOptions);

    	            var marker = new google.maps.Marker({
    	                position: latlng, 
    	                map: map, 
    	                title:results[0].numero
    	            });   

    	            $('#map_canvas').show();

    	           
    	         }
    	         else {
    	            $('#map_canvas').html('N&atilde;o foi possivel encontrar endere&ccedil;o no mapa.')
    	            $('#map_canvas').show();
    	         }
    	      });
    	   }    

    	  
    	  
    });
    
	
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
