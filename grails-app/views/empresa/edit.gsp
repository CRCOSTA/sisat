
<%@ page import="model.Empresa"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Cadastro de empresas</title>

<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />

</head>
<body>

	<div id="content-header">
		<h1>Cadastro de empresas</h1>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Empresas</a> <g:link action="list" controller="empresa" class="tip-bottom">Pesquisa</g:link>  <g:link action="show" id="${empresaInstance.id}" class="tip-bottom">Visualiza&ccedil;&atilde;o</g:link> <a href="#" class="current">Editar</a>
	</div>


	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
			
			<g:hasErrors bean="${empresaInstance}">
					<div class="alert alert-error">
						<button class="close" data-dismiss="alert">×</button>
						<strong>Erro!</strong> <br>    <g:renderErrors bean="${empresaInstance}" as="list" />
					</div>
				</g:hasErrors>
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon">
							<i class="icon-align-justify"></i>									
						</span>
						<h5>Dados da empresa</h5>
					</div>
					<div class="widget-content nopadding">
						<g:form action="update" method="post" class="form-horizontal" novalidate="novalidate" name="createEmpresa">
						 <g:hiddenField name="id" value="${empresaInstance?.id}" />
                <g:hiddenField name="version" value="${empresaInstance?.version}" />
						<div class="control-group">
                             <label class="control-label">Raz&atilde;o social</label>
                             <div class="controls">
	  						 <g:textField style="width:350px" name="nome"  value="${fieldValue(bean: empresaInstance, field: 'nome')}"  />
							
                             </div>
                         </div>
						
						<div class="control-group">
                             <label class="control-label"> CNPJ</label>
                             <div class="controls">
	  						 <g:textField style="width:350px" name="cnpj" value="${fieldValue(bean: empresaInstance, field: 'cnpj')}"    />
							
                             </div>
                         </div>
                         
                         <div class="control-group">
                             <label class="control-label"> Contato</label>
                             <div class="controls">
	  						 <g:textField style="width:350px" name="contato" value="${fieldValue(bean: empresaInstance, field: 'contato')}"  />
							
                             </div>
                         </div>
                         
                         <div class="control-group">
                             <label class="control-label">Endere&ccedil;o </label>
                             <div class="controls">
	  						 <g:textField style="width:350px"  name="endereco" value="${fieldValue(bean: empresaInstance, field: 'endereco')}"  />
							
                             </div>
                         </div>
                         
                         <div class="control-group">
                             <label class="control-label"> CEP</label>
                             <div class="controls">
	  						 <g:textField style="width:80px" name="cep" value="${fieldValue(bean: empresaInstance, field: 'cep')}"  />
							
                             </div>
                         </div>
                         
                         <div class="control-group">
                             <label class="control-label">Telefone-1 </label>
                             <div class="controls">
	  						 <g:textField style="width:150px" name="telefone1" id="telefone1" value="${fieldValue(bean: empresaInstance, field: 'telefone1')}"   />
							
                             </div>
                         </div>
                         
                         <div class="control-group">
                             <label class="control-label">Telefone-2 </label>
                             <div class="controls">
	  						 <g:textField style="width:150px" name="telefone2" id="telefone2" value="${fieldValue(bean: empresaInstance, field: 'telefone2')}"   />
							
                             </div>
                         </div>
                        
                         <div class="control-group">
                             <label class="control-label">Telefone-3 </label>
                             <div class="controls">
	  						 <g:textField style="width:150px" name="telefone3" id="telefone3" value="${fieldValue(bean: empresaInstance, field: 'telefone3')}"   />
							
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
	<g:javascript library="jquery.maskedinput" />
	<g:javascript library="sisat.empresa.create" />
	
	
	
</body>
</html>
