<html>
<head>
<title>Home</title>
<meta name="layout" content="logged" />
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
</head>
<body>
	<div id="content-header">

		<div class="row-fluid">
			<div class="span12 center" style="text-align: center;">
				<ul class="stat-boxes">
					<li>
						<div class="left peity_bar_good" title="Realizados por dia ${mesAtual }/ ${anoAtual }">
							<span> ${fechadosPorDia }
							</span>
							<g:formatNumber number="${(totalFechada/totalGeral)*100}" type="number" maxFractionDigits="2" />
							%
						</div>
						<div class="right">
							<strong> ${totalFechada}
							</strong> Realizados
						</div>
					</li>
					<li>
						<div class="left peity_bar_neutral" title="Cancelados por dia  ${mesAtual }/ ${anoAtual }">
							<span> ${canceladosPorDia }
							</span>
							<g:formatNumber number="${(totalCancelado/totalGeral)*100}" type="number" maxFractionDigits="2" />
							%
						</div>
						<div class="right">
							<strong> ${totalCancelado}
							</strong> Cancelados
						</div>
					</li>
					<li>
						<div class="left peity_bar_bad" title="Visitas por dia  ${mesAtual }/ ${anoAtual }">
							<span> ${visitasPorDia }
							</span>
							<g:formatNumber number="${(totalVisita/totalGeral)*100}" type="number" maxFractionDigits="2" />
							%
						</div>
						<div class="right">
							<strong> ${totalVisita}
							</strong> Visitas
						</div>
					</li>
					<li>
						<div class="left peity_bar_good" title="Realizados por dia ${mesAtual }/ ${anoAtual }">
							<span> ${totalGeralPorDia }
							</span> 100%
						</div>
						<div class="right">
							<strong> ${totalGeral}
							</strong> Total Geral
						</div>
					</li>

				</ul>
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span6">
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"><i class="icon-signal"></i></span>
						<h5>
							Atendimentos por modalidade -
							${mesAtual }/
							${anoAtual }
						</h5>
						<div class="buttons">
							<a href="#collapseStatistic" data-toggle="collapse" id="collapse1"><i class="icon-minus"></i></a>
						</div>
					</div>
					<div class="collapse in" id="collapseStatistic">
						<div class="widget-content">
							<div class="row-fluid">
								<ul class="site-stats">
									<li><i class="icon-tasks"></i> <strong> ${eletricaTotal}
									</strong> <small>El&eacute;trica</small></li>
									<li><i class="icon-tasks"></i> <strong> ${hidraulicaTotal}
									</strong> <small>Hidr&aacute;ulica</small></li>
									<li><i class="icon-tasks"></i> <strong> ${vidraceiroTotal}
									</strong> <small>Vidraceiro</small></li>
									<li><i class="icon-tasks"></i> <strong> ${limpezaTotal }
									</strong> <small>Limpeza de caixa d'&aacute;gua</small></li>
									<li><i class="icon-tasks"></i> <strong> ${manutencaoTotal }
									</strong> <small>Manuten&ccedil;&atilde;o geral(or&ccedil;amento)</small></li>
								</ul>
							</div>
						</div>
					</div>
				</div>


			</div>
			<div class="span6">
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"><i class="icon-signal"></i></span>
						<h5>
							Atendimentos por funcionario -
							${mesAtual }/
							${anoAtual }
						</h5>
						<div class="buttons">
							<a href="#collapseChart" data-toggle="collapse"><i class="icon-minus"></i></a>
						</div>
					</div>
					<div class="collapse in" id="collapseChart">
						<div class="widget-content">
							<div class="row-fluid">
								<div class="pie"></div>
							</div>
						</div>
					</div>
				</div>


			</div>
		</div>


		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"><i class="icon-list-alt"></i></span>
						<h5>
							Planilha di&aacute;ria de atendimento -
							<g:formatDate date="${dia}" format="dd/MM/yyyy" />
							-
							${totalDiario}
							Atendimentos

						</h5>
						<div class="buttons">
							<a href="#collapseTable" data-toggle="collapse"><i class="icon-minus"></i></a>
						</div>
						<g:each in="${statusList}" var="status">
							<g:set var="totalPorStatus" value="${totalAtendimentosPorStatusDia.get(status)}" />
							<span class="label tip-bottom label-${status.replace(' ','_')}" title="${status}">
								${totalPorStatus[0]}
							</span>
						</g:each>


					</div>
					<div class="collapse in" id="collapseTable">
						<div class="widget-content nopadding">
							<table class="table table-bordered table-striped">
								<thead>
									<tr>
										<th></th>
										<g:each in="${funcionarioInstanceList}" status="i" var="funcionarioInstance">
											<th>
												${funcionarioInstance.login}
											</th>
										</g:each>

									</tr>
								</thead>
								<tbody>
									<tr>
										<td>Manh&atilde;</td>

										<g:each in="${funcionarioInstanceList}" status="i" var="funcionarioInstance2">

											<g:set var="ordensPorFuncionarioMapInstance" value="${ordensPorFuncionarioManhaMap.get(funcionarioInstance2.nome)}" />
											<td><g:each in="${ordensPorFuncionarioMapInstance}" var="ordemServicoInstanceList">

													<g:each in="${ordemServicoInstanceList}" var="ordemServicoInstance">
													
														<g:render template="/ordemServico/modalAtendimento" bean="${ordemServicoInstance}" var="ordemServicoInstance" />
													
														<br>
														
														<input type="hidden" id="statusAtendimento${ordemServicoInstance.id}" value="${ordemServicoInstance.cssStatusColor}">
			                       					  	<a href="#myModal${ordemServicoInstance.id}" onclick="prepararActions(${ordemServicoInstance.id},$('#statusAtendimento${ordemServicoInstance.id}').val())" data-toggle="modal"  data-original-title="Dados do atendimento">
															<span class="label label-${ordemServicoInstance.cssStatusColor}">de ${ordemServicoInstance.previaInicial} até ${ordemServicoInstance.previaFinal} <br> ${ordemServicoInstance.numero}/${ordemServicoInstance.barra}</span>
															<br>
			                       					  	</a>

													</g:each>


												</g:each></td>
										</g:each>

									</tr>

									<tr>
										<td>Tarde</td>

										<g:each in="${funcionarioInstanceList}" status="i" var="funcionarioInstance2">

											<g:set var="ordensPorFuncionarioMapInstance" value="${ordensPorFuncionarioTardeMap.get(funcionarioInstance2.nome)}" />
											<td><g:each in="${ordensPorFuncionarioMapInstance}" var="ordemServicoInstanceList">

													<g:each in="${ordemServicoInstanceList}" var="ordemServicoInstance">
													
														<g:render template="/ordemServico/modalAtendimento" bean="${ordemServicoInstance}" var="ordemServicoInstance" />
													
														<br>
														<input type="hidden" id="statusAtendimento${ordemServicoInstance.id}" value="${ordemServicoInstance.cssStatusColor}">
			                       					  	<a href="#myModal${ordemServicoInstance.id}" onclick="prepararActions(${ordemServicoInstance.id},$('#statusAtendimento${ordemServicoInstance.id}').val())" data-toggle="modal"  data-original-title="Dados do atendimento">
															<span class="label label-${ordemServicoInstance.cssStatusColor}">de ${ordemServicoInstance.previaInicial} até ${ordemServicoInstance.previaFinal} <br> ${ordemServicoInstance.numero}/${ordemServicoInstance.barra}</span>
															<br>
			                       					  	</a>


													</g:each>


												</g:each></td>
										</g:each>

									</tr>

									<tr>
										<td>Noite</td>

										<g:each in="${funcionarioInstanceList}" status="i" var="funcionarioInstance2">

											<g:set var="ordensPorFuncionarioMapInstance" value="${ordensPorFuncionarioNoiteMap.get(funcionarioInstance2.nome)}" />
											<td><g:each in="${ordensPorFuncionarioMapInstance}" var="ordemServicoInstanceList">

													<g:each in="${ordemServicoInstanceList}" var="ordemServicoInstance">
														
														<g:render template="/ordemServico/modalAtendimento" bean="${ordemServicoInstance}" var="ordemServicoInstance" />
														
														<br>
														<input type="hidden" id="statusAtendimento${ordemServicoInstance.id}" value="${ordemServicoInstance.cssStatusColor}">
			                       					  	<a href="#myModal${ordemServicoInstance.id}" onclick="prepararActions(${ordemServicoInstance.id},$('#statusAtendimento${ordemServicoInstance.id}').val())" data-toggle="modal"  data-original-title="Dados do atendimento">
															<span class="label label-${ordemServicoInstance.cssStatusColor}">de ${ordemServicoInstance.previaInicial} até ${ordemServicoInstance.previaFinal} <br> ${ordemServicoInstance.numero}/${ordemServicoInstance.barra}</span>
															<br>
			                       					  	</a>


													</g:each>


												</g:each></td>
										</g:each>

									</tr>
								</tbody>
								<tfoot>
									<tr>
										<td>Total</td>
										<g:each in="${funcionarioInstanceList}" var="funcionarioInstance2">

											<g:set var="totalPorFunc" value="${totalOrdensPorFuncionarioMap.get(funcionarioInstance2.nome)}" />
											<td style="text-align: center; font-weight: bold;">
												${totalPorFunc} <br>
											</td>

										</g:each>

									</tr>
								</tfoot>
							</table>

						</div>
					</div>
				</div>

			</div>
		</div>

		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"><i class="icon-globe"></i></span>
						<h5>Mapa di&aacute;rio de atendimento - 18/12/2012</h5>
						<div class="buttons">
							<a href="#collapseMap" data-toggle="collapse"><i class="icon-minus"></i></a>
						</div>
					</div>
					<div class="collapse in" id="collapseMap">
						<div class="widget-content" id="map_canvas" style="height: 500px;"></div>
					</div>
				</div>
			</div>
		</div>


	</div>
	<g:hiddenField name="funcionarioAtendimentos" id="funcionarioAtendimentos" value="${atendimentosPorFuncionarioTotal}" />
	



	<g:render template="/ordemServico/encaminhar" />
	<g:render template="/ordemServico/validarSenha" />
	<g:render template="/ordemServico/historicoAtendimento" />
	<g:render template="/ordemServico/fechamento" />
	<g:render template="/ordemServico/uploadFoto" />
	<g:render template="/ordemServico/movimentaMaterial" />
	<g:render template="/ordemServico/enviarPagamento" />

	<g:javascript library="jquery.flot" />
	<g:javascript library="jquery.flot.pie" />
	<g:javascript library="jquery.peity.min" />
	<g:javascript library="unicorn.dashboard" />
	<g:javascript library="sisat.home" />
	<g:javascript library="bootstrap-datepicker" />
	<g:javascript library="locales/bootstrap-datepicker.pt-BR" />
	<g:javascript library="bootstrap-timepicker" />
	<g:javascript library="jquery.uniform" />
	<g:javascript library="jquery.ui.custom" />
	<g:javascript library="select2" />
	<g:javascript library="jquery.dataTables" />
	<g:javascript library="unicorn.tables" />
	<g:javascript library="jquery.uploadify-3.1" />
	<g:javascript library="jquery.validate" />
	<g:javascript library="sisat.ordemservico.filtros.validation" />
	<g:javascript library="sisat.ordemservico.filtros" />
	<g:javascript library="sisat.ordemservico.server" />







</body>
</html>
