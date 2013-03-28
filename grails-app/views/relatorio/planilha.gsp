
<%@ page import="model.OrdemServico"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Planilha de agendamentos</title>
<link rel="stylesheet" href="${resource(dir:'css',file:'datepicker.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'timepicker.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uploadify.css')}" />

</head>
<body>

	<div id="content-header">
		<h1>Planilha de agendamentos</h1>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Relat&oacute;orio</a> <a href="#" class="current">Planilha de agendamentos</a>
	</div>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">

				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"> <i class="icon-filter"></i>
						</span>
						<h5>Campos para pesquisa</h5>
						<div class="buttons">
							<a href="#collapseFiltros" data-toggle="collapse" id="collapseFiltro"><i class="icon-minus"></i></a>
						</div>
					</div>
					<div class="collapse in" id="collapseFiltros">
						<div class="widget-content nopadding">
							<g:form action="planilha" method="post" id="consulta" class="form-horizontal">

								<div class="control-group">
									<div class="span4">
										<label class="control-label">Data</label>
										<div class="controls">


											<div class="input-append date" id="datepickerInicio" data-date="${params.inicio}" data-date-format="dd/mm/yyyy">
												<input type="text" id="inicio" name="inicio" value="${params.inicio}" class="span2" style="width: 90px;" readonly /> <span class="add-on"><i class="icon-th"></i></span>
											</div>

										</div>
									</div>

								</div>

								<div class="form-actions">
									<button type="submit" class="btn btn-primary" name="pesquisar" value="pesquisar">
										<i class="icon-search icon-white"></i> Pesquisar
									</button>
								</div>
							</g:form>
						</div>

					</div>
				</div>
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"><i class="icon-list-alt"></i></span>
						<h5>
							Planilha di&aacute;ria de atendimento -
							<g:formatDate date="${dia}" format="dd/MM/yyyy" />


						</h5>
						<div class="buttons">
							<a href="#collapseTable" data-toggle="collapse"><i class="icon-minus"></i></a>
						</div>
						<g:each in="${statusList}" var="status">
							<g:set var="totalPorStatus" value="${totalAtendimentosPorStatusDia.get(status)}" />
							<span class="label tip-bottom label-${status.replace(' ','_')}" title="${status}"> ${totalPorStatus[0]}
							</span>
						</g:each>
						<span class="label tip-bottom label-important"> ${	totalDiario } Atendimentos
						</span>
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
														<a href="#myModal${ordemServicoInstance.id}" onclick="prepararActions(${ordemServicoInstance.id},$('#statusAtendimento${ordemServicoInstance.id}').val())" data-toggle="modal"
															data-original-title="Dados do atendimento"> <span class="label label-${ordemServicoInstance.cssStatusColor}">de ${ordemServicoInstance.previaInicial} até ${ordemServicoInstance.previaFinal}
																<br> ${ordemServicoInstance.numero}/${ordemServicoInstance.barra}</span> <br>
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
														<a href="#myModal${ordemServicoInstance.id}" onclick="prepararActions(${ordemServicoInstance.id},$('#statusAtendimento${ordemServicoInstance.id}').val())" data-toggle="modal"
															data-original-title="Dados do atendimento"> <span class="label label-${ordemServicoInstance.cssStatusColor}">de ${ordemServicoInstance.previaInicial} até ${ordemServicoInstance.previaFinal}
																<br> ${ordemServicoInstance.numero}/${ordemServicoInstance.barra}</span> <br>
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
														<a href="#myModal${ordemServicoInstance.id}" onclick="prepararActions(${ordemServicoInstance.id},$('#statusAtendimento${ordemServicoInstance.id}').val())" data-toggle="modal"
															data-original-title="Dados do atendimento"> <span class="label label-${ordemServicoInstance.cssStatusColor}">de ${ordemServicoInstance.previaInicial} até ${ordemServicoInstance.previaFinal}
																<br> ${ordemServicoInstance.numero}/${ordemServicoInstance.barra}</span> <br>
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
	</div>

	<g:hiddenField name="atendimentosPorEmpresaTotal" id="atendimentosPorEmpresaTotal" value="${atendimentosPorEmpresaTotal}" />

	<g:javascript library="jquery.flot" />
	<g:javascript library="jquery.flot.categories" />
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

