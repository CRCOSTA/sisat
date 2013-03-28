
<%@ page import="model.OrdemServico"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Relat&aacute;orio de Atendimentos</title>
<link rel="stylesheet" href="${resource(dir:'css',file:'datepicker.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'timepicker.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uploadify.css')}" />

</head>
<body>

	<div id="content-header">
		<h1>Relat&oacute;rio de atendimentos por empresa</h1>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Relat&oacute;orio</a> <a href="#" class="current">Relat&oacute;orio por empresa</a>
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
							<g:form action="totalAtendimentos" method="post" class="form-horizontal">

								<div class="control-group">
									<div class="span4">
										<label class="control-label">Data Inicio</label>
										<div class="controls">


											<div class="input-append date" id="datepickerInicio" data-date="${params.dateIni}" data-date-format="dd/mm/yyyy">
												<input type="text" id="inicio" name="inicio" value="${params.dateIni}" class="span2" style="width: 90px;" readonly /> <span class="add-on"><i class="icon-th"></i></span>
											</div>

										</div>
									</div>
									<div class="span4">
										<label class="control-label"> Data Fim</label>
										<div class="controls">
											<div class="input-append date" id="datepickerFinal" data-date="${params.dateFim}" data-date-format="dd/mm/yyyy">
												<input type="text" name="final" id="final" class="span2" value="${params.dateFim}" style="width: 90px;" readonly /> <span class="add-on"><i class="icon-th"></i></span>
											</div>

										</div>
									</div>
									<div class="span4"></div>
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
				<g:if test="${totalGeral>0}">
				
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"><i class="icon-signal"></i></span>
							<h5>Atendimentos por Empresa</h5>
							<div class="buttons">
								<a href="#collapseChart" data-toggle="collapse"><i class="icon-minus"></i></a>
							</div>
						</div>
						<div class="collapse in" id="collapseChart">
							<div class="widget-content">
								<div class="row-fluid">
									<div class="bars"></div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-list-alt"></i>
							</span>
							<h5>Total de Atendimentos Por Periodo</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th>Empresa</th>
										<th>Quantidade</th>
										<g:each in="${statusList}" var="status">
											<th>
												${status}
											</th>
										</g:each>

									</tr>
								</thead>
								<tbody>
									<g:each in="${empresas}" var="empresa">
										<tr>
											<td>
												${empresa.nome}
											</td>

											<td style="text-align: right">
												${totalPorEmpresaMap.get(empresa.nome)}

											</td>

											<g:set var="porStatusList" value="${todosOsStatus.get(empresa.nome)}" scope="page" />

											<g:each in="${statusList}" var="status">
												<td style="text-align: right">
													${porStatusList?.get(status)}
												</td>


											</g:each>

										</tr>
									</g:each>
								<tfoot>
									<tr class="odd">
										<td>Total</td>
										<td style="text-align: right; font-weight: bold;">
											${totalGeral}

										</td>
										<g:each in="${statusList}" var="status">
											<td style="text-align: right; font-weight: bold;">
												${totalGeralPorStatus?.get(status)}
											</td>


										</g:each>


									</tr>

									<tr class="odd">
										<td>Percentual</td>
										<td style="text-align: right; font-weight: bold;">100%</td>
										<g:each in="${statusList}" var="status">
											<td style="text-align: right; font-weight: bold;"><g:formatNumber number="${(totalGeralPorStatus?.get(status)/totalGeral)*100}" type="number" maxFractionDigits="2" /> %</td>


										</g:each>


									</tr>
								</tfoot>
								</tbody>
							</table>
						</div>
					</div>

					



				</g:if>
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
	<g:javascript library="sisat.relatorio" />




</body>
</html>

