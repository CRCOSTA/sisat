
<%@ page import="model.OrdemServico" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="logged" />
        <title>Visualiza&ccedil;&atilde;o de Atendimentos</title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'datepicker.css')}" />
		<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
		<link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap-image-gallery.css')}" />
		
    </head>
    <body>
       
    <div id="content-header">
		<h1>Visualiza&ccedil;&atilde;o de atendimentos</h1>
				
	</div>
    <div id="breadcrumb">
			<a href="/" title="P&aacute;gina inicial" class="tip-bottom"><i class="icon-home"></i> Home</a>
			<a href="#" class="tip-bottom">Atendimentos</a>
			<a href="#" class="current">Visualiza&ccedil;&atilde;o</a>
	</div>
	
	<div id="modal-gallery" class="modal modal-gallery hide fade" tabindex="-1">
	    <div class="modal-header">
	        <a class="close" data-dismiss="modal">&times;</a>
	        <h3 class="modal-title"></h3>
	    </div>
	    <div class="modal-body"><div class="modal-image"></div></div>
	    <div class="modal-footer">
	        <a class="btn btn-primary modal-next">Pr&oacute;ximo <i class="icon-arrow-right icon-white"></i></a>
	        <a class="btn btn-info modal-prev"><i class="icon-arrow-left icon-white"></i> Anterior</a>
	    </div>
	</div>
	
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
			<g:form>
                <g:hiddenField name="id" value="${ordemServicoInstance?.id}" />
            	<g:hiddenField  name="geometryLocation" id="geometryLocation" value="${ordemServicoInstance?.geometryLocation}" />
               
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon">
							<i class="icon-th-list"></i>
						</span>
						<h5>Atendimento</h5>
						<div class="buttons">
						 	<g:link  action="edit" id="${ordemServicoInstance.id}" title="Editar atendimento" class="btn btn-mini">
								<i class="icon-edit"></i> Editar
							</g:link>
							<a title="Imprimir atendimento" class="btn btn-mini" href="#"><i class="icon-print"></i> Imprimir</a>
						</div>
					</div>
					<div class="widget-content">
						<div class="invoice-content">
							<div class="invoice-meta">
									N&uacute;mero do Atendimento: 
									<span class="invoice-number">
										<strong>${fieldValue(bean: ordemServicoInstance, field: "numero")}/${fieldValue(bean: ordemServicoInstance, field: "barra")}  
										 <g:if test="${ordemServicoInstance?.visitaPerdida}">(Visita Perdida)</g:if>
          									   - ${fieldValue(bean: ordemServicoInstance, field: "status")}</strong>
									</span>
									<span class="invoice-date">Data do atendimento: <g:formatDate date="${ordemServicoInstance?.dataAtendimento}" format="dd/MM/yyyy" /> de: ${ordemServicoInstance?.previaInicial} até: ${ordemServicoInstance?.previaFinal}</span>
								</div>
							<div class="row-fluid">
								<div class="alert alert-info alert-block">
									<h4 class="alert-heading">Dados do acionamento</h4>
									<div>
										<ul>
										<li>
											<span><br clear="all">Modalidade: ${fieldValue(bean: ordemServicoInstance, field: "modalidade")} - ${ordemServicoInstance?.funcionario?.encodeAsHTML()}</span>
										</li>
										<li>
											<span>Empresa: ${ordemServicoInstance?.seguradora?.encodeAsHTML()} - ${ordemServicoInstance?.empresa?.encodeAsHTML()}</span>
										</li>
										<li>
											<span>Segurado: ${fieldValue(bean: ordemServicoInstance, field: "segurado")}</span>
										</li>
										<li>
											<span>Endere&ccedil;o: ${fieldValue(bean: ordemServicoInstance, field: "endereco")}</span>
										</li>
										<li>
											<span>Cidade: ${fieldValue(bean: ordemServicoInstance, field: "cidade")}</span>
										</li>
										<li>
											<span>Bairro: ${ordemServicoInstance?.bairro?.encodeAsHTML()}</span>
										</li>
										<li>
											<span>Refer&ecirc;cia: ${fieldValue(bean: ordemServicoInstance, field: "referencia")}</span>
										</li>
										<li>
											<span>Data do acionamento:<g:formatDate date="${ordemServicoInstance?.dataAcionamento}" format="dd/MM/yyyy"/></span>
										</li>
										<li>
											<span>Evento: ${fieldValue(bean: ordemServicoInstance, field: "evento")}</span>
										</li>
										<li>
											<span>Descri&ccedil;&atilde;o:${fieldValue(bean: ordemServicoInstance, field: "descServico")}</span>
										</li>
										
										</ul>
									</div>
								</div>	
								<div class="alert alert-success alert-block">
									<g:if test="${!session?.user?.tecnico}">
										<h4 class="alert-heading">Dados do atendimento</h4>
										<div >
											<ul>
											<li>
												<span><br clear="all">Chegada:<g:formatDate date="${ordemServicoInstance?.chegada}" format="dd/MM/yyyy HH:mm" />  Saida: <g:formatDate date="${ordemServicoInstance?.saida}" format="dd/MM/yyyy HH:mm" /> </span>
											</li>
											<li>
												<span>Senha: ${fieldValue(bean: ordemServicoInstance, field: "senha")}</span>
											</li>
											<li>
												<span>Avalia&ccedil;&atilde;o:${fieldValue(bean: ordemServicoInstance, field: "avaliacao")}</span>
											</li>
											<li>
												<span>Diagn&oacute;stico:${fieldValue(bean: ordemServicoInstance, field: "diagnostico")}</span>
											</li>
											<li>
												<span>Servi&ccedil;o executado:${ordemServicoInstance?.servicoExecutado?.encodeAsHTML()}</span>
											</li>
											<li>
												<span>Parecer: ${fieldValue(bean: ordemServicoInstance, field: "parecer")}</span>
											</li>
											<li>
												<span>Data do lote de pagamento: <g:formatDate date="${ordemServicoInstance?.dataPagamento}" format="dd/MM/yyyy" /></span>
											</li>
											
											
											</ul>
										</div>
									</g:if>
								</div>
								<g:if test="${!session?.user?.tecnico}">
									<div class="alert alert-success alert-block">
										<h4 class="alert-heading">Hist&oacute;rico</h4>
										<br>${ordemServicoInstance.historicos}
									</div>
								</g:if>
								
								<g:if test="${session?.user?.admin}">
									<div class="alert alert-success alert-block">
										<h4 class="alert-heading">Registros</h4>
										<br>${ordemServicoInstance.logs}
									</div>
				                </g:if>
								
							</div>
							
							<g:if test="${session?.user?.admin}">
								<div>
										<table class="table table-bordered">
										<thead>
										<tr>
											<th>
												 
											</th>
											<th>
												 Descri&ccedil;&otilde;o
											</th>
											<th>
												 Quantidade
											</th>
										</tr>
										</thead>
										<tfoot>
										<tr>
											<th class="total-label" colspan="3">
											</th>
										</tr>
										</tfoot>
										<tbody>
										<g:each in="${ordemServicoInstance?.materiais}" status="i" var="material">
	    					
											<tr>
												<td>
													${material.descricao}
												</td>
												<td>
													 ${material.material.descricao}
												</td>
												<td>
 													${material.material.descricao}
 												</td>
											</tr>
										</g:each>
										</tbody>
										</table>
								</div>
							</g:if>
							<g:if test="${!session?.user?.tecnico}">
								<div>
										<table class="table table-bordered">
										<thead>
										<tr>
											<th>
												 
											</th>
											<th>
												 Descri&ccedil;&otilde;o
											</th>
											<th>
												 Valor
											</th>
										</tr>
										</thead>
										<tfoot>
										<tr>
											<th class="total-label" colspan="2">
												 Total:
											</th>
											<th class="total-amount">
											<g:formatNumber number="${ordemServicoInstance.valorTotal}" type="currency" currencyCode="BRL"/>
												
											</th>
										</tr>
										</tfoot>
										<tbody>
										<tr>
											<td>
												 #1
											</td>
											<td>
												 Valor da m&atilde;o de obra
											</td>
											<td>
												<g:formatNumber number="${ordemServicoInstance.valorMDO}" type="currency" currencyCode="BRL"/>
											</td>
										</tr>
										<tr>
											<td>
												 #2
											</td>
											<td>
												 Valor do material
											</td>
											<td>
												<g:formatNumber number="${ordemServicoInstance.valorMaterial}" type="currency" currencyCode="BRL"/>
	
											</td>
										</tr>
										<tr>
											<td>
												 #3
											</td>
											<td>
												 Valor do deslocamento
											</td>
											<td>
												 <g:formatNumber number="${ordemServicoInstance.valorDeslocamento}" type="currency" currencyCode="BRL"/>
											</td>
										</tr>
										</tbody>
										</table>
								</div>
							</g:if>
							
						
							
						</div>
					</div>
					
				</div>
				<g:if test="${ordemServicoInstance?.imagens}">
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon">
							<i class="icon-picture"></i>
						</span>
						<h5>Registros Fotográficos</h5>
					</div>
					<div class="widget-content">
						<ul class="thumbnails" id="gallery" data-toggle="modal-gallery" data-target="#modal-gallery">
						  <g:each in="${ordemServicoInstance?.imagens}" status="i" var="imagem">
								<li class="span2">
									<a  href="${session.siteConfig.imgUrl}${ordemServicoInstance?.id}/${imagem?.nomeImagem}"  class="thumbnail" data-gallery="gallery">
										<img src="${session.siteConfig.imgUrl}${ordemServicoInstance?.id}/thumb_${imagem?.nomeImagem}">
									</a>
								</li>
						  </g:each>
						</ul>
					</div>
				</div>
				</g:if>
				
				
				
			
			</g:form>
			</div>
		</div>
	</div>

        <g:javascript library="load-image" /> 
		<g:javascript library="bootstrap-image-gallery" /> 
    </body>
</html>

