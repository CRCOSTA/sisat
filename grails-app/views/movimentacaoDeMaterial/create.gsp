
<%@ page import="model.MovimentacaoDeMaterial"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Entrada de material</title>
<link rel="stylesheet" href="${resource(dir:'css',file:'datepicker.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />

</head>
<body>

	<div id="content-header">
		<h1>Entrada de material</h1>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Material</a> <a href="#" class="current">Entrada de material</a>
	</div>


	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">

				<g:hasErrors bean="${movimentacaoDeMaterialInstance}">
					<div class="alert alert-error">
						<button class="close" data-dismiss="alert">×</button>
						<strong>Erro!</strong> <br>
						<g:renderErrors bean="${movimentacaoDeMaterialInstance}" as="list" />
					</div>
				</g:hasErrors>
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"> <i class="icon-align-justify"></i>
						</span>
						<h5>Entrada da material</h5>
					</div>
					<div class="widget-content nopadding">
						<g:form action="save" method="post" class="form-horizontal" novalidate="novalidate" name="entradaDeMaterial">
							<g:hiddenField name="tipo" value="Entrada" />
							<div class="control-group">
								<label class="control-label">Material</label>
								<div class="controls">
									<g:select name="material.id" id="materialId" style="width:500px" from="${model.Material.list()}" optionKey="id" value="${estoqueFuncionarioInstance?.material?.id}" noSelection="${['null':'Selecionar...']}" />
								</div>
							</div>

							<div class="control-group">
								<label class="control-label">Data</label>
								<div class="controls">
									<div class="input-append date" id="datepickerDataMovimentacao" data-date-format="dd/mm/yyyy">
										<input type="text" name="dataMovimentacao" id="dataMovimentacao" class="span2" style="width: 90px;" readonly /> <span class="add-on"><i class="icon-th"></i></span>
									</div>
								</div>

							</div>
							<div class="control-group">
								<label class="control-label">Descri&ccedil;&atilde;o</label>
								<div class="controls">
									<g:textArea name="descricao" style="width:450px" rows="5" cols="40" value="${fieldValue(bean: movimentacaoDeMaterialInstance, field: 'descricao')}" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label">Quantidade</label>
								<div class="controls">
									<g:textField style="width:45px;text-align:right;" name="qtd" value="${fieldValue(bean: estoqueFuncionarioInstance, field: 'qtd')}" />

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
	<g:javascript library="bootstrap-datepicker" />
	<g:javascript library="locales/bootstrap-datepicker.pt-BR" />
	<g:javascript library="jquery.uniform" />
	<g:javascript library="jquery.validate" />
	<g:javascript library="select2" />
	<g:javascript library="sisat.material.entrada" />



</body>
</html>
