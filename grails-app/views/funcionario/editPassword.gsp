
<%@ page import="model.Funcionario"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="pesquisa" />
<title>Edi&ccedil;&atilde;o de funcion&aacute;rio</title>

<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />

</head>
<body>

	<div id="content-header">
		<h1>Edi&ccedil;&atilde;o de funcion&aacute;rio</h1>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a>
		<a href="#" class="current">Alterar senha</a>
	</div>


	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">

				<g:hasErrors bean="${funcionarioInstance}">
					<div class="alert alert-error">
						<button class="close" data-dismiss="alert">×</button>
						<strong>Erro!</strong> <br>
						<g:renderErrors bean="${funcionarioInstance}" as="list"  />
					</div>
				</g:hasErrors>
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"> <i class="icon-align-justify"></i>
						</span>
						<h5>Dados do funcion&aacute;rio</h5>
					</div>
					<div class="widget-content nopadding">
						<g:form action="editPassword" method="post" class="form-horizontal" novalidate="novalidate" name="editPasswordFuncionario">
							<g:hiddenField name="id" value="${funcionarioInstance?.id}" />
							<g:hiddenField name="version" value="${funcionarioInstance?.version}" />
							

							<div class="control-group">
								<label class="control-label">Senha Atual</label>
								<div class="controls">
									<g:passwordField style="width:100px" name="senhaAtual" />
								</div>
							</div>

							<div class="control-group">
								<label class="control-label">Nova senha </label>
								<div class="controls">
									<g:passwordField style="width:100px" name="senhaNova" />
								</div>
							</div>
							
							<div class="control-group">
								<label class="control-label">Confirmar senha </label>
								<div class="controls">
									<g:passwordField style="width:100px" name="senhaConfirm"  />
								</div>
							</div>


							<div class="form-actions">
								<input type="submit" value="Salvar" id="edit" name="edit" class="btn btn-primary">
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
	<g:javascript library="jquery.maskedinput" />
	<g:javascript library="sisat.funcionario.create" />



</body>
</html>
