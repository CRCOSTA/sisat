
<%@ page import="model.OrdemServico"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="pesquisa" />
<title>Cadastro de atendimentos</title>

<link rel="stylesheet" href="${resource(dir:'css',file:'datepicker.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'timepicker.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />

</head>
<body>
	<div id="content-header">
		<h1>Cadastro de atendimentos</h1>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Atendimentos</a> <a href="#" class="current">Cadastro</a>
	</div>

	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<g:hasErrors bean="${ordemServicoInstance}">
					<div class="alert alert-error">
						<button class="close" data-dismiss="alert">×</button>
						<strong>Erro!</strong> <br>
						<g:renderErrors bean="${ordemServicoInstance}" as="list" />
					</div>
				</g:hasErrors>
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"> <i class="icon-align-justify"></i>
						</span>
						<h5>Dados do atendimento</h5>
					</div>
					<div class="widget-content nopadding">
						<g:form action="saveShort" method="post" class="form-horizontal" novalidate="novalidate" name="createForm">
							<g:hiddenField name="geometryLocation" id="geometryLocation" />
							<g:hiddenField name="visitaPerdida" id="visitaPerdida" value="false" />
							<g:hiddenField name="formaDeAcionamento" value="Eletronico" />
							<g:hiddenField name="seguradora.id" value="1" />
							<g:hiddenField name="modalidade.id" value="6" />
							<g:hiddenField name="evento" value="Retorno" />
							<div style="display:none;">
							 <g:datePicker name="dataAcionamento" value="${ordemServicoInstance?.dataAcionamento}"  />
							</div>
							<div class="control-group">
								<label class="control-label">Empresa</label>
								<div class="controls">
									<g:select style="width:250px" name="empresa.id" from="${model.Empresa.list()}" optionKey="id" value="${ordemServicoInstance?.empresa?.id}" noSelection="${['null':'Selecionar...']}" />
								</div>
							</div>

							<div class="control-group">
								<label class="control-label">N&uacute;mero</label>
								<div class="controls">
									<g:textField style="width:150px" name="numero" value="${fieldValue(bean: ordemServicoInstance, field: 'numero')}" />
									/
									<g:textField style="width:20px" name="barra" value="${fieldValue(bean: ordemServicoInstance, field: 'barra')}" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Segurado</label>
								<div class="controls">
									<g:textField style="width:350px" name="segurado" value="${fieldValue(bean: ordemServicoInstance, field: 'segurado')}" />
								</div>
							</div>

							<div class="control-group">
								<label class="control-label">Endere&ccedil;o</label>
								<div class="controls">
									<g:textArea style="width:350px;height:50px;" id="endereco" name="endereco" rows="3" cols="200" value="${fieldValue(bean: ordemServicoInstance, field: 'endereco')}" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Cidade</label>
								<div class="controls">
									<g:textField id="cidade" style="width:350px" name="cidade" value="${fieldValue(bean: ordemServicoInstance, field: 'cidade')}" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Bairro</label>
								<div class="controls">
									<g:select id="bairro" name="bairro.id" from="${model.Bairro.list()}" optionKey="id" value="${ordemServicoInstance?.bairro?.id}" noSelection="${['null':'Selecionar...']}" style="width:250px" />
									<a id="btnMapa" class="btn btn-success" href="#myModal" data-toggle="modal">Gerar mapa</a>
									<div id="myModal" class="modal hide">
										<div class="modal-header">
											<button data-dismiss="modal" class="close" type="button">×</button>
											<h5>Mapa</h5>
										</div>
										<div class="modal-body">
											<div id="map_canvas" style="width: 530px; height: 400px; display: none;"></div>

										</div>
										<div class="modal-footer">
											<a data-dismiss="modal" id="confirmMapa" class="btn btn-primary" href="#">Confirmar</a> <a data-dismiss="modal" class="btn" href="#">Cancelar</a>
										</div>
									</div>
								</div>
							</div>
							
							<div class="control-group">
								<label class="control-label"> Data do atendimento</label>
								<div class="controls">
									<div class="input-append date" id="datepickerAtendimento" data-date-format="dd/mm/yyyy">
										<input type="text" name="dataAtendimento" id="dataAtendimento" class="span2" style="width: 90px;" readonly /> <span class="add-on"><i class="icon-th"></i></span>
									</div>
									<span>&nbsp;&nbsp;de:</span>
									<div class="input-append bootstrap-timepicker-component">
										<input type="text" name="previaInicial" id="previaInicial" class="input-small timepicker-default " style="width: 50px;" readonly> <span class="add-on"> <i class="icon-time"></i>
										</span>
									</div>
									<span>&nbsp;&nbsp;at&eacute;:</span>
									<div class="input-append bootstrap-timepicker-component">
										<input type="text" name="previaFinal" id="previaFinal" class="input-small timepicker-default " style="width: 50px;" readonly> <span class="add-on"> <i class="icon-time"></i>
										</span>
									</div>
								</div>

							</div>
							<div class="control-group">
								<label class="control-label">T&eacute;cnico</label>
								<div class="controls">
									<g:select name="funcionario.id" style="width:250px" from="${model.Funcionario.findAllByTipoFuncionarioNotAndAtivo(model.TipoFuncionario.get(1),true)}" optionKey="id"
										value="${ordemServicoInstance?.funcionario?.id}" noSelection="${['null':'Selecionar...']}" />
								</div>
							</div>
							<div class="form-actions">
								<input type="submit" value="Salvar" id="create" class="btn btn-primary" disabled="disabled">
							</div>
						</g:form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<g:javascript library="bootstrap-datepicker" />
	<g:javascript library="locales/bootstrap-datepicker.pt-BR" />
	<g:javascript library="bootstrap-timepicker" />
	<g:javascript library="jquery.uniform" />
	<g:javascript library="jquery.validate" />
	<g:javascript library="jquery.ui.custom" />
	<g:javascript library="select2" />
	<g:javascript library="unicorn.form_common" />
	<g:javascript library="sisat.ordemservico" />
	<g:javascript library="sisat.ordemservico.create" />

	<script src="http://maps.google.com/maps/api/js?sensor=false"></script>


</body>
</html>
