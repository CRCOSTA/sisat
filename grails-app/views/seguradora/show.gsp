
<%@ page import="model.Seguradora" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Visualiza&ccedil;&atilde;o de tipos de funcion&aacute;rio</title>

<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'sistat.atendimento.show.print.css')}" media="print" />
</head>
<body>

	<div id="content-header">
		<h1>Visualiza&ccedil;&atilde;o de seguradoras</h1>
		
		<div class="btn-group" style="width: auto;">
			<g:if test="${session?.user?.admin}">
				<g:link action="edit" id="${seguradoraInstance.id}" class="btn btn-large tip-bottom" data-original-title="Editar">
					<i class="icon-edit"></i>
				</g:link>
			</g:if>
			<a class="btn btn-large tip-bottom" data-original-title="Imprimir" data-toggle="modal" id='btnPrint' onclick="window.print();"><i class="icon-print"></i></a>
			
		</div>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Seguradoras</a><g:link action="list" class="tip-bottom">Pesquisa</g:link> <a href="#" class="current">Visualiza&ccedil;&atilde;o</a>
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
						<h5>Dados da seguradoras</h5>
					</div>
					<div class="widget-content nopadding">
						<g:form class="form-horizontal" novalidate="novalidate" name="createTipoFuncionario">

							<div class="control-group">
								<label class="control-label atendimento-dados-label">ID:</label>
								<div class="atendimento-dados">
									${fieldValue(bean: seguradoraInstance, field: 'id')}

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label">Nome:</label>
								<div class="atendimento-dados">
									${fieldValue(bean: seguradoraInstance, field: 'nome')}

								</div>
							</div>





						</g:form>
					</div>
				</div>


			</div>
		</div>


	</div>

	<g:javascript library="jquery.uniform" />



</body>
</html>
