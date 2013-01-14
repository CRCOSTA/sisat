 $(document).ready(function() {
	 
	 var plotChart = function(){
		 var data = [];
			var series = Math.floor(Math.random()*10)+1;
			for( var i = 0; i<series; i++)
			{
				data[i] = { label: "Series"+(i+1), data: Math.floor(Math.random()*100)+1 }
			}
			
		    var pie = $.plot($(".pie"), data,{
		        series: {
		            pie: {
		                show: true,
		                radius: 3/4,
		                label: {
		                    show: true,
		                    radius: 3/4,
		                    formatter: function(label, series){
		                        return '<div style="font-size:8pt;text-align:center;padding:2px;color:white;">'+label+'<br/>'+Math.round(series.percent)+'%</div>';
		                    },
		                    background: {
		                        opacity: 0.5,
		                        color: '#000'
		                    }
		                },
		                innerRadius: 0
		            },
					legend: {
						show: false
					}
				}
			});
	 };

		        var statusColors = {"aberta":"red","com_o_tecnico":"yellow","senha_validada":"cornflowerblue","visita_perdida":"lightslategray","fechada":"green","cancelado":"black"};

	        	var lstOrdemServicoGeoLocalizada = [];//JSON.parse($('#lstOrdem').val());
	        	  
	        	 var rioLocation = new google.maps.LatLng(-22.9035393,-43.20958689999998);

	        	 var myOptions = {
	       	              zoom: 12,
	       	           	  center:rioLocation,
	       	              mapTypeId: google.maps.MapTypeId.ROADMAP
	       	            };

		         Window.map = new google.maps.Map(document.getElementById("map_canvas"),
	         	                myOptions);
		     	 var markers  = new Array();
		     	
		         for(i=0;i<lstOrdemServicoGeoLocalizada.length;i++){

		         	var mark1_latlong = JSON.parse("["+ lstOrdemServicoGeoLocalizada[i].geometryLocation+"]");

		         	var mark1 = new google.maps.LatLng(mark1_latlong[0],mark1_latlong[1]);
		         	
					var statusColor = statusColors[ lstOrdemServicoGeoLocalizada[i].status.replace(' ','_').replace(' ','_')];
					
		         	var symbol = {
		         			  path: google.maps.SymbolPath.BACKWARD_CLOSED_ARROW,
		         			  fillColor: statusColor,
		         			  fillOpacity: 1,
		         			  scale: 8,
		         			  strokeColor: statusColor,
		         			  strokeWeight: 1
		         			};
		         
		         	markers[i] = new google.maps.Marker({
	  	                position:mark1, 
	  	                clickable:true,
	  	                map: Window.map, 
	  	                icon:symbol,
	  	                title:"Atendimento:\t"+lstOrdemServicoGeoLocalizada[i].numero + "/" + lstOrdemServicoGeoLocalizada[i].barra +"\nPrevia:\t\t"+lstOrdemServicoGeoLocalizada[i].previaInicial + " ate " + lstOrdemServicoGeoLocalizada[i].previaFinal,
	  	                link:'/controle/ordemServico/listOne/'+lstOrdemServicoGeoLocalizada[i].id
	  	                
	  	            });  
		         	 google.maps.event.addListener(markers[i], 'click', function(){
			         	 location.href=this.link;
	  	                });
		         }
	  	             
	  	         plotChart();
		         
	        	

	        });
 
 
 
 