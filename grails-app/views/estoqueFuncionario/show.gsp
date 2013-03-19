
<%@ page import="model.EstoqueFuncionario"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Visualiza&ccedil;&atilde;o de item de estoque do funcionario</title>

<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'sistat.atendimento.show.print.css')}" media="print" />
</head>
<body>

	<div id="content-header">
		<h1>Visualiza&ccedil;&atilde;o de item de estoque do funcionario</h1>

		<div class="btn-group" style="width: auto;">
			<g:if test="${session?.user?.admin}">
				<g:link action="edit" id="${estoqueFuncionarioInstance.id}" class="btn btn-large tip-bottom" data-original-title="Editar">
					<i class="icon-edit"></i>
				</g:link>
			</g:if>
			<a class="btn btn-large tip-bottom" data-original-title="Imprimir" data-toggle="modal" id='btnPrint' onclick="window.print();"><i class="icon-print"></i></a>

		</div>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Estoque funcion&aacute;rio</a>
		<g:link action="list" class="tip-bottom">Pesquisa</g:link>
		<a href="#" class="current">Visualiza&ccedil;&atilde;o</a>
	</div>


	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				
				<g:if test="${flash.message}">
					<div class="alert alert-success">
						<button class="close" data-dismiss="alert">×</button>
						<strong>Sucesso!</strong> <br>
						<g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" />
					</div>
				</g:if>
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"> <i class="icon-align-justify"></i>
						</span>
						<h5>Dados do item de estoque</h5>
					</div>
					<div class="widget-content nopadding">
						<g:form class="form-horizontal" novalidate="novalidate" name="createTipoFuncionario">

							<div class="control-group">
								<label class="control-label atendimento-dados-label">ID:</label>
								<div class="atendimento-dados">
									${fieldValue(bean: estoqueFuncionarioInstance, field: 'id')}

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label">Data da inclus&atilde;o:</label>
								<div class="atendimento-dados">
									<g:formatDate date="${estoqueFuncionarioInstance?.dataInclusao}" format="dd/MM/yyyy"/>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label atendimento-dados-label">Funcion&aacute;rio:</label>
								<div class="atendimento-dados">
									${estoqueFuncionarioInstance?.funcionario?.encodeAsHTML()}

								</div>
							</div>
							<div class="control-group">
								<label class="control-label atendimento-dados-label">Material:</label>
								<div class="atendimento-dados">
									${estoqueFuncionarioInstance?.material?.encodeAsHTML()}

								</div>
							</div>
							<div class="control-group">
								<label class="control-label atendimento-dados-label">Quantidade:</label>
								<div class="atendimento-dados">
									${fieldValue(bean: estoqueFuncionarioInstance, field: "qtd")}

								</div>
							</div>
							
						</g:form>
					</div>
				</div>

			</div>
		</div>


	</div>

	<g:javascript library="jquery.uniform" />
	<g:javascript library="jquery.dataTables" />
	<g:javascript library="unicorn.tables" />


</body>
</html>
