
<%@ page import="model.Material"%>
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
		<h1>Cadastro de material</h1>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Material</a>
		<g:link action="list" class="tip-bottom">Pesquisa</g:link>
		<g:link action="show" id="${materialInstance.id}" class="tip-bottom">Visualiza&ccedil;&atilde;o</g:link>
		<a href="#" class="current">Editar</a>
	</div>


	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">

				<g:hasErrors bean="${materialInstance}">
					<div class="alert alert-error">
						<button class="close" data-dismiss="alert">×</button>
						<strong>Erro!</strong> <br>
						<g:renderErrors bean="${materialInstance}" as="list" />
					</div>
				</g:hasErrors>
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"> <i class="icon-align-justify"></i>
						</span>
						<h5>Dados da material</h5>
					</div>
					<div class="widget-content nopadding">
						<g:form action="update" method="post" class="form-horizontal" novalidate="novalidate" name="createMaterial">
							<g:hiddenField name="id" value="${materialInstance?.id}" />
							<g:hiddenField name="version" value="${materialInstance?.version}" />


							<div class="control-group">
								<label class="control-label">Descri&ccedil;&atilde;o</label>
								<div class="controls">
									<g:textArea name="descricao" style="width:450px" rows="5" cols="40" value="${fieldValue(bean: materialInstance, field: 'descricao')}" />

								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Marca</label>
								<div class="controls">
									<g:textField name="marca" style="width:450px" value="${fieldValue(bean: materialInstance, field: 'marca')}" />

								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Valor da compra</label>
								<div class="controls">
									<g:textField style="width:110px" name="valorCompra" value="${fieldValue(bean: materialInstance, field: 'valorCompra')}" />

								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Valor da venda</label>
								<div class="controls">
									<g:textField style="width:110px" name="valorVenda" value="${fieldValue(bean: materialInstance, field: 'valorVenda')}" />

								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Estoque m&iacute;nimo</label>
								<div class="controls">
									<g:textField style="width:50px" name="estoqueMinimo" value="${fieldValue(bean: materialInstance, field: 'estoqueMinimo')}" />

								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Estoque atual</label>
								<div class="controls">
									<g:textField style="width:50px" name="estoqueAtual" value="${fieldValue(bean: materialInstance, field: 'estoqueAtual')}" />

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
