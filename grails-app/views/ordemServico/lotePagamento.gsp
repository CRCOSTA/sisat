
<%@ page import="model.OrdemServico"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Lotes de pagamento</title>

<link rel="stylesheet" href="${resource(dir:'css',file:'datepicker.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'timepicker.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />

</head>
<body>
	<div id="content-header">
		<h1>Lotes de pagamento</h1>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Atendimentos</a> <a href="#" class="current">Lotes de pagamento</a>
	</div>

	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<g:hasErrors bean="${ordemServicoInstance}">
					<div class="alert alert-error">
						<button class="close" data-dismiss="alert">×</button>
						<strong>Erro!</strong> <br>
						<g:renderErrors bean="${ordemServicoInstance}" as="list" />
					</div>
				</g:hasErrors>
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
							<g:form action="lotePagamento" name="formLotePagamento" method="post" class="form-horizontal">

								<div class="control-group">
									<label class="control-label">Data Lote</label>
									<div class="controls">


										<div class="input-append date" id="datepickerDataPagamento" data-date="${params.dataPagamento}" data-date-format="dd/mm/yyyy">
											<input type="text" id="dataPagamento" name="dataPagamento" class="span2"  value="${params.dataPagamento}" style="width: 90px;" readonly /> <span class="add-on"><i class="icon-th"></i></span>
										</div>

									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Empresa</label>
									<div class="controls">
										<g:select style="width:250px" name="empresa" from="${model.Empresa.list()}" optionKey="id" value="${params.empresa}" noSelection="${['null':'Selecionar...']}" />
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
						<span class="icon"> <i class="icon-list-alt"></i>
						</span>
						<h5>Atendimentos incluidos no lote</h5>
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>Número</th>

									<th>Data</th>

									<th>Modalidade</th>

									<th>Seguro</th>

									<th>Segurado</th>

									<th>Técnico</th>

									<th>Evento</th>

									<th>Valor</th>

									<th>Lote</th>

									<th></th>

								</tr>
							</thead>
							<tbody>
								<g:each in="${lote}" status="i" var="ordemServicoInstance">

									<tr>

										<td><g:link action="show" id="${ordemServicoInstance.id}">
												${fieldValue(bean: ordemServicoInstance, field: "numero")}/${fieldValue(bean: ordemServicoInstance, field: "barra")}
											</g:link> <g:if test="${ordemServicoInstance.visitaPerdida}">
												<i data-original-title="Visita perdida" class="tip-top icon-ban-circle"></i>
												<span style="display: none;">visita perdida</span>
											</g:if></td>
										<td><g:formatDate date="${ordemServicoInstance?.dataAtendimento}" format="dd/MM/yyyy" /> de ${fieldValue(bean: ordemServicoInstance, field: "previaInicial")} até ${fieldValue(bean: ordemServicoInstance, field: "previaFinal")}</td>

										<td>
											${fieldValue(bean: ordemServicoInstance, field: "modalidade")}
										</td>

										<td>
											${fieldValue(bean: ordemServicoInstance, field: "seguradora")}
										</td>

										<td>
											${fieldValue(bean: ordemServicoInstance, field: "segurado")}
										</td>

										<td>
											${fieldValue(bean: ordemServicoInstance, field: "funcionario")}
										</td>

										<td>
											${fieldValue(bean: ordemServicoInstance, field: "evento")}
										</td>

										<td><g:formatNumber number="${ordemServicoInstance.valorTotal}" type="currency" currencyCode="BRL" /></td>

										<td>
											${fieldValue(bean: ordemServicoInstance, field: "numeroLotePagamento")}
										</td>
										<td>
	  										<a href="#myModal${ordemServicoInstance.id}" data-toggle="modal"  data-original-title="Dados do atendimento"><i class="icon-zoom-in"></i></a>

											<div id="myModal${ordemServicoInstance.id}" class="modal hide">
												<div class="modal-header">
													<button data-dismiss="modal" class="close" type="button">×</button>
													<h5>
														Atendimento -
														${fieldValue(bean: ordemServicoInstance, field: "numero")}/${fieldValue(bean: ordemServicoInstance, field: "barra")}
														&nbsp; <span id="modalstatus${ordemServicoInstance.id}" class="label label-${ordemServicoInstance.cssStatusColor}">
															${fieldValue(bean: ordemServicoInstance, field: "status")}
														</span>
													</h5>
												</div>
												<div class="modal-body">


													<div id="alertSuccess${ordemServicoInstance.id}" class="alert alert-success alert-block" style="display: none">
														<a class="close" data-dismiss="alert" href="#">×</a>
														<h4 class="alert-heading">Sucesso!</h4>
														<span id="msgTxt${ordemServicoInstance.id}"></span>
													</div>


													<h5>Endere&ccedil;o:</h5>
													<p>
														${fieldValue(bean: ordemServicoInstance, field: "endereco")}<br>
														${fieldValue(bean: ordemServicoInstance, field: "referencia")}
														<br>
														${fieldValue(bean: ordemServicoInstance, field: "cidade")}
														<br>
														${fieldValue(bean: ordemServicoInstance, field: "bairro")}


														<g:render template="historicosTemplate" bean="${ordemServicoInstance}" var="ordemServicoInstance" />

														<g:render template="materiaisTemplate" bean="${ordemServicoInstance}" var="ordemServicoInstance" />
												</div>
											</div>





										</td>

									</tr>

								</g:each>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="8" style="text-align:right">Valor Total</td>
									<td colspan="2" style="text-align:right"><g:formatNumber number="${valorTotalLote}" type="currency" currencyCode="BRL" /></td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>

			</div>
		</div>
	
				
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"> <i class="icon-list-alt"></i>
						</span>
						<h5>Dados para Fechamento do Lote(Liquida&ccedil;&atilde;o)</h5>
						
					</div>
						<div class="widget-content nopadding">
							<g:form action="liquidar" id="formLiquidacaoPagamento" name="formLiquidacaoPagamento" method="post" class="form-horizontal">
								<g:hiddenField name="empresa" value="${params.empresa }"/>
								<div class="control-group">
									<label class="control-label">N&uacute;mero do lote</label>
									<div class="controls">
										<g:hiddenField name="dataPagamento"  value="${params.dataPagamento}" />
									  	<g:textField id="numeroLotePagamento" name="numeroLotePagamento"/>
									</div>
								</div>
								<div class="form-actions">
									<button type="submit" class="btn btn-danger" name="liquidar">
										Liquidar atendimentos
									</button>
								</div>
							</g:form>
						</div>

				</div>
				
	</div>

	<g:javascript library="bootstrap-datepicker" />
	<g:javascript library="locales/bootstrap-datepicker.pt-BR" />
	<g:javascript library="jquery.uniform" />
	<g:javascript library="jquery.validate" />
	<g:javascript library="jquery.ui.custom" />
	<g:javascript library="select2" />
	<g:javascript library="unicorn.form_common" />
	<g:javascript library="sisat.ordemservico.lotePagamento" />



</body>
</html>
