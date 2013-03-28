
<%@ page import="model.OrdemServico"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Relat&oacute;rio de Atendimentos</title>
<link rel="stylesheet" href="${resource(dir:'css',file:'datepicker.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'timepicker.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uploadify.css')}" />

</head>
<body>

	<div id="content-header">
		<h1>Relat&oacute;rio de atendimentos por modalidade</h1>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Relat&oacute;orio</a> <a href="#" class="current">Relat&oacute;orio por
			modalidade</a>
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
							<g:form action="totalAtendimentosPorModalidade" method="post" class="form-horizontal">

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
							<h5>Atendimentos por modalidade</h5>
							<div class="buttons">
								<a href="#collapseChart" data-toggle="collapse"><i class="icon-minus"></i></a>
							</div>
						</div>
						<div class="collapse in" id="collapseChart">
							<div class="widget-content">
								<div class="row-fluid">
									<div id="atendimentoPorModalidadeTotalbars" class= "bars"></div>
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
										<th>Modalidade</th>
										<th>Quantidade</th>
										<th>%</th>
										<g:each in="${empresaList}" var="empresa">
											<th>
												${empresa}
											</th>
										</g:each>

									</tr>
								</thead>
								<tbody>
									<g:each in="${modalidades}" var="modalidade">
										<tr>
											<td>
												${modalidade}
											</td>

											<td style="text-align: right">
												${totalPorModalidadeMap.get(modalidade.descricao)}

											</td>

											<td style="text-align: right"><g:formatNumber number="${(totalPorModalidadeMap.get(modalidade.descricao)/totalGeral)*100}" type="number" maxFractionDigits="2" /> %</td>

											<g:set var="porEmpresaList" value="${todasAsEmpresas.get(modalidade.descricao)}" scope="page" />

											<g:each in="${empresaList}" var="empresa">
												<td style="text-align: right">
													${porEmpresaList?.get(empresa.nome)}
												</td>


											</g:each>

										</tr>
									</g:each>
								<tfoot>
									<tr>
										<td>Total</td>
										<td style="text-align: right; font-weight: bold;">
											${totalGeral}

										</td>
										<td style="text-align: center; font-weight: bold;">-</td>
										<g:each in="${empresaList}" var="empresa">
											<td style="text-align: right; font-weight: bold;">
												${totalGeralPorEmpresa?.get(empresa.nome)}
											</td>


										</g:each>


									</tr>

									<tr>
										<td>Percentual</td>
										<td style="text-align: right; font-weight: bold;">100%</td>
										<td style="text-align: right; font-weight: bold;">100%</td>
										<g:each in="${empresaList}" var="empresa">
											<td style="text-align: right; font-weight: bold;"><g:formatNumber number="${(totalGeralPorEmpresa?.get(empresa.nome)/totalGeral)*100}" type="number" maxFractionDigits="2" /> %</td>


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

	<g:hiddenField name="atendimentoPorModalidadeTotal" id="atendimentoPorModalidadeTotal" value="${atendimentoPorModalidadeTotal}" />

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

