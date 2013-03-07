
<%@ page import="model.EstoqueFuncionario"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Estoque de material do funcion&aacute;rio</title>
<link rel="stylesheet" href="${resource(dir:'css',file:'datepicker.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'sistat.atendimento.show.print.css')}" media="print" />

</head>
<body>

	<div id="content-header">
		<h1>Estoque de material do funcion&aacute;rio</h1>
		<div class="btn-group" style="width: auto;">
			<a class="btn btn-large tip-bottom" data-original-title="Imprimir" data-toggle="modal" id='btnPrint' onclick="window.print();"><i class="icon-print"></i></a>

		</div>
		

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Estoque funcion&aacute;rio</a> <a href="#" class="current">Pesquisa</a>
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
							<g:form action="list" method="post" class="form-horizontal">
								<div class="control-group">
									<label class="control-label">Funcion&aacute;rios</label>
									<div class="controls">
										<g:select name="funcionario.id" id="funcionarioId" from="${model.Funcionario.findAllByTipoFuncionarioNotAndAtivo(model.TipoFuncionario.get(1),true)}" optionKey="id"
											value="${funcionario?.id}" noSelection="${['null':'Selecionar...']}" style="width:260px" />
									</div>
								</div>
								<div class="form-actions">
									<button type="submit" class="btn btn-primary" name="pesquisar" value="pesquisar">
										<i class="icon-search icon-white"></i> Pesquisar
									</button>
									<g:if test="${funcionario?.id}">
									<a href="#modalmaterialadd" onclick="preparaTelaDeAdicao();" data-toggle="modal"  data-original-title="Incluir material na lista" class="btn btn-success">
										<i class="icon-plus icon-white"></i> Adicionar
									</a>
									</g:if>
								</div>
							</g:form>
						</div>

					</div>
				</div>

				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"> <i class="icon-list-alt"></i>
						</span>
						<h5>Lista de material</h5>
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered data-table">
							<thead>
								<tr>
									<th>ID</th>
									<th>Material</th>
									<th>Data de inclus&atilde;o </th>
									<th>Qtd</th>
									<th></th>

								</tr>
							</thead>
							<tbody>

								<g:each in="${estoqueFuncionarioInstanceList}" status="i" var="estoqueFuncionarioInstance">
									<tr>

										<td>
											${fieldValue(bean: estoqueFuncionarioInstance, field: "id")}
										</td>

										<td>
											${estoqueFuncionarioInstance.material.descricao}
										</td>

										<td><g:formatDate date="${estoqueFuncionarioInstance.dataInclusao}" format="dd/MM/yyyy" /></td>
										<td>
											${fieldValue(bean: estoqueFuncionarioInstance, field: "qtd")}
										</td>

										<td class="taskStatus"><g:link action="show" id="${estoqueFuncionarioInstance.id}" data-original-title="Dados da lista">
												<i class="icon-zoom-in"></i>
											</g:link></td>

									</tr>
								</g:each>

							</tbody>
						</table>
					</div>
				</div>


			</div>
		</div>
	</div>

	<g:render template="addMaterial" />

	<g:javascript library="bootstrap-datepicker" />
	<g:javascript library="locales/bootstrap-datepicker.pt-BR" />
	<g:javascript library="jquery.uniform" />
	<g:javascript library="jquery.ui.custom" />
	<g:javascript library="select2" />
	<g:javascript library="jquery.dataTables" />
	<g:javascript library="unicorn.tables" />
	<g:javascript library="jquery.uploadify-3.1" />
	<g:javascript library="jquery.validate" />
	<g:javascript library="sisat.estoqueFuncionario" />
	<g:javascript library="sisat.ordemservico.server" />




</body>
</html>

