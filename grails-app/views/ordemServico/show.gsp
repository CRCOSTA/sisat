
<%@ page import="model.OrdemServico"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Visualiza&ccedil;&atilde;o de Atendimentos</title>
<link rel="stylesheet" href="${resource(dir:'css',file:'datepicker.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap-image-gallery.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'sistat.atendimento.show.print.css')}" media="print" />


</head>
<body>

	<div id="content-header">
		<h1>
			Visualiza&ccedil;&atilde;o de atendimentos -
			${fieldValue(bean: ordemServicoInstance, field: "numero")}/${fieldValue(bean: ordemServicoInstance, field: "barra")}
		</h1>

		<div class="btn-group" style="width: auto;">
			<a class="btn btn-large tip-bottom" data-original-title="Ver Mapa" href="#myModal" data-toggle="modal" id='btnMapa'><i class="icon-globe"></i></a>
			<g:if test="${session?.user?.admin}">
				<g:link action="edit" id="${ordemServicoInstance.id}" class="btn btn-large tip-bottom" data-original-title="Editar">
					<i class="icon-edit"></i>
				</g:link>
			</g:if>
			<a class="btn btn-large tip-bottom" data-original-title="Imprimir" data-toggle="modal" id='btnPrint' onclick="window.print();"><i class="icon-print"></i></a>
			<g:if test="${ordemServicoInstance.status!='cancelado' && ordemServicoInstance.status!='fechada' && ordemServicoInstance.status!='aguardando pagamento' && ordemServicoInstance.status!='liquidada'}">
				<a class="btn btn-danger btn-large tip-left" data-original-title="Cancelar atendimento"><i class="icon-trash icon-white"></i></a>
			</g:if>
		</div>


	</div>
	<div id="breadcrumb">
		<a href="/" title="P&aacute;gina inicial" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Atendimentos</a> <a href="#" class="current">Visualiza&ccedil;&atilde;o</a>
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

				<div class="widget-box">
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
							<label class="control-label atendimento-dados-label">Data do acionamento:</label>
							<div class="atendimento-dados">
								<g:formatDate date="${ordemServicoInstance?.dataAcionamento}" format="dd/MM/yyyy" />
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



				<g:if test="${!session?.user?.tecnico}">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-th-list"></i>
							</span>
							<h5>Dados do atendimento</h5>

						</div>
						<div class="widget-content nopadding form-horizontal">

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
								<label class="control-label atendimento-dados-label">Avalia&ccedil;&atilde;o:</label>
								<div class="atendimento-dados">
									${fieldValue(bean: ordemServicoInstance, field: "avaliacao")}
								</div>
							</div>
							<div class="control-group">
								<label class="control-label atendimento-dados-label">Diagn&oacute;stico:</label>
								<div class="atendimento-dados">
									${fieldValue(bean: ordemServicoInstance, field: "diagnostico")}
								</div>
							</div>
							<div class="control-group">
								<label class="control-label atendimento-dados-label">Servi&ccedil;o executado:</label>
								<div class="atendimento-dados">
									${ordemServicoInstance?.servicoExecutado?.encodeAsHTML()}
								</div>
							</div>
							<div class="control-group">
								<label class="control-label atendimento-dados-label">Parecer:</label>
								<div class="atendimento-dados">
									${fieldValue(bean: ordemServicoInstance, field: "parecer")}
								</div>
							</div>
							<div class="control-group">
								<label class="control-label atendimento-dados-label">Lote de pagamento:</label>
								<div class="atendimento-dados">
									<g:formatDate date="${ordemServicoInstance?.dataPagamento}" format="dd/MM/yyyy" />
								</div>
							</div>






							<g:if test="${!session?.user?.tecnico}">
								<div>
									<table class="table table-bordered">
										<thead>
											<tr>
												<th></th>
												<th>Descri&ccedil;&otilde;o</th>
												<th>Valor</th>
											</tr>
										</thead>
										<tfoot>
											<tr>
												<th class="total-label" colspan="2">Total:</th>
												<th class="total-amount"><g:formatNumber number="${ordemServicoInstance.valorTotal}" type="currency" currencyCode="BRL" /></th>
											</tr>
										</tfoot>
										<tbody>
											<tr>
												<td>#1</td>
												<td>Valor da m&atilde;o de obra</td>
												<td><g:formatNumber number="${ordemServicoInstance.valorMDO}" type="currency" currencyCode="BRL" /></td>
											</tr>
											<tr>
												<td>#2</td>
												<td>Valor do material</td>
												<td><g:formatNumber number="${ordemServicoInstance.valorMaterial}" type="currency" currencyCode="BRL" /></td>
											</tr>
											<tr>
												<td>#3</td>
												<td>Valor do deslocamento</td>
												<td><g:formatNumber number="${ordemServicoInstance.valorDeslocamento}" type="currency" currencyCode="BRL" /></td>
											</tr>
										</tbody>
									</table>
								</div>
							</g:if>



						</div>

					</div>
				</g:if>

				<g:if test="${!session?.user?.tecnico}">
					<g:render template="historicosTemplate" bean="${ordemServicoInstance}" var="ordemServicoInstance" />
				</g:if>

				<g:if test="${session?.user?.admin}">
					<g:render template="materiaisTemplate" bean="${ordemServicoInstance}" var="ordemServicoInstance" />
				</g:if>

				<g:if test="${ordemServicoInstance?.imagens}">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-picture"></i>
							</span>
							<h5>Registros Fotográficos</h5>
							<div class="buttons">
								<a href="#collapseGallery" data-toggle="collapse" id="collapseGal"><i class="icon-plus"></i></a>
							</div>
						</div>
						<div class="collapse" id="collapseGallery">
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

				<g:if test="${session?.user?.admin}">
					<div class="alert alert-success alert-block">
						<h4 class="alert-heading">Registros</h4>
						<br>
						${ordemServicoInstance.logs}
					</div>
				</g:if>




				<g:javascript library="load-image" />
				<g:javascript library="bootstrap-image-gallery" />

				<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
				<script type="text/javascript">
					$('#btnMapa')
							.click(
									function() {

										var geocoder = new google.maps.Geocoder();

										var locationLatLong = JSON.parse("["
												+ $('#geometryLocation').val()
												+ "]");

										var latlng = new google.maps.LatLng(
												locationLatLong[0],
												locationLatLong[1]);

										var myOptions = {
											zoom : 20,
											center : latlng,
											mapTypeId : google.maps.MapTypeId.ROADMAP
										};

										var map = new google.maps.Map(document
												.getElementById("map_canvas"),
												myOptions);

										var marker = new google.maps.Marker({
											position : latlng,
											map : map,
											title : "2200115544"
										});

										$('#map_canvas').show();

									});
				</script>

				<div id="myModal" class="modal hide">
					<div class="modal-header">
						<button data-dismiss="modal" class="close" type="button">×</button>
						<h5>Mapa</h5>
					</div>
					<div class="modal-body">
						<div id="map_canvas" style="width: 530px; height: 400px; display: none;"></div>

					</div>
					<div class="modal-footer">
						<a data-dismiss="modal" class="btn" href="#">Fechar</a>
					</div>
				</div>


			</div>
		</div>
	</div>

</body>
</html>

