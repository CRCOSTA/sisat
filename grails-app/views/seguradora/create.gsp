
<%@ page import="model.Seguradora" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Cadastro de seguradoras</title>

<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />

</head>
<body>

	<div id="content-header">
		<h1>Cadastro de seguradoras</h1>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Seguradoras</a> <a href="#" class="current">Cadastro</a>
	</div>


	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
			
			<g:hasErrors bean="${seguradoraInstance}">
					<div class="alert alert-error">
						<button class="close" data-dismiss="alert">×</button>
						<strong>Erro!</strong> <br>    <g:renderErrors bean="${seguradoraInstance}" as="list" />
					</div>
				</g:hasErrors>
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon">
							<i class="icon-align-justify"></i>									
						</span>
						<h5>Dados da seguradora</h5>
					</div>
					<div class="widget-content nopadding">
						<g:form action="save" method="post" class="form-horizontal" novalidate="novalidate" name="createSeguradora">
						
						<div class="control-group">
                             <label class="control-label">Empresa</label>
                             <div class="controls">
								 <g:select name="empresa.id" style="width:350px" from="${model.Empresa.list()}" optionKey="id" value="${seguradoraInstance?.empresa?.id}" noSelection="${['null':'Selecionar...']}" />

                             </div>
                         </div>
						<div class="control-group">
                             <label class="control-label">Nome</label>
                             <div class="controls">
								 <g:textField name="nome" style="width:350px" value="${fieldValue(bean: seguradoraInstance, field: 'nome')}" />

                             </div>
                         </div>
						
						
                         
                         <div class="form-actions">
							<input type="submit" value="Salvar" id="create" class="btn btn-primary">
						</div>
						
						</g:form>
					</div>
				</div>
			
			
			</div>
		</div>


	</div>

	<g:javascript library="jquery.uniform" /> 
	<g:javascript library="jquery.validate" />
	<g:javascript library="select2" /> 
	<g:javascript library="sisat.seguradora.create" />
	
	
	
</body>
</html>
