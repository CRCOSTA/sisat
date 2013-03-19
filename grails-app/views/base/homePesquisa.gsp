<html>
<head>
<title>Home</title>
<meta name="layout" content="pesquisa" />

<link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap-image-gallery.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'sistat.atendimento.show.print.css')}" media="print" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uploadify.css')}" />


<style type="text/css">
.form-span input[type="text"][class*="span"] {
	float: left;
	padding: 21px;
	font-size: 18px;
}

.inline-center {
	text-align: center !important;
}

.inline-center [class*="span"] {
	float: none !important;
	display: inline-block !important;
}
</style>
</head>
<body>
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

	<div id="content-header">

		<h1>Pesquisa de atendimentos</h1>

		<div class="btn-group" style="width: auto;">
			<g:if test="${session?.user?.operador}">
				<a href="#modaluploadfoto" data-toggle="modal" onclick="prepararFormUploadFoto('${ordemServicoInstance?.id}');" class="btn btn-primary btn-large tip-bottom" data-original-title="Incluir fotos">
					<i class="icon-camera icon-white"></i>
				</a>
				<g:link controller="ordemServico" action="edit" id="${ordemServicoInstance?.id}" class="btn btn-primary btn-large tip-bottom" data-original-title="Editar">
					<i class="icon-edit icon-white"></i>
				</g:link>
			</g:if>
			<a class="btn btn-large tip-bottom" data-original-title="Imprimir" data-toggle="modal" id='btnPrint' onclick="window.print();"><i class="icon-print"></i></a>

		</div>
	</div>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">

				<g:form action="homePesquisa" method="post" class="well form-search form-span">
					<div class="span12">
						<input type="text" name="numero" placeholder="N&uacute;mero do Atendimento..." value="${params.numero }" class="offset1 span7 input-large" />
						<button type="submit" name="pesquisa" value="home" class="span3 btn-large btn-primary">Pesquisar</button>
					</div>
				</g:form>
			</div>
		</div>

		<g:if test="${ordemServicoInstance }">

			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-th-list"></i>
							</span>
							<h5>
								Dados do atendimento
								<g:if test="${ordemServicoInstance?.visitaPerdida}">(Visita Perdida)</g:if>
							</h5>

						</div>
						<div class="widget-content nopadding form-horizontal">
							<div class="control-group">
								<label class="control-label atendimento-dados-label">Prestador de servi&ccedil;o:</label>
								<div class="atendimento-dados">
									<span>CR Costa Assistencia 24h</span>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label atendimento-dados-label">Data do atendimento:</label>
								<div class="atendimento-dados">
									<span><g:formatDate date="${ordemServicoInstance?.dataAtendimento}" format="dd/MM/yyyy" /> de: ${ordemServicoInstance?.previaInicial} até: ${ordemServicoInstance?.previaFinal}</span>
								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label"> Chegada: </label>
								<div class="atendimento-dados">
									<span><g:formatDate date="${ordemServicoInstance?.chegada}" format="dd/MM/yyyy HH:mm" /> Saida:<g:formatDate date="${ordemServicoInstance?.saida}" format="dd/MM/yyyy HH:mm" /></span>

								</div>
							</div>
							<div class="control-group">
								<label class="control-label atendimento-dados-label">Senha:</label>
								<div class="atendimento-dados">
									${fieldValue(bean: ordemServicoInstance, field: "senha")}
								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label">Cliente:</label>
								<div class="atendimento-dados">
									${fieldValue(bean: ordemServicoInstance, field: "segurado")}
								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label">Cidade:</label>
								<div class="atendimento-dados">
									${fieldValue(bean: ordemServicoInstance, field: "cidade")}
								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label">T&eacute;cnico:</label>
								<div class="atendimento-dados">
									${ordemServicoInstance?.funcionario}
								</div>
							</div>
						</div>
					</div>

					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-picture"></i>
							</span>
							<h5>Registros Fotográficos</h5>

						</div>
						<div id="collapseGallery">
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
			</div>

		</g:if>

	</div>

	<g:render template="/ordemServico/uploadFoto" />

	<g:javascript library="bootstrap-datepicker" />
	<g:javascript library="locales/bootstrap-datepicker.pt-BR" />
	<g:javascript library="bootstrap-timepicker" />
	<g:javascript library="jquery.uniform" />
	<g:javascript library="jquery.ui.custom" />
	<g:javascript library="select2" />
	<g:javascript library="load-image" />
	<g:javascript library="bootstrap-image-gallery" />
	<g:javascript library="jquery.uploadify-3.1" />
	<g:javascript library="sisat.ordemservico.filtros" />
	<g:javascript library="sisat.ordemservico.server" />








</body>
</html>
