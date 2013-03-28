$(document).ready(
		function() {

			var plotChartBars, plotAtendimentoPorModalidadeTotalChartBars;

			plotChartBars = function() {
				if (!!$('#atendimentosPorEmpresaTotal').val()) {
					var atendPorModalidade = JSON.parse($('#atendimentosPorEmpresaTotal').val());

					$.plot(".bars", atendPorModalidade, {
						series : {
							bars : {
								show : true,
								barWidth : 0.5,
								align : "center"
							}
						},
						xaxis : {
							show : false
						}
					});
				}

			};

			plotAtendimentoPorModalidadeTotalChartBars = function() {
				if (!!$('#atendimentoPorModalidadeTotal').val()) {
					var atendPorModalidade = JSON.parse($('#atendimentoPorModalidadeTotal').val());

					$.plot("#atendimentoPorModalidadeTotalbars",
							atendPorModalidade, {
								series : {
									bars : {
										show : true,
										barWidth : 0.5,
										align : "center"
									}
								},
								xaxis : {
									show : false
								}
							});
				}

			};

			plotChartBars();
			plotAtendimentoPorModalidadeTotalChartBars();

		});
