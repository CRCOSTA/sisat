
<%@ page import="model.OrdemServico"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="tecnico" />
<title>Visualiza&ccedil;&atilde;o de Atendimentos</title>
<link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap-image-gallery.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />


</head>
<body>

	<div id="content-header">
		<h1>
			${fieldValue(bean: ordemServicoInstance, field: "numero")}/${fieldValue(bean: ordemServicoInstance, field: "barra")}
		</h1>

		<div class="btn-group" style="width: auto;">
			<g:link action="listByTecnico" class="btn btn-success btn-large">
				<i class="icon-chevron-left icon-white"></i>&nbsp;</g:link>
			<a class="btn btn-primary btn-large" href="#modalValidar" data-toggle="modal" onclick="prepararFormValidarSenha('${ordemServicoInstance.id}');"> <i class="icon-lock icon-white"></i>&nbsp;
			</a> <a class="btn btn-primary btn-large" href="#modaluploadfoto" data-toggle="modal"> <i class="icon-camera icon-white"></i>&nbsp;
			</a>
			<button class="btn btn-primary btn-large" id="gravarSaida${ordemServicoInstance.id}" onclick="server.gravarSaida('${ordemServicoInstance.id}');">
				<i class="icon-ok icon-white"></i>&nbsp;
			</button>

		</div>


	</div>


	<div id="modal-gallery" class="modal modal-gallery hide fade" tabindex="-1">
		<div class="modal-header">
			<a class="close" data-dismiss="modal">&times;</a>
			<h3 class="modal-title"></h3>
		</div>
		<div class="modal-body">
			<div class="modal-image"></div>
		</div>
		<div class="modal-footer">
			<a class="btn btn-primary modal-next">Pr&oacute;ximo <i class="icon-arrow-right icon-white"></i></a> <a class="btn btn-info modal-prev"><i class="icon-arrow-left icon-white"></i> Anterior</a>
		</div>
	</div>

	<div id="myAlert" class="modal hide">
		<div class="modal-header">
			<button data-dismiss="modal" class="close" type="button">×</button>
			<h3>Alerta</h3>
		</div>
		<div class="modal-body">
			<p>Opera&ccedil;&atilde;o efetuada com sucesso.</p>
		</div>
		<div class="modal-footer">
			<a data-dismiss="modal" class="btn btn-primary" href="#">Fechar</a> 
		</div>
	</div>

	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<g:hiddenField name="id" value="${ordemServicoInstance?.id}" />
				<g:hiddenField name="geometryLocation" id="geometryLocation" value="${ordemServicoInstance?.geometryLocation}" />

				<g:if test="${flash.message}">
					<div class="alert alert-success">
						<button class="close" data-dismiss="alert">×</button>
						<strong>Sucesso!</strong> <br>
						<g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" />
					</div>
				</g:if>

				<div class="widget-box" style="margin-top: 30px;">
					<div class="widget-title">
						<span class="icon"> <i class="icon-th-list"></i>
						</span>
						<h5>
							Dados do acionamento
							<g:if test="${ordemServicoInstance?.visitaPerdida}">(Visita Perdida)</g:if>
						</h5>
						<span class="label label-${ordemServicoInstance.cssStatusColor}"> ${fieldValue(bean: ordemServicoInstance, field: "status")}
						</span>

					</div>
					<div class="widget-content nopadding form-horizontal">
						<div class="control-group">
							<label class="control-label atendimento-dados-label">Data do atendimento:</label>
							<div class="atendimento-dados">
								<span><g:formatDate date="${ordemServicoInstance?.dataAtendimento}" format="dd/MM/yyyy" /> de: ${ordemServicoInstance?.previaInicial} até: ${ordemServicoInstance?.previaFinal}</span>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label atendimento-dados-label">Modalidade:</label>
							<div class="atendimento-dados">
								${fieldValue(bean: ordemServicoInstance, field: "modalidade")}
								-
								${ordemServicoInstance?.funcionario?.encodeAsHTML()}
							</div>
						</div>

						<div class="control-group">
							<label class="control-label atendimento-dados-label">Empresa:</label>
							<div class="atendimento-dados">
								${ordemServicoInstance?.seguradora?.encodeAsHTML()}
								-
								${ordemServicoInstance?.empresa?.encodeAsHTML()}
							</div>
						</div>

						<div class="control-group">
							<label class="control-label atendimento-dados-label">Segurado:</label>
							<div class="atendimento-dados">
								${fieldValue(bean: ordemServicoInstance, field: "segurado")}
							</div>
						</div>
						<div class="control-group">
							<label class="control-label atendimento-dados-label">Endere&ccedil;o:</label>
							<div class="atendimento-dados">
								${fieldValue(bean: ordemServicoInstance, field: "endereco")}
							</div>
						</div>
						<div class="control-group">
							<label class="control-label atendimento-dados-label">Cidade:</label>
							<div class="atendimento-dados">
								${fieldValue(bean: ordemServicoInstance, field: "cidade")}
							</div>
						</div>
						<div class="control-group">
							<label class="control-label atendimento-dados-label">Bairro:</label>
							<div class="atendimento-dados">
								${ordemServicoInstance?.bairro?.encodeAsHTML()}
							</div>
						</div>
						<div class="control-group">
							<label class="control-label atendimento-dados-label">Refer&ecirc;cia:</label>
							<div class="atendimento-dados">
								${fieldValue(bean: ordemServicoInstance, field: "referencia")}
							</div>
						</div>
						<div class="control-group">
							<label class="control-label atendimento-dados-label">Geolocaliza&ccedil;&atilde;o:</label>
							<div class="atendimento-dados">
								${fieldValue(bean: ordemServicoInstance, field: "geometryLocation")}
							</div>
						</div>

						<div class="control-group">
							<label class="control-label atendimento-dados-label">Evento:</label>
							<div class="atendimento-dados">
								${fieldValue(bean: ordemServicoInstance, field: "evento")}
							</div>
						</div>
						<div class="control-group">
							<label class="control-label atendimento-dados-label">Descri&ccedil;&atilde;o:</label>
							<div class="atendimento-dados">
								${fieldValue(bean: ordemServicoInstance, field: "descServico")}
							</div>
						</div>
					</div>
				</div>

				<g:if test="${ordemServicoInstance?.imagens}">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-picture"></i>
							</span>
							<h5>Registros Fotográficos</h5>

						</div>
						<div id="collapseGallery">
							<div class="widget-content">
								<ul class="thumbnails" id="gallery" data-toggle="modal-gallery" data-target="#modal-gallery">
									<g:each in="${ordemServicoInstance?.imagens}" status="i" var="imagem">
										<li class="span2"><a href="${session.siteConfig.imgUrl}${ordemServicoInstance?.id}/${imagem?.nomeImagem}" class="thumbnail" data-gallery="gallery"> <img
												src="${session.siteConfig.imgUrl}${ordemServicoInstance?.id}/thumb_${imagem?.nomeImagem}">
										</a></li>
									</g:each>
								</ul>
							</div>
						</div>
					</div>
				</g:if>






			</div>
		</div>
		<g:render template="validarSenha" />
		<g:render template="uploadFotoTecnico" bean="${ordemServicoInstance}" />
	</div>

	<g:javascript library="load-image" />
	<g:javascript library="bootstrap-image-gallery" />
	<g:javascript library="select2" />
	<g:javascript library="jquery.uploadify-3.1" />
	<g:javascript library="bootstrap-datepicker" />
	<g:javascript library="locales/bootstrap-datepicker.pt-BR" />
	<g:javascript library="bootstrap-timepicker" />
	<g:javascript library="jquery.validate" />
	<g:javascript library="sisat.ordemservico.filtros.validation" />
	<g:javascript library="sisat.ordemservico.filtros" />
	<g:javascript library="sisat.ordemservico.server" />

</body>
</html>

