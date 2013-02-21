
<%@ page import="model.Funcionario"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Cadastro de funcion&aacute;rio</title>

<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />

</head>
<body>

	<div id="content-header">
		<h1>Cadastro de funcion&aacute;rio</h1>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">funcion&aacute;rio</a> <a href="#" class="current">Cadastro</a>
	</div>


	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">

				<g:hasErrors bean="${funcionarioInstance}">
					<div class="alert alert-error">
						<button class="close" data-dismiss="alert">×</button>
						<strong>Erro!</strong> <br>
						<g:renderErrors bean="${funcionarioInstance}" as="list" />
					</div>
				</g:hasErrors>
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"> <i class="icon-align-justify"></i>
						</span>
						<h5>Dados do funcion&aacute;rio</h5>
					</div>
					<div class="widget-content nopadding">
						<g:form action="save" method="post" class="form-horizontal" novalidate="novalidate" name="createFuncionario">

							<div class="control-group">
								<label class="control-label">Empresa </label>
								<div class="controls">
									<g:select style="width:250px" name="empresa.id" from="${model.Empresa.list()}" optionKey="id" value="${funcionarioInstance?.empresa?.id}" />
								</div>
							</div>

							<div class="control-group">
								<label class="control-label">Tipo funcion&aacute;rio </label>
								<div class="controls">
									<g:select style="width:250px" name="tipoFuncionario.id" from="${model.TipoFuncionario.list()}" optionKey="id" value="${funcionarioInstance?.tipoFuncionario?.id}" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label">Nome </label>
								<div class="controls">
									<g:textField style="width:350px" name="nome" maxlength="200" value="${fieldValue(bean: funcionarioInstance, field: 'nome')}" />
								</div>
							</div>

							<div class="control-group">
								<label class="control-label">Email </label>
								<div class="controls">
									<g:textField style="width:350px" name="email" value="${fieldValue(bean: funcionarioInstance, field: 'email')}" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Telefone </label>
								<div class="controls">
									<g:textField style="width:150px" name="telefone" value="${fieldValue(bean: funcionarioInstance, field: 'telefone')}" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Nextel </label>
								<div class="controls">
									<g:textField style="width:150px" name="IDNextel" value="${fieldValue(bean: funcionarioInstance, field: 'IDNextel')}" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Celular </label>
								<div class="controls">
									<g:textField style="width:150px" name="celular" value="${fieldValue(bean: funcionarioInstance, field: 'celular')}" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Login </label>
								<div class="controls">
									<g:textField style="width:100px" name="login" value="${fieldValue(bean: funcionarioInstance, field: 'login')}" />
								</div>
							</div>

							<div class="control-group">
								<label class="control-label">Senha </label>
								<div class="controls">
									<g:passwordField style="width:100px" name="senha" value="${fieldValue(bean: funcionarioInstance, field: 'senha')}" />
								</div>
							</div>

							<div class="control-group">
								<label class="control-label">Ativo </label>
								<div class="controls">
									<g:checkBox name="ativo" value="${funcionarioInstance?.ativo}" />
								</div>
							</div>

							<div class="control-group">
								<label class="control-label">Administrador </label>
								<div class="controls">
									<g:checkBox name="admin" value="${funcionarioInstance?.admin}" />
								</div>
							</div>

							<div class="control-group">
								<label class="control-label"> Valor realizada</label>
								<div class="controls">
									<g:textField style="width:80px" name="valorRealizada" value="${fieldValue(bean: funcionarioInstance, field: 'valorRealizada')}" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label"> Valor realizada noturno</label>
								<div class="controls">
									<g:textField style="width:80px" name="valorRealizadaNoite" value="${fieldValue(bean: funcionarioInstance, field: 'valorRealizadaNoite')}" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label"> Valor realizada domingo</label>
								<div class="controls">
									<g:textField style="width:80px" name="valorRealizadaDomingo" value="${fieldValue(bean: funcionarioInstance, field: 'valorRealizadaDomingo')}" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label"> Valor visita</label>
								<div class="controls">
									<g:textField style="width:80px" name="valorVisita" value="${fieldValue(bean: funcionarioInstance, field: 'valorVisita')}" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label"> Valor visita noturna</label>
								<div class="controls">
									<g:textField style="width:80px" name="valorVisitaNoite" value="${fieldValue(bean: funcionarioInstance, field: 'valorVisitaNoite')}" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label"> Valor visita domingo</label>
								<div class="controls">
									<g:textField style="width:80px" name="valorVisitaDomingo" value="${fieldValue(bean: funcionarioInstance, field: 'valorVisitaDomingo')}" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label"> Valor complementar</label>
								<div class="controls">
									<g:textField style="width:80px" name="valorComplementar" value="${fieldValue(bean: funcionarioInstance, field: 'valorComplementar')}" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label"> Valor complementar noturna</label>
								<div class="controls">
									<g:textField style="width:80px" name="valorComplementarNoite" value="${fieldValue(bean: funcionarioInstance, field: 'valorComplementarNoite')}" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label"> Valor complementar domingo</label>
								<div class="controls">
									<g:textField style="width:80px" name="valorComplementarDomingo" value="${fieldValue(bean: funcionarioInstance, field: 'valorComplementarDomingo')}" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label"> Valor checkup</label>
								<div class="controls">
									<g:textField style="width:80px" name="valorCheckup" value="${fieldValue(bean: funcionarioInstance, field: 'valorCheckup')}" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label"> Valor checkup noturna</label>
								<div class="controls">
									<g:textField style="width:80px" name="valorCheckupNoite" value="${fieldValue(bean: funcionarioInstance, field: 'valorCheckupNoite')}" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label"> Valor checkup domingo</label>
								<div class="controls">
									<g:textField style="width:80px" name="valorCheckupDomingo" value="${fieldValue(bean: funcionarioInstance, field: 'valorCheckupDomingo')}" />

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
	<g:javascript library="jquery.maskedinput" />
	<g:javascript library="sisat.funcionario.create" />



</body>
</html>
