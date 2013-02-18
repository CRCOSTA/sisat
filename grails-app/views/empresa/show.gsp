
<%@ page import="model.Empresa"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Cadastro de empresas</title>

<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'sistat.atendimento.show.print.css')}" media="print" />

</head>
<body>

	<div id="content-header">
		<h1>Visualiza&ccedil;&atilde;o de empresas</h1>
		
		<div class="btn-group" style="width: auto;">
			<g:if test="${session?.user?.admin}">
				<g:link action="edit" id="${empresaInstance.id}" class="btn btn-large tip-bottom" data-original-title="Editar">
					<i class="icon-edit"></i>
				</g:link>
			</g:if>
			<a class="btn btn-large tip-bottom" data-original-title="Imprimir" data-toggle="modal" id='btnPrint' onclick="window.print();"><i class="icon-print"></i></a>
			
		</div>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Empresas</a> <g:link action="list" controller="empresa" class="tip-bottom">Pesquisa</g:link> <a href="#" class="current">Visualiza&ccedil;&atilde;o</a>
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
						<h5>Dados da empresa</h5>
					</div>
					<div class="widget-content nopadding">
						<g:form class="form-horizontal">
							<g:hiddenField name="id" value="${empresaInstance?.id}" />
							<div class="control-group">
								<label class="control-label atendimento-dados-label">Raz&atilde;o social:</label>
								<div class="atendimento-dados">
									${fieldValue(bean: empresaInstance, field: 'nome')}

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label"> CNPJ:</label>
								<div class="atendimento-dados">
									${fieldValue(bean: empresaInstance, field: 'cnpj')}

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label"> Contato:</label>
								<div class="atendimento-dados">
									${fieldValue(bean: empresaInstance, field: 'contato')}

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label">Endere&ccedil;o :</label>
								<div class="atendimento-dados">
									${fieldValue(bean: empresaInstance, field: 'endereco')}

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label"> CEP:</label>
								<div class="atendimento-dados">
									${fieldValue(bean: empresaInstance, field: 'cep')}

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label">Telefone-1: </label>
								<div class="atendimento-dados">
									${fieldValue(bean: empresaInstance, field: 'telefone1')}

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label">Telefone-2: </label>
								<div class="atendimento-dados">
									${fieldValue(bean: empresaInstance, field: 'telefone2')}

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label">Telefone-3: </label>
								<div class="atendimento-dados">
									${fieldValue(bean: empresaInstance, field: 'telefone3')}

								</div>
							</div>

						</g:form>
					</div>
				</div>


			</div>
		</div>


	</div>

	<g:javascript library="jquery.uniform" />
	<g:javascript library="jquery.validate" />
	<g:javascript library="jquery.maskedinput" />
	<g:javascript library="sisat.empresa.create" />



</body>
</html>
