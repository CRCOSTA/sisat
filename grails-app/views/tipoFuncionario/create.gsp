
<%@ page import="model.Empresa"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Cadastro de tipos de funcion&aacute;rio</title>

<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />

</head>
<body>

	<div id="content-header">
		<h1>Cadastro de tipos de funcion&aacute;rio</h1>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">tipos de funcion&aacute;rio</a> <a href="#" class="current">Cadastro</a>
	</div>


	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
			
			<g:hasErrors bean="${tipoFuncionarioInstance}">
					<div class="alert alert-error">
						<button class="close" data-dismiss="alert">×</button>
						<strong>Erro!</strong> <br>    <g:renderErrors bean="${tipoFuncionarioInstance}" as="list" />
					</div>
				</g:hasErrors>
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon">
							<i class="icon-align-justify"></i>									
						</span>
						<h5>Dados do tipo de funcion&aacute;rio</h5>
					</div>
					<div class="widget-content nopadding">
						<g:form action="save" method="post" class="form-horizontal" novalidate="novalidate" name="createTipoFuncionario">
						
						<div class="control-group">
                             <label class="control-label">Descri&ccedil;&atilde;o</label>
                             <div class="controls">
								<g:textField style="width:350px" name="descTipoFunc" value="${fieldValue(bean: tipoFuncionarioInstance, field: 'descTipoFunc')}" />
							
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
	<g:javascript library="sisat.tipofuncionario.create" />
	
	
	
</body>
</html>
