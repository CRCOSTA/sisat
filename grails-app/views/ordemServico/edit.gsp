
<%@ page import="model.OrdemServico"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Edi&ccedil;&atilde;o de atendimentos</title>

<link rel="stylesheet" href="${resource(dir:'css',file:'datepicker.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'timepicker.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />

</head>
<body>
	<div id="content-header">
		<h1>Edi&ccedil;&atilde;o de atendimentos</h1>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Atendimentos</a> <a href="#" class="current">Edi&ccedil;&atilde;o</a>
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
						<span class="label label-${ordemServicoInstance.cssStatusColor}"> ${fieldValue(bean: ordemServicoInstance, field: "status")}
						</span>
					</div>
					<div class="widget-content nopadding">
						<g:form method="post" class="form-horizontal" novalidate="novalidate" name="createForm">
							<g:hiddenField name="id" value="${ordemServicoInstance?.id}" />
							<g:hiddenField name="version" value="${ordemServicoInstance?.version}" />

							<g:hiddenField name="geometryLocation" id="geometryLocation" />

							<div class="control-group">
								<label class="control-label">Empresa</label>
								<div class="controls">
									<g:select style="width:250px" name="empresa.id" from="${model.Empresa.list()}" optionKey="id" value="${ordemServicoInstance?.empresa?.id}" noSelection="${['null':'Selecionar...']}" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Forma de acionamento</label>
								<div class="controls">
									<g:select name="formaDeAcionamento" from="${ordemServicoInstance.constraints.formaDeAcionamento.inList}" value="${ordemServicoInstance.formaDeAcionamento}"
										valueMessagePrefix="ordemServico.formaDeAcionamento" noSelection="${['null':'Selecionar...']}" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">N&uacute;mero</label>
								<div class="controls">
									<g:textField style="width:150px" name="numero" value="${fieldValue(bean: ordemServicoInstance, field: 'numero')}" />
									/
									<g:textField style="width:20px" name="barra" value="${fieldValue(bean: ordemServicoInstance, field: 'barra')}" />
									<span>&nbsp;&nbsp;&nbsp;Complementar:&nbsp;&nbsp;<g:checkBox name="complementar" value="${ordemServicoInstance?.complementar}" /></span>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Seguradora</label>
								<div class="controls">
									<g:select style="width:250px" name="seguradora.id" from="${model.Seguradora.list()}" optionKey="id" value="${ordemServicoInstance?.seguradora?.id}" noSelection="${['null':'Selecionar...']}" />
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

								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Refer&ecirc;ncia</label>
								<div class="controls">
									<g:textArea style="width:350px;height:50px;" name="referencia" value="${fieldValue(bean: ordemServicoInstance, field: 'referencia')}" />

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
								<label class="control-label">Data do acionamento</label>
								<div class="controls">
									<div class="input-append date" id="datepickerAcionamento" data-date-format="dd/mm/yyyy">
										<input type="text" name="dataAcionamento" id="dataAcionamento" class="span2" style="width: 90px;" value="${ordemServicoInstance?.dataAcionamento}" readonly /> <span class="add-on"><i
											class="icon-th"></i></span>
									</div>
								</div>

							</div>
							<div class="control-group">

								<label class="control-label"> Data do atendimento</label>
								<div class="controls">
									<div class="input-append date" id="datepickerAtendimento" data-date-format="dd/mm/yyyy">
										<input type="text" name="dataAtendimento" id="dataAtendimento" class="span2" style="width: 90px;" value="${ordemServicoInstance?.dataAtendimento}" readonly /> <span class="add-on"><i
											class="icon-th"></i></span>
									</div>
									<span>&nbsp;&nbsp;de:</span>
									<div class="input-append bootstrap-timepicker-component">
										<input type="text" name="previaInicial" id="previaInicial" class="input-small timepicker-default " style="width: 50px;"
											value="${fieldValue(bean: ordemServicoInstance, field: 'previaInicial')}" readonly> <span class="add-on"> <i class="icon-time"></i></span>
									</div>
									<span>&nbsp;&nbsp;at&eacute;:</span>
									<div class="input-append bootstrap-timepicker-component">
										<input type="text" name="previaFinal" id="previaFinal" class="input-small timepicker-default " style="width: 50px;" value="${fieldValue(bean: ordemServicoInstance, field: 'previaFinal')}"
											readonly> <span class="add-on"> <i class="icon-time"></i>
										</span>
									</div>
								</div>

							</div>
							<div class="control-group">
								<label class="control-label">Modalidade</label>
								<div class="controls">
									<g:select name="modalidade.id" style="width:250px" from="${model.Modalidade.list()}" optionKey="id" value="${ordemServicoInstance?.modalidade?.id}" noSelection="${['null':'Selecionar...']}" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Evento</label>
								<div class="controls">
									<g:select name="evento" style="width:250px" from="${ordemServicoInstance.constraints.evento.inList}" value="${ordemServicoInstance.evento}" valueMessagePrefix="ordemServico.evento"
										noSelection="${['null':'Selecionar...']}" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Descri&ccedil;&atilde;o</label>
								<div class="controls">
									<g:textArea style="width:350px;height:50px;" name="descServico" rows="3" cols="200" value="${fieldValue(bean: ordemServicoInstance, field: 'descServico')}" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">T&eacute;cnico</label>
								<div class="controls">
									<g:select name="funcionario.id" style="width:250px" from="${model.Funcionario.findAllByTipoFuncionarioNotAndAtivo(model.TipoFuncionario.get(1),true)}" optionKey="id"
										value="${ordemServicoInstance?.funcionario?.id}" noSelection="${['null':'Selecionar...']}" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Visita Perdida?</label>
								<div class="controls">
									<g:checkBox name="visitaPerdida" value="${ordemServicoInstance?.visitaPerdida}" />
								</div>
							</div>


							<div class="control-group">
								<label class="control-label">Valor MDO</label>
								<div class="controls">
									<g:textField style="width:80px" name="valorMDO" value="${ordemServicoInstance?.valorMDO}" />

								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Valor material</label>
								<div class="controls">
									<g:textField style="width:80px" name="valorMaterial" value="${ordemServicoInstance?.valorMaterial}" />

								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Valor deslocamento</label>
								<div class="controls">
									<g:textField style="width:80px" name="valorDeslocamento" value="${ordemServicoInstance?.valorDeslocamento}" />

								</div>
							</div>


							<div class="control-group">
								<label class="control-label">Data do Lote </label>
								<div class="controls">
									<div class="input-append date" id="datepickerDataLote" data-date-format="dd/mm/yyyy">
										<input type="text" name="dataPagamento" id="dataPagamento" class="span2" style="width: 90px;" value="${ordemServicoInstance?.dataPagamento}" readonly /> <span class="add-on"><i
											class="icon-th"></i></span>
									</div>

								</div>
							</div>


							<div class="form-actions">
								<input type="submit" name="_action_update" value="Salvar" class="btn btn-primary"> <input type="submit" name="_action_delete" value="Remover" class="btn btn-danger"
									onclick="return confirm('Are you sure?');">
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
	<g:javascript library="sisat.ordemservico.create" />
	<g:javascript library="sisat.ordemservico.edit" />
	<script src="http://maps.google.com/maps/api/js?sensor=false"></script>

</body>
</html>
