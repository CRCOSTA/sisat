
<%@ page import="model.OrdemServico" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="logged" />
        <title>Fotos do atendimento</title>
        
        <link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'uploadify.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap-image-gallery.css')}" />
		
        
    </head>
    <body>
     <div id="content-header">
		<h1>Fotos do atendimento</h1>
				
	</div>
    <div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a>
		<a href="#" class="tip-bottom">Atendimentos</a>
		<a href="#" class="tip-bottom">Pesquisar</a>
		<a href="#" class="current">Fechamento</a>
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
	        <a class="btn btn-danger"><i class="icon-trash icon-white"></i> Remover</a>
	    </div>
	</div>
    
    <div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<g:hasErrors bean="${ordemServicoInstance}">
					<div class="alert alert-error">
						<button class="close" data-dismiss="alert">×</button>
						<strong>Erro!</strong> <br>    <g:renderErrors bean="${ordemServicoInstance}" as="list" />
					</div>
				</g:hasErrors>
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon">
							<i class="icon-align-justify"></i>									
						</span>
						<h5>Fotos do atendimento</h5>
					</div>
					<div class="widget-content nopadding">
    			        <g:form action="save" method="post" controller="imagem" class="form-horizontal" novalidate="novalidate" enctype="multipart/form-data">
	              			 <g:hiddenField name="id" id="id" value="${ordemServicoInstance?.id}" />
	              			 <div class="control-group">
	                             <label class="control-label">N&uacute;mero</label>
	                             <div class="controls">
	                                  ${fieldValue(bean: ordemServicoInstance, field: "numero")}/${fieldValue(bean: ordemServicoInstance, field: "barra")}
	                             </div>
	                         </div>
	                          <div class="control-group">
	                             <label class="control-label">Seguradora </label>
	                             <div class="controls">
									  ${ordemServicoInstance?.seguradora?.encodeAsHTML()}
	                             </div>
	                         </div>
							<div class="control-group">
	                             <label class="control-label">Data atendimento </label>
	                             <div class="controls">
									 <g:formatDate date="${ordemServicoInstance?.dataAtendimento}" format="dd/MM/yyyy" /> de: ${ordemServicoInstance?.previaInicial} até: ${ordemServicoInstance?.previaFinal}
	                             </div>
	                         </div>
							<div class="control-group">
	                             <label class="control-label">Modalidade </label>
	                             <div class="controls">
									 ${fieldValue(bean: ordemServicoInstance, field: "modalidade")}
	                             </div>
	                         </div>
							<div class="control-group">
	                             <label class="control-label">Descri&ccedil;&atilde;o do servi&ccedil;o </label>
	                             <div class="controls">
									${ordemServicoInstance?.descServico?.encodeAsHTML()}
	                             </div>
	                         </div>
							<div class="control-group">
	                             <label class="control-label">Data Hora Chegada </label>
	                             <div class="controls">
									<g:formatDate date="${ordemServicoInstance?.chegada}" format="dd/MM/yyyy hh:mm" />
	                             </div>
	                         </div>

	                         <div class="control-group">
	                             <label class="control-label"> Fotos 1: </label>
	                             <div class="controls">
														
			
			<input type="file" name="foto1" id="fotoFile"/>
	                             </div>
	                         </div>
	                         
	                         <div class="form-actions">
								<input type="submit" value="Salvar" id="create" class="btn btn-primary">
							</div>
	                         </g:form>
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
				
		</div>
	</div>

	<g:javascript library="load-image" /> 
	<g:javascript library="bootstrap-image-gallery" />
	<g:javascript library="bootstrap-datepicker" />
	<g:javascript library="jquery.ui.custom" />
	<g:javascript library="jquery.uploadify-3.1" />
	
	 <script type="text/javascript">
    $(function() {
        $('#fotoFile').uploadify({
        	'formData' : {id:$('#id').val()},
            'swf'      : '/SISAT/images/uploadify.swf',
            'uploader' : '/SISAT/imagem/upload',
            'uploadLimit' : 8,
            'queueSizeLimit' : 8,
            'buttonText' : 'Selecionar Arquivos',
            'width'    : 150
            // Your options here
        });
    });
    </script>
    </body>
</html>
