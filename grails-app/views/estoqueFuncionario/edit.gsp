
<%@ page import="model.EstoqueFuncionario"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Cadastro de material</title>

<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />

</head>
<body>

	<div id="content-header">
		<h1>Cadastro de item de estoque</h1>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Material</a>
		<g:link action="list" class="tip-bottom">Pesquisa</g:link>
		<g:link action="show" id="${estoqueFuncionarioInstance.id}" class="tip-bottom">Visualiza&ccedil;&atilde;o</g:link>
		<a href="#" class="current">Editar</a>
	</div>


	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">

				<g:hasErrors bean="${estoqueFuncionarioInstance}">
					<div class="alert alert-error">
						<button class="close" data-dismiss="alert">×</button>
						<strong>Erro!</strong> <br>
						<g:renderErrors bean="${estoqueFuncionarioInstance}" as="list" />
					</div>
				</g:hasErrors>
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"> <i class="icon-align-justify"></i>
						</span>
						<h5>Dados do item de estoque</h5>
					</div>
					<div class="widget-content nopadding">
						<g:form action="update" method="post" class="form-horizontal" novalidate="novalidate" name="createMaterial">
							<g:hiddenField name="id" value="${estoqueFuncionarioInstance?.id}" />
							<g:hiddenField name="version" value="${estoqueFuncionarioInstance?.version}" />
							<g:hiddenField name="funcionario.id" value="${estoqueFuncionarioInstance?.funcionario?.id}" />
							<g:hiddenField name="material.id" value="${estoqueFuncionarioInstance?.material?.id}" />

							<div style="display: none;">
								<g:datePicker name="dataInclusao" value="${estoqueFuncionarioInstance?.dataInclusao}" />
							</div>

							<div class="control-group">
								<label class="control-label">Quantidade</label>
								<div class="controls">
									<g:textField style="width:45px;text-align:right;" name="qtd" value="${fieldValue(bean: estoqueFuncionarioInstance, field: 'qtd')}" />

								</div>
							</div>



							<div class="form-actions">
								<input type="submit" value="Salvar" id="create" class="btn btn-primary">
								<g:actionSubmit action="delete" value="Remover" class="btn btn-danger" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Tem certeza?')}');" />

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
	<g:javascript library="sisat.material.create" />



</body>
</html>
